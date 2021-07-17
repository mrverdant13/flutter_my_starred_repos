import '../../domain/repo.dart';
import '../dtos/github_repo.dart';
import 'user.dart';

extension ConvertibleRepoDto on GithubRepoDto {
  GithubRepo get asEntity => GithubRepo(
        owner: owner.asEntity,
        name: name,
        description: description,
        starsCount: starsCount,
      );
}
