import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'github_repo.freezed.dart';
part 'github_repo.g.dart';

/// A GitHub repository DTO.
///
/// This DTO offers JSON serialization.
@freezed
class GithubRepoDto with _$GithubRepoDto {
  /// Creates a GitHub repository DTO.
  @JsonSerializable(explicitToJson: true)
  const factory GithubRepoDto({
    /// The GitHub user that owns this repository.
    required UserDto owner,

    /// The name of this repository.
    required String name,

    /// The description of this repository.
    ///
    /// The description could be empty.
    @JsonKey(defaultValue: '') required String description,

    /// The amount of starts of this repository.
    @JsonKey(name: 'stargazers_count') required int starsCount,
  }) = _GithubRepoDto;

  /// Creates a GitHub repository DTO from the [json] `Map`.
  factory GithubRepoDto.fromJson(Map<String, dynamic> json) =>
      _$GithubRepoDtoFromJson(json);
}
