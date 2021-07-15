import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_stared_repos_failure.freezed.dart';

@freezed
class GetStaredReposFailure with _$GetStaredReposFailure {
  const factory GetStaredReposFailure.offline() = _GetStaredReposFailureOffline;
}
