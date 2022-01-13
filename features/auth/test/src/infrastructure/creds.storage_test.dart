import 'package:auth/src/infrastructure/creds.storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oauth2/oauth2.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group(
    '''

GIVEN a credentials storage
├─ THAT uses a Flutter secure storage''',
    () {
      // ARRANGE
      late MockFlutterSecureStorage mockFlutterSecureStorage;
      late CredsStorage credsStorage;

      setUp(
        () {
          mockFlutterSecureStorage = MockFlutterSecureStorage();
          credsStorage = CredsStorage(
            flutterSecureStorage: mockFlutterSecureStorage,
          );
        },
      );

      tearDown(
        () {
          verifyNoMoreInteractions(mockFlutterSecureStorage);
        },
      );

      test(
        '''

WHEN the credentials remotion is requested
THEN any persisted creds should be removed
├─ BY dropping stored creds from the secure storage
├─ AND discarding cached creds
      ''',
        () async {
          // ARRANGE
          when(
            () => mockFlutterSecureStorage.delete(
              key: any(named: 'key'),
            ),
          ).thenAnswer(
            (_) async => 0,
          );

          // ACT
          await credsStorage.clear();

          // ASSERT
          expect(credsStorage.creds, isNull);
          verify(
            () => mockFlutterSecureStorage.delete(
              key: CredsStorage.credsKey,
            ),
          ).called(1);
        },
      );

      test(
        '''

WHEN credentials are passed to be stored
THEN the given credentials should be persisted
├─ BY storing the creds in the secure storage
├─ AND caching the creds in memory
      ''',
        () async {
          // ARRANGE
          const credsJson = '{"accessToken":"qwerty","scopes":[]}';
          final creds = Credentials.fromJson(credsJson);

          when(
            () => mockFlutterSecureStorage.write(
              key: any(named: 'key'),
              value: any(named: 'value'),
            ),
          ).thenAnswer(
            (_) async => 0,
          );

          // ACT
          await credsStorage.set(creds);

          // ASSERT
          expect(credsStorage.creds, creds);
          verify(
            () => mockFlutterSecureStorage.write(
              key: CredsStorage.credsKey,
              value: creds.toJson(),
            ),
          ).called(1);
        },
      );

      test(
        '''

AND cached credentials
WHEN credentials are requested
THEN the cached credentials should be returned
├─ BY not using the secure storage
├─ AND returning the in-memory cached creds
''',
        () async {
          // ARRANGE
          const credsJson = '{"accessToken":"qwerty","scopes":[]}';
          final creds = Credentials.fromJson(credsJson);
          credsStorage.creds = creds;

          // ACT
          final result = await credsStorage.get();

          // ASSERT
          verifyZeroInteractions(mockFlutterSecureStorage);
          expect(result, creds);
        },
      );

      test(
        '''

AND persisted credentials
AND no cached credentials
WHEN credentials are requested
THEN the persisted credentials should be cached and returned
├─ BY retrieving the persisted creds from the secure storage
├─ AND caching the creds in memory
├─ AND returning the creds
''',
        () async {
          // ARRANGE
          const credsJson = '{"accessToken":"qwerty","scopes":[]}';
          final creds = Credentials.fromJson(credsJson);
          final resultingCredsJson = creds.toJson();

          when(
            () => mockFlutterSecureStorage.read(
              key: any(named: 'key'),
            ),
          ).thenAnswer(
            (_) async => credsJson,
          );

          // ACT
          final result = await credsStorage.get();

          // ASSERT

          // Comparing creds JSON string as it is saver and avoids reference
          // comparisons.
          expect(result!.toJson(), resultingCredsJson);
          expect(credsStorage.creds!.toJson(), resultingCredsJson);
          verify(
            () => mockFlutterSecureStorage.read(
              key: CredsStorage.credsKey,
            ),
          ).called(1);
        },
      );
    },
  );
}
