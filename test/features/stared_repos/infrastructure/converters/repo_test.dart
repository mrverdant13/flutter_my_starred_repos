import 'package:flutter_my_starred_repos/features/stared_repos/domain/repo.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/domain/user.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/converters/repo.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/dtos/github_repo.dart';
import 'package:flutter_my_starred_repos/features/stared_repos/infrastructure/dtos/user.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''

GIVEN a GitHub repository DTO
WHEN it is mapped to a GitHub repository entity
THEN a GitHub repository entity with same semantic data should be created
''',
    () async {
      // ARRANGE
      const ownerUsername = 'username';
      const ownerAvatarUrl = 'avatar url';
      const repoName = 'repo';
      const repoDescription = 'description';
      const repoStarsCount = 6;

      const repoOwner = UserDto(
        username: ownerUsername,
        avatarUrl: ownerAvatarUrl,
      );
      const repoDto = GithubRepoDto(
        owner: repoOwner,
        name: repoName,
        description: repoDescription,
        starsCount: repoStarsCount,
      );

      const expectedRepoOwner = User(
        username: ownerUsername,
        avatarUrl: ownerAvatarUrl,
      );
      const expectedRepo = GithubRepo(
        owner: expectedRepoOwner,
        name: repoName,
        description: repoDescription,
        starsCount: repoStarsCount,
      );

      // ACT
      final resultingRepo = repoDto.asEntity;

      // ASSERT
      expect(
        resultingRepo,
        expectedRepo,
      );
    },
  );
}
