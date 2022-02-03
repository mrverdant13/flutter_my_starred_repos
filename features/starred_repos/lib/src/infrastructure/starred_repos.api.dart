import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:starred_repos/src/domain/github_repo.dart';
import 'package:starred_repos/src/domain/page.dart';

part 'starred_repos.api.freezed.dart';

class StarredReposApi {
  const StarredReposApi({
    required Dio dio,
  }) : _dio = dio;

  final Dio _dio;

  /// The endpoint used to retrieve the repositories starred by the user.
  ///
  /// See: [User's starred repos endpoint]
  ///
  /// [User's starred repos endpoint]:
  /// https://docs.github.com/en/rest/reference/activity#list-repositories-starred-by-the-authenticated-user
  static const retrieveEndpoint = 'https://api.github.com/user/starred';

  Future<Page<GithubRepo>> getStarredReposPage({
    required int pageNumber,
    required int pageLength,
  }) async {
    late final Response response;

    try {
      response = await _dio.get(
        retrieveEndpoint,
        queryParameters: {
          'page': pageNumber,
          'per_page': pageLength,
        },
        options: Options(
          headers: {
            'Accept': 'application/vnd.github.v3+json',
          },
        ),
      );
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.other:
          if (e.error != null && e.error is SocketException) {
            throw const GetStarredReposPageException.offline();
          }
          break;
        case DioErrorType.response:
          if (e.response?.statusCode == 304) {
            throw const GetStarredReposPageException.unmodified();
          }
          break;
        default:
          rethrow;
      }
    }

    final jsonRepos = response.data as List;

    final repos = jsonRepos
        .map(
          (jsonRepo) => GithubRepo.fromJson(
            jsonRepo as Map<String, dynamic>,
          ),
        )
        .toList();

    return Page(
      lastPage: response.lastPage ?? pageNumber,
      elements: repos,
    );
  }
}

extension _ExtendedResponse on Response {
  int? get lastPage {
    final rawLinksData = headers['Link'];

    if (rawLinksData == null) return null;

    final linksData = rawLinksData.first.split(', ');

    const lastLinkDataEnding = '>; rel="last"';

    final lastLinkData = linksData.singleWhereOrNull(
          (linkData) => linkData.contains(lastLinkDataEnding),
        ) ??
        '';

    if (lastLinkData.isEmpty) return null;

    final lastLink = lastLinkData.substring(
      1,
      lastLinkData.length - lastLinkDataEnding.length,
    );

    final uri = Uri.parse(lastLink);
    final pageStr = uri.queryParameters['page'];

    if (pageStr == null) return null;

    return int.tryParse(pageStr);
  }
}

@freezed
class GetStarredReposPageException with _$GetStarredReposPageException {
  // coverage:ignore-start
  const GetStarredReposPageException._();
  const factory GetStarredReposPageException.offline() =
      _GetStarredReposPageExceptionOffline;
  const factory GetStarredReposPageException.unmodified() =
      _GetStarredReposPageExceptionUnmodified;
  // coverage:ignore-end
}
