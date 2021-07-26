import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'repo.freezed.dart';

/// A GitHub repository.
@freezed
class GithubRepo with _$GithubRepo {
  /// Creates a GitHub repository.
  const factory GithubRepo({
    /// The GitHub user that owns this repository.
    required User owner,

    /// The name of this repository.
    required String name,

    /// The description of this repository.
    ///
    /// The description could be empty.
    required String description,

    /// The amount of starts of this repository.
    required int starsCount,
  }) = _GithubRepo;

  const GithubRepo._();

  String get id => '${owner.username}/$name';
}
