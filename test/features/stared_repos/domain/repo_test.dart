import 'package:flutter_my_starred_repos/features/stared_repos/domain/repo.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/domain/user.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a GitHub repository data holder
WHEN its ID is requested
THEN a GitHub path is returned
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
      final result = repo.id;

      // ASSERT
      expect(result, expectedId);
    },
  );
}
