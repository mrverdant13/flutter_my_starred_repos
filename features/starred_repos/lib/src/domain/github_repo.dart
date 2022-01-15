import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starred_repos/src/domain/user.dart';

part 'github_repo.freezed.dart';
part 'github_repo.g.dart';

@freezed
class GithubRepo with _$GithubRepo {
  const factory GithubRepo({
    required User owner,
    required String name,
    // ignore: invalid_annotation_target
    @JsonKey(defaultValue: '') required String description,
    // ignore: invalid_annotation_target
    @JsonKey(name: 'stargazers_count') required int starsCount,
  }) = _GithubRepo;

  const GithubRepo._();

  factory GithubRepo.fromJson(Map<String, dynamic> json) =>
      _$GithubRepoFromJson(json);

  Uri get urlPath => Uri(
        host: 'github.com',
        pathSegments: [owner.username, name],
      );
}
