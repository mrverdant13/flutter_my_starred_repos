part of 'profile.cubit.dart';

@freezed
class ProfileState with _$ProfileState {
  // coverage:ignore-start
  const factory ProfileState.loading({
    required Profile profile,
  }) = _ProfileStateLoading;
  const factory ProfileState.loaded({
    required Profile profile,
  }) = _ProfileStateLoaded;
  const factory ProfileState.failure({
    required Profile profile,
    required GetProfileFailure failure,
  }) = _ProfileStateFailure;
  // coverage:ignore-end
}

@visibleForTesting
const initialProfile = Profile(username: '', avatarUrl: '');
