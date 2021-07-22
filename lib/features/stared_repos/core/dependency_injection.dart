import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../../../core/dependency_injection.dart';
import '../../auth/infrastructure/external/dio_interceptors.dart';
import '../application/starred_repos_cubit/cubit.dart';
import '../infrastructure/data_sources/etags_lds/interface.dart';
import '../infrastructure/data_sources/etags_lds/sembast_implementation.dart';
import '../infrastructure/data_sources/stared_repos_rds/interface.dart';
import '../infrastructure/data_sources/stared_repos_rds/rest_implementation.dart';
import '../infrastructure/data_sources/starred_repos_lds/interface.dart';
import '../infrastructure/data_sources/starred_repos_lds/sembast_implementation.dart';
import '../infrastructure/external/etags_dio_interceptor.dart';
import '../infrastructure/facades/starred_repos_repo/implementation.dart';
import '../infrastructure/facades/starred_repos_repo/interface.dart';

@visibleForTesting
const starredRepoDioName = 'starred_repos_dio';

/// Injects all instances required for starred repos funcionality.
Future<void> injectDependencies() async {
  // Setup
  final dbDir = await getApplicationDocumentsDirectory();
  await dbDir.create(recursive: true);
  final dbPath = path.join(dbDir.path, 'my_database.db');
  final db = await databaseFactoryIo.openDatabase(dbPath);

  // External
  getIt.registerLazySingleton<EtagsInterceptor>(
    () => EtagsInterceptor(
      pagesEtagsLDS: getIt(),
    ),
  );
  getIt.registerLazySingleton<Database>(
    () => db,
  );
  getIt.registerLazySingleton(
    () => Dio()
      ..interceptors.addAll([
        getIt<AuthInterceptor>(),
        getIt<EtagsInterceptor>(),
      ]),
    instanceName: starredRepoDioName,
  );

  // Data sources
  getIt.registerLazySingleton<PagesEtagsLDS>(
    () => PagesEtagsLDSImp(
      sembastDatabase: getIt(),
    ),
  );
  getIt.registerLazySingleton<StarredReposLDS>(
    () => StarredReposLDSImp(
      sembastDatabase: getIt(),
    ),
  );

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
      starredReposLDS: getIt(),
    ),
  );

  // State managers
  getIt.registerFactory(
    () => StarredReposCubit(
      starredReposRepo: getIt(),
    ),
  );
}
