import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:starred_repos/starred_repos.dart';

import '../../auth/core/dependency_injection.dart';

final sembastDbPod = Provider<Database>(
  (_) => throw StateError(
    'The Sembast database has not been initialized',
  ),
);

final starredReposPageEtagsStoragePod = Provider<StarredReposPageEtagsStorage>(
  (ref) => StarredReposPageEtagsStorage(
    sembastDatabase: ref.watch(sembastDbPod),
  ),
);

final etagsInterceptorPod = Provider<StarredReposPageEtagsInterceptor>(
  (ref) => StarredReposPageEtagsInterceptor(
    starredReposPageEtagsStorage: ref.watch(starredReposPageEtagsStoragePod),
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

final starredReposCubitPod = Provider.autoDispose<StarredReposCubit>(
  (ref) {
    final cubit = StarredReposCubit(
      starredReposRepo: ref.watch(starredReposRepoPod),
    );
    ref.onDispose(() => cubit.close());
    return cubit;
  },
);

Future<List<Override>> getInjectionOverrides() async {
  final dbDir = await getApplicationDocumentsDirectory();
  await dbDir.create(recursive: true);
  final dbPath = path.join(dbDir.path, 'my_database.db');
  final sembastDb = await databaseFactoryIo.openDatabase(dbPath);
  return [sembastDbPod.overrideWithValue(sembastDb)];
}
