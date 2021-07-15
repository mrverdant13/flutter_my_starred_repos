import 'package:flutter_app_template/features/stared_repos/infrastructure/dtos/user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_repo.freezed.dart';
part 'github_repo.g.dart';

@freezed
class GithubRepoDto with _$GithubRepoDto {
  const factory GithubRepoDto({
    required UserDto owner,
    required String name,
    @JsonKey(defaultValue: '') required String description,
    @JsonKey(name: 'stargazers_count') required int starsCount,
  }) = _GithubRepoDto;

  factory GithubRepoDto.fromJson(Map<String, dynamic> json) =>
      _$GithubRepoDtoFromJson(json);
}
