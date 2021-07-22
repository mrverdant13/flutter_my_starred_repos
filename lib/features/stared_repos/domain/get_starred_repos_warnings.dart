import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_starred_repos_warnings.freezed.dart';

@freezed
class GetStaredReposWarning with _$GetStaredReposWarning {
  const factory GetStaredReposWarning.offline() = _GetStaredReposWarningOffline;
}
