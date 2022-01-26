part of 'profile.cubit.dart';

@freezed
class ProfileState with _$ProfileState {
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
}
