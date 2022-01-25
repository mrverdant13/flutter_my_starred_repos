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

  Future<void> getProfile() async {
    emit(const ProfileState.loading());
    final result = await _profileRepo.getProfile();
    emit(
      result.when(
        ok: (profile) => ProfileState.loaded(profile: profile),
        err: (failure) => ProfileState.failure(failure: failure),
      ),
    );
  }
}
