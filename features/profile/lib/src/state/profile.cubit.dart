import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:profile/src/domain/profile.entity.dart';
import 'package:profile/src/infrastructure/profile.repo.dart';

part 'profile.cubit.freezed.dart';
part 'profile.state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required ProfileRepo profileRepo,
  })  : _profileRepo = profileRepo,
        super(const ProfileState.loading());

  final ProfileRepo _profileRepo;

  StreamSubscription<Profile>? _profileSubscription;

  Future<void> watchProfile() async {
    emit(const ProfileState.loading());
    _profileSubscription?.cancel();
    _profileSubscription = _profileRepo.watchProfile().listen(
          (profile) => emit(
            ProfileState.loaded(
              profile: profile,
            ),
          ),
        );
  }

  Future<void> refreshProfile() async {
    emit(const ProfileState.loading());
    final result = await _profileRepo.refreshProfile();
    result.when(
      ok: (_) {},
      err: (failure) => emit(ProfileState.failure(failure: failure)),
    );
  }

  @override
  Future<void> close() async {
    await _profileSubscription?.cancel();
    return super.close();
  }
}
