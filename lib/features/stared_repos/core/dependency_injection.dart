import 'package:dio/dio.dart';

import '../../../core/dependency_injection.dart';
import '../../auth/infrastructure/external/dio_interceptors.dart';
import '../application/starred_repos_cubit/cubit.dart';
import '../infrastructure/data_sources/stared_repos_rds/interface.dart';
import '../infrastructure/data_sources/stared_repos_rds/rest_implementation.dart';
import '../infrastructure/facades/starred_repos_repo/implementation.dart';
import '../infrastructure/facades/starred_repos_repo/interface.dart';

const starredRepoDioName = 'starred_repos_dio';

/// Injects all instances required for starred repos funcionality.
Future<void> injectDependencies() async {
  // External
  getIt.registerLazySingleton(
    () => Dio()
      ..interceptors.add(
        getIt<AuthInterceptor>(),
      ),
    instanceName: starredRepoDioName,
  );

  // Data sources
  getIt.registerLazySingleton<StaredReposRDS>(
    () => StaredReposRDSImp(
      dio: getIt(
        instanceName: starredRepoDioName,
      ),
    ),
  );

  // Facades
  getIt.registerLazySingleton<StarredReposRepo>(
    () => StarredReposRepoImp(
      starredReposRDS: getIt(),
    ),
  );

  // State managers
  getIt.registerFactory(
    () => StarredReposCubit(
      starredReposRepo: getIt(),
    ),
  );
}
