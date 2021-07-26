import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import '../../../../auth/infrastructure/external/dio_interceptors.dart';
import '../../../domain/page.dart';
import '../../dtos/github_repo.dart';
import '../../external/etags_dio_interceptor.dart';
import 'interface.dart';

/// {@macro StaredReposRDS}
/// {@template rest_implementation.StaredReposRDSImp}
///
/// This remote data source uses REST APIs.
/// {@endtemplate}
class StaredReposRDSImp implements StaredReposRDS {
  /// {@macro StaredReposRDS()}
  ///
  /// {@macro rest_implementation.StaredReposRDSImp}
  ///
  /// This data source consumes the REST APIs with the [dio] client.
  const StaredReposRDSImp({
    required Dio dio,
  }) : _dio = dio;

  /// The HTTP client used to consume REST APIs.
  final Dio _dio;

  /// The endpoint used to retrieve the repositories starred by the user.
  ///
  /// See: [User's starred repos endpoint]
  ///
  /// [User's starred repos endpoint]:
  /// https://docs.github.com/en/rest/reference/activity#list-repositories-starred-by-the-authenticated-user
  @visibleForTesting
  static const endpoint = 'https://api.github.com/user/starred';

  /// The quantity of starred repositories to retrieve per page.
  @visibleForTesting
  static const pageLength = 5;

  @override
  Future<Page<GithubRepoDto>> getStaredReposPage({
    required int page,
  }) async {
    late final Response response;

    try {
      response = await _dio.get(
        endpoint,
        queryParameters: {
          'page': page,
          'per_page': pageLength,
        },
        options: Options(
          headers: {
            'Accept': 'application/vnd.github.v3+json',
          },
          extra: {}..addEntries([
              AuthInterceptor.extraEntry,
              EtagsInterceptor.extraEntry,
            ]),
        ),
      );
    } on DioError catch (e) {
      switch (e.type) {
        case DioErrorType.other:
          if (e.error != null && e.error is SocketException) {
            throw const GetStaredReposPageException.offline();
          }
          break;
        case DioErrorType.response:
          if (e.response?.statusCode == 304) {
            throw const GetStaredReposPageException.unmodified();
          }
          break;
        default:
          rethrow;
      }
    }

    final jsonRepos = response.data as List;

    final repos = jsonRepos
        .map(
          (jsonRepo) => GithubRepoDto.fromJson(
            jsonRepo as Map<String, dynamic>,
          ),
        )
        .toList();

    return Page(
      lastPage: response.lastPage ?? page,
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

    final lastLinkData = linksData.singleWhere(
      (linkData) => linkData.contains(lastLinkDataEnding),
      orElse: () => '',
    );

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
