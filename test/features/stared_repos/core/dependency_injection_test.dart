import 'package:auth/auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter_my_starred_repos/features/auth/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/core/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:sembast/sembast.dart';
import 'package:starred_repos/starred_repos.dart';
import 'package:test/test.dart';

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationDocumentsPath() async =>
      // Directory not tracked.
      'coverage/application_documents_path';
}

class MockSembastDb extends Mock implements Database {}

class MockAuthInterceptor extends Fake implements AuthInterceptor {}

void main() {
  group(
    '''

GIVEN a depencencies container''',
    () {
      test(
        '''

AND no interaction
WHEN the Sembast database is accessed
THEN an exception is thrown
├─ THAT indicates that the database has not been initialized
''',
        () {
          // ARRANGE
          final container = ProviderContainer();

          // ACT
          Database action() => container.read(sembastDbPod);

          // ASSERT
          expect(
            action,
            throwsA(
              predicate(
                (e) => e is ProviderException && e.exception is StateError,
              ),
            ),
          );
        },
      );

      group(
        '''

AND a previously injected auth interceptor
AND an injection overrides getter function
├─ THAT overrides the Sembast database injection
WHEN the injection process is triggered''',
        () {
          // ARRANGE
          late ProviderContainer container;

          setUp(
            () async {
              // ARRANGE
              final preconditionalOverrides = [
                authInterceptorPod.overrideWithValue(MockAuthInterceptor()),
              ];
              PathProviderPlatform.instance = FakePathProviderPlatform();

              // ACT
              final overrides = await getInjectionOverrides();
              container = ProviderContainer(
                overrides: [
                  ...preconditionalOverrides,
                  ...overrides,
                ],
              );
            },
          );

          test(
            '''

THEN the necessary starred-repos-related dependencies should be injected
├─ BY  injecting a single Sembast database
├─ AND injecting a single pages ETags local data source
├─ AND injecting a single ETags interceptor
├─ AND injecting a single Dio HTTP client
├─ AND injecting a single starred repos remote data source
├─ AND injecting a single starred repos local data source
├─ AND injecting a single starred repos repository
├─ AND injecting a single starred repos cubit
''',
            () async {
              // ASSERT
              expect(
                container.read(sembastDbPod),
                isA<Database>(),
              );
              expect(
                container.read(starredReposPageEtagsStoragePod),
                isA<StarredReposPageEtagsStorage>(),
              );
              expect(
                container.read(etagsInterceptorPod),
                isA<StarredReposPageEtagsInterceptor>(),
              );
              expect(
                container.read(starredReposDioPod),
                isA<Dio>(),
              );
              expect(
                container.read(starredReposApiPod),
                isA<StarredReposApi>(),
              );
              expect(
                container.read(starredReposStoragePod),
                isA<StarredReposStorage>(),
              );
              expect(
                container.read(starredReposRepoPod),
                isA<StarredReposRepo>(),
              );
              expect(
                container.read(starredReposCubitPod),
                isA<StarredReposCubit>(),
              );
            },
          );
        },
      );
    },
  );
}
