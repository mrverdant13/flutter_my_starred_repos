import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_starred_repos_warnings.freezed.dart';

@freezed
class GetStaredReposWarning with _$GetStaredReposWarning {
  // coverage:ignore-start
  const factory GetStaredReposWarning.offline() = _GetStaredReposWarningOffline;
  // coverage:ignore-end
}
