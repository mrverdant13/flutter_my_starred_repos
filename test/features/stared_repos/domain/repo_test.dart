import 'package:starred_repos/starred_repos.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a GitHub repository data holder
WHEN its ID is requested
THEN its GitHub relative path should be returned
''',
    () async {
      // ARRANGE
      const repoOwner = User(
        username: 'username',
        avatarUrl: 'avatarUrl',
      );
      const repo = GithubRepo(
        owner: repoOwner,
        name: 'repo',
        description: 'description',
        starsCount: 5,
      );
      final expectedId = '${repoOwner.username}/${repo.name}';

      // ACT
      final result = repo.urlPath;

      // ASSERT
      expect(result, expectedId);
    },
  );
}
