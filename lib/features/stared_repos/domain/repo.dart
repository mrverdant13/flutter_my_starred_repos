import 'package:freezed_annotation/freezed_annotation.dart';

import 'user.dart';

part 'repo.freezed.dart';

@freezed
class GithubRepo with _$GithubRepo {
  const factory GithubRepo({
    required User owner,
    required String name,
    required String description,
    required int starsCount,
  }) = _GithubRepo;
}
