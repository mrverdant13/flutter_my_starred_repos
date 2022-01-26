import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql/client.dart';
import 'package:profile/src/domain/profile.entity.dart';

part 'profile.api.freezed.dart';

class ProfileApi {
  const ProfileApi({
    required GraphQLClient gqlClient,
    required Dio dio,
  })  : _gqlClient = gqlClient,
        _dio = dio;

  final GraphQLClient _gqlClient;
  final Dio _dio;

  Future<Profile> getProfile() async {
    // Ref: https://docs.github.com/en/graphql/reference/queries#user
    const getProfileQuery = '''
query {
  viewer {
    login
    name
    avatarUrl
    status {
      emoji
      message
    }
  }
}''';
    final getProfileDoc = gql(getProfileQuery);
    const emojiEndpoint =
        'https://raw.githubusercontent.com/omnidan/node-emoji/master/lib/emoji.json';

    final queryResult = await _gqlClient.query(
      QueryOptions(document: getProfileDoc),
    );

    final exception = queryResult.exception;
    if (exception != null) {
      final linkException = exception.linkException;
      if (linkException is NetworkException) {
        throw const GetProfileException.offline();
      }
      throw const GetProfileException.unexpected();
    }

    if (queryResult.exception?.linkException is NetworkException) {
      throw const GetProfileException.offline();
    }

    final jsonProfile = queryResult.data!['viewer'] as Map<String, dynamic>;
    final jsonUserStatus = jsonProfile['status'] as Map<String, dynamic>?;

    if (jsonUserStatus == null) return Profile.fromJson(jsonProfile);

    final emojiBuf = StringBuffer();
    try {
      final response = await _dio.get(emojiEndpoint);
      final emojiCode = (jsonUserStatus['emoji'] as String).replaceAll(':', '');
      final data = jsonDecode(response.data as String) as Map<String, dynamic>;
      final emoji = data[emojiCode.replaceAll(':', '')] as String;
      emojiBuf.write(emoji);
    } catch (_) {}
    final emoji = emojiBuf.toString();

    final resultingJsonUserStatus = {
      ...jsonUserStatus,
      'emoji': emoji.isEmpty ? null : emoji,
    };
    final resultingJsonProfile = {
      ...jsonProfile,
      'status': resultingJsonUserStatus,
    };
    return Profile.fromJson(resultingJsonProfile);
  }
}

@freezed
class GetProfileException with _$GetProfileException {
  const factory GetProfileException.offline() = _GetProfileExceptionOffline;
  const factory GetProfileException.unexpected() =
      _GetProfileExceptionUnexpected;
}
