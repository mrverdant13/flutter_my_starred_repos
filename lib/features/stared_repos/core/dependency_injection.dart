import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../../auth/core/dependency_injection.dart';
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

final sembastDbPod = Provider<Database>(
  (_) => throw StateError(
    'The Sembast database has not been initialized',
  ),
);

final pagesEtagsLDSPod = Provider<PagesEtagsLDS>(
  (ref) {
    final sembastDb = ref.watch(sembastDbPod);
    return PagesEtagsLDSImp(
      sembastDatabase: sembastDb,
    );
  },
);

final etagsInterceptorPod = Provider<EtagsInterceptor>(
  (ref) {
    final pagesEtagsLDS = ref.watch(pagesEtagsLDSPod);
    return EtagsInterceptor(
      pagesEtagsLDS: pagesEtagsLDS,
    );
  },
);

final starredReposDioPod = Provider<Dio>(
  (ref) {
    final authInterceptor = ref.watch(authInterceptorPod);
    final etagsInterceptor = ref.watch(etagsInterceptorPod);
    return Dio()
      ..interceptors.addAll([
        authInterceptor,
        etagsInterceptor,
      ]);
  },
);

final starredReposRDSPod = Provider<StaredReposRDS>(
  (ref) {
    final dio = ref.watch(starredReposDioPod);
    return StaredReposRDSImp(
      dio: dio,
    );
  },
);

final starredReposLDSPod = Provider<StarredReposLDS>(
  (ref) {
    final sembastDb = ref.watch(sembastDbPod);
    return StarredReposLDSImp(
      sembastDatabase: sembastDb,
    );
  },
);

final starredReposRepoPod = Provider<StarredReposRepo>(
  (ref) {
    final starredReposLDS = ref.watch(starredReposLDSPod);
    final starredReposRDS = ref.watch(starredReposRDSPod);
    return StarredReposRepoImp(
      starredReposRDS: starredReposRDS,
      starredReposLDS: starredReposLDS,
    );
  },
);

final starredReposCubitPod = Provider<StarredReposCubit>(
  (ref) {
    final starredReposRepo = ref.watch(starredReposRepoPod);
    return StarredReposCubit(
      starredReposRepo: starredReposRepo,
    );
  },
);

Future<List<Override>> getInjectionOverrides() async {
  final dbDir = await getApplicationDocumentsDirectory();
  await dbDir.create(recursive: true);
  final dbPath = path.join(dbDir.path, 'my_database.db');
  final sembastDb = await databaseFactoryIo.openDatabase(dbPath);
  return [sembastDbPod.overrideWithValue(sembastDb)];
}
