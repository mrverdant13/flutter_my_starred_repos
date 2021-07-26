import 'package:flutter_my_starred_repos/features/auth/infrastructure/data_sources/creds_storage/flutter_secure_storage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:oauth2/oauth2.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  group(
    '''

GIVEN a credentials storage''',
    () {
      // External dependencies
      late MockFlutterSecureStorage mockFlutterSecureStorage;

      // Remota data source
      late CredsStorageImp credsStorage;

      setUp(
        () {
          mockFlutterSecureStorage = MockFlutterSecureStorage();
          credsStorage = CredsStorageImp(
            flutterSecureStorage: mockFlutterSecureStorage,
          );
        },
      );

      test(
        '''

WHEN the credentials remotion is requested
THEN the stored creds are discarded
AND the cached creds are discarded
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
              key: CredsStorageImp.credsKey,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockFlutterSecureStorage);
        },
      );

      test(
        '''

WHEN credentials are passed to be stored
THEN the given credentials get persisted
AND the given credentials are cached
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
              key: CredsStorageImp.credsKey,
              value: creds.toJson(),
            ),
          ).called(1);
          verifyNoMoreInteractions(mockFlutterSecureStorage);
        },
      );

      test(
        '''

AND cached credentials
WHEN credentials are requested
THEN the cached credentials are returned
''',
        () async {
          // ARRANGE
          const credsJson = '{"accessToken":"qwerty","scopes":[]}';
          final creds = Credentials.fromJson(credsJson);
          credsStorage.creds = creds;

          // ACT
          final result = await credsStorage.get();

          // ASSERT
          expect(result, creds);
        },
      );

      test(
        '''

AND persisted credentials
AND no cached credentials
WHEN credentials are requested
THEN the persisted credentials are cached
AND the peristed credentials are returned
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

          // Comparing creds JSON string as it is saver.
          expect(
            result!.toJson(),
            resultingCredsJson,
          );
          expect(
            credsStorage.creds!.toJson(),
            resultingCredsJson,
          );

          verify(
            () => mockFlutterSecureStorage.read(
              key: CredsStorageImp.credsKey,
            ),
          ).called(1);
          verifyNoMoreInteractions(mockFlutterSecureStorage);
        },
      );
    },
  );
}
