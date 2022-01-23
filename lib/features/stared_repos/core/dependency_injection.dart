import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:starred_repos/starred_repos.dart';

import '../../auth/core/dependency_injection.dart';
import '../application/starred_repos_cubit/cubit.dart';
import '../infrastructure/external/etags_dio_interceptor.dart';
import '../infrastructure/facades/starred_repos_repo/implementation.dart';
import '../infrastructure/facades/starred_repos_repo/interface.dart';

final sembastDbPod = Provider<Database>(
  (_) => throw StateError(
    'The Sembast database has not been initialized',
  ),
);

final pageEtagsStoragePod = Provider<PageEtagsStorage>(
  (ref) {
    final sembastDb = ref.watch(sembastDbPod);
    return PageEtagsStorage(
      sembastDatabase: sembastDb,
    );
  },
);

final etagsInterceptorPod = Provider<EtagsInterceptor>(
  (ref) {
    final pageEtagsStorage = ref.watch(pageEtagsStoragePod);
    return EtagsInterceptor(
      pageEtagsStorage: pageEtagsStorage,
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

final starredReposApiPod = Provider<StarredReposApi>(
  (ref) {
    final dio = ref.watch(starredReposDioPod);
    return StarredReposApi(
      dio: dio,
    );
  },
);

final starredReposStoragePod = Provider<StarredReposStorage>(
  (ref) {
    final sembastDb = ref.watch(sembastDbPod);
    return StarredReposStorage(
      sembastDatabase: sembastDb,
    );
  },
);

final starredReposRepoPod = Provider<StarredReposRepo>(
  (ref) {
    final starredReposStorage = ref.watch(starredReposStoragePod);
    final starredReposApi = ref.watch(starredReposApiPod);
    return StarredReposRepoImp(
      starredReposApi: starredReposApi,
      starredReposStorage: starredReposStorage,
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
