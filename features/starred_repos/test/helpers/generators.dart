import 'package:starred_repos/src/domain/github_repo.dart';
import 'package:starred_repos/src/domain/user.dart';

List<GithubRepo> generateStarredRepos({
  required int reposCount,
  required int reposOffset,
  String? prefix,
}) =>
    List.generate(
      reposCount,
      (index) {
        final refValue = index + reposOffset + 1;
        return GithubRepo(
          owner: User(
            username: '$prefix username $refValue',
            avatarUrl: '$prefix avatar_url_$refValue',
          ),
          name: '$prefix repo $refValue',
          description: '$prefix description $refValue',
          starsCount: refValue,
        );
      },
    );
