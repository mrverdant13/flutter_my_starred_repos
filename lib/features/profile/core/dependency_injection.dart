import 'package:flutter_my_starred_repos/core/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:profile/profile.dart';

final profileApiPod = Provider(
  (ref) => ProfileApi(
    gqlClient: ref.watch(gqlClientPod),
    dio: ref.watch(dioPod),
  ),
);

final profileRepoPod = Provider(
  (ref) => ProfileRepo(
    profileApi: ref.watch(profileApiPod),
  ),
);

final profileCubitPod = Provider.autoDispose((ref) {
  final cubit = ProfileCubit(
    profileRepo: ref.watch(profileRepoPod),
  );
  ref.onDispose(() => cubit.close());
  return cubit;
});
