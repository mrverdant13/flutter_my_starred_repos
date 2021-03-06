import 'package:flutter_my_starred_repos/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/core/dependency_injection.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:profile/profile.dart';

final profileApiPod = Provider(
  (ref) => ProfileApi(
    gqlClient: ref.watch(gqlClientPod),
    dio: ref.watch(dioPod),
  ),
);

final profileStoragePod = Provider(
  (ref) => ProfileStorage(
    sembastDatabase: ref.watch(sembastDbPod),
  ),
);

final profileRepoPod = Provider(
  (ref) => ProfileRepo(
    profileApi: ref.watch(profileApiPod),
    profileStorage: ref.watch(profileStoragePod),
  ),
);

final profileNotifierPod =
    StateNotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
  (ref) {
    final notifier = ProfileNotifier(
      profileRepo: ref.watch(profileRepoPod),
    );
    ref.onDispose(() => notifier.dispose());
    return notifier;
  },
);
