import 'package:dio/dio.dart';
import 'package:flutter_my_starred_repos/features/auth/infrastructure/external/dio_interceptors.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/application/starred_repos_cubit/cubit.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/data_sources/stared_repos_rds/interface.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/data_sources/starred_repos_lds/interface.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/facades/starred_repos_repo/interface.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAuthInterceptor extends Fake implements AuthInterceptor {}

void main() {
  group(
    '''

GIVEN an injector function
AND a previously injected auth interceptor
WHEN the injection process is triggered''',
    () {
      final getIt = GetIt.instance;

      setUp(
        () async {
          // ARRANGE
          await getIt.reset();
          getIt.registerLazySingleton<AuthInterceptor>(
            () => MockAuthInterceptor(),
          );

          // ACT
          await injectDependencies();
        },
      );
      test(
        '''

THEN the necessary starred-repos-related dependencies should be injected
├─ BY  injecting a single Dio HTTP client
│  ├─ THAT is identified by its instance name
├─ AND injecting a single starred repos local data source
├─ AND injecting a single starred repos remote data source
├─ AND injecting a single starred repos repository
├─ AND injecting a starred repos cubit factory
''',
        () async {
          // ASSERT
          expect(
            getIt<Dio>(instanceName: starredRepoDioName),
            getIt<Dio>(instanceName: starredRepoDioName),
          );
          expect(
            getIt<StarredReposLDS>(),
            getIt<StarredReposLDS>(),
          );
          expect(
            getIt<StaredReposRDS>(),
            getIt<StaredReposRDS>(),
          );
          expect(
            getIt<StarredReposRepo>(),
            getIt<StarredReposRepo>(),
          );
          expect(
            getIt<StarredReposCubit>(),
            isA<StarredReposCubit>(),
          );
        },
      );
    },
  );
}
