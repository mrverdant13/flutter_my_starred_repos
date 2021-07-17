import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_stared_repos_failure.freezed.dart';

/// A union of failures that may occur when retrieving stared repositories.
@freezed
class GetStaredReposFailure with _$GetStaredReposFailure {
  /// A failure representing no Internet connection.
  const factory GetStaredReposFailure.offline() = _GetStaredReposFailureOffline;
}
