import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:profile/src/domain/profile.entity.dart';
import 'package:profile/src/infrastructure/profile.repo.dart';
import 'package:state_notifier/state_notifier.dart';

part 'profile.notifier.freezed.dart';
part 'profile.state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier({
    required ProfileRepo profileRepo,
  })  : _profileRepo = profileRepo,
        super(const ProfileState.loading(profile: initialProfile));

  final ProfileRepo _profileRepo;

  StreamSubscription<Profile>? _profileSubscription;

  Future<void> watchProfile() async {
    state = ProfileState.loading(profile: state.profile);
    _profileSubscription?.cancel();
    _profileSubscription = _profileRepo.watchProfile().listen(
          (profile) => state = ProfileState.loaded(
            profile: profile,
          ),
        );
  }

  Future<void> refreshProfile() async {
    state = ProfileState.loading(profile: state.profile);
    final result = await _profileRepo.refreshProfile();
    result.when(
      ok: (_) {},
      err: (failure) => state = ProfileState.failure(
        profile: state.profile,
        failure: failure,
      ),
    );
  }

  @override
  Future<void> dispose() async {
    await _profileSubscription?.cancel();
    return super.dispose();
  }
}
