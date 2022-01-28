import 'package:auth/src/infrastructure/creds.storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oauth2/oauth2.dart';
import 'package:test/test.dart';

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
            (_) async {},
          );

          // ACT
          await credsStorage.clear();

          // ASSERT
          verify(
            () => mockFlutterSecureStorage.delete(
              key: CredsStorage.credsKey,
            ),
          ).called(1);
          expect(credsStorage.creds, isNull);
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
            (_) async {},
          );

          // ACT
          await credsStorage.set(creds);

          // ASSERT
          verify(
            () => mockFlutterSecureStorage.write(
              key: CredsStorage.credsKey,
              value: creds.toJson(),
            ),
          ).called(1);
          expect(credsStorage.creds, creds);
        },
      );

      test(
        '''

├─ AND cached credentials
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

├─ AND persisted credentials
├─ AND no cached credentials
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

          verify(
            () => mockFlutterSecureStorage.read(
              key: CredsStorage.credsKey,
            ),
          ).called(1);

          // Comparing creds JSON string as it is saver and avoids reference
          // comparisons.
          expect(credsStorage.creds, isNotNull);
          expect(credsStorage.creds!.toJson(), resultingCredsJson);
          expect(result, isNotNull);
          expect(result!.toJson(), resultingCredsJson);
        },
      );
    },
  );
}
