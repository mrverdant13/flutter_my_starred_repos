import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:starred_repos/starred_repos.dart';

import '../../auth/core/dependency_injection.dart';
import '../application/starred_repos_cubit/cubit.dart';

final sembastDbPod = Provider<Database>(
  (_) => throw StateError(
    'The Sembast database has not been initialized',
  ),
);

final pageEtagsStoragePod = Provider<PageEtagsStorage>(
  (ref) => PageEtagsStorage(
    sembastDatabase: ref.watch(sembastDbPod),
  ),
);

final etagsInterceptorPod = Provider<EtagsInterceptor>(
  (ref) => EtagsInterceptor(
    pageEtagsStorage: ref.watch(pageEtagsStoragePod),
  ),
);

final starredReposDioPod = Provider<Dio>(
  (ref) => Dio()
    ..interceptors.addAll([
      ref.watch(authInterceptorPod),
      ref.watch(etagsInterceptorPod),
    ]),
);

final starredReposApiPod = Provider<StarredReposApi>(
  (ref) => StarredReposApi(
    dio: ref.watch(starredReposDioPod),
  ),
);

final starredReposStoragePod = Provider<StarredReposStorage>(
  (ref) => StarredReposStorage(
    sembastDatabase: ref.watch(sembastDbPod),
  ),
);

final starredReposRepoPod = Provider<StarredReposRepo>(
  (ref) => StarredReposRepo(
    starredReposApi: ref.watch(starredReposApiPod),
    starredReposStorage: ref.watch(starredReposStoragePod),
  ),
);

final starredReposCubitPod = Provider<StarredReposCubit>(
  (ref) => StarredReposCubit(
    starredReposRepo: ref.watch(starredReposRepoPod),
  ),
);

Future<List<Override>> getInjectionOverrides() async {
  final dbDir = await getApplicationDocumentsDirectory();
  await dbDir.create(recursive: true);
  final dbPath = path.join(dbDir.path, 'my_database.db');
  final sembastDb = await databaseFactoryIo.openDatabase(dbPath);
  return [sembastDbPod.overrideWithValue(sembastDb)];
}
