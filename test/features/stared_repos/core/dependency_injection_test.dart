import 'package:dio/dio.dart';
import 'package:flutter_app_template/features/auth/infrastructure/external/dio_interceptors.dart';
import 'package:flutter_app_template/features/stared_repos/application/starred_repos_cubit/cubit.dart';
import 'package:flutter_app_template/features/stared_repos/core/dependency_injection.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/data_sources/stared_repos_rds/interface.dart';
import 'package:flutter_app_template/features/stared_repos/infrastructure/facades/starred_repos_repo/interface.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockAuthInterceptor extends Fake implements AuthInterceptor {}

void main() {
  group(
    '''

GIVEN an injector function
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
  
THEN a single Dio HTTP client should be injected
AND a single starred repos remote data source should be injected
AND a single starred repos repository should be injected
AND a single starred repos cubit should be injected
''',
        () async {
          // ASSERT

          // External
          expect(
            getIt.isRegistered<Dio>(
              instanceName: starredRepoDioName,
            ),
            true,
          );

          // Data sources
          expect(
            getIt.isRegistered<StaredReposRDS>(),
            true,
          );

          // Facades
          expect(
            getIt.isRegistered<StarredReposRepo>(),
            true,
          );

          // State managers
          expect(
            getIt.isRegistered<StarredReposCubit>(),
            true,
          );
        },
      );

      test(
        '''

THEN a single starred repos cubit can be accessed
''',
        () async {
          // ASSERT
          expect(
            getIt.get<StarredReposCubit>(),
            isNotNull,
          );
        },
      );
    },
  );
}
