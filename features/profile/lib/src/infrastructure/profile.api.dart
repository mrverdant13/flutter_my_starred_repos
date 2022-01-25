import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graphql/client.dart';
import 'package:profile/src/domain/profile.entity.dart';

part 'profile.api.freezed.dart';

class ProfileApi {
  const ProfileApi({
    required GraphQLClient gqlClient,
  }) : _gqlClient = gqlClient;

  final GraphQLClient _gqlClient;

  Future<Profile> getProfile() async {
    // Ref: https://docs.github.com/en/graphql/reference/queries#user
    const getProfileQuery = '''
query viewer {
  profile {
    login
    name
    avatarUrl
  }
}''';
    final getProfileDoc = gql(getProfileQuery);
    final queryResult = await _gqlClient.query(
      QueryOptions(document: getProfileDoc),
    );

    if (queryResult.exception?.linkException is NetworkException) {
      throw const GetProfileException.offline();
    }

    final jsonProfile = queryResult.data!['viewer'] as Map<String, dynamic>;
    return Profile.fromJson(jsonProfile);
  }
}

@freezed
class GetProfileException with _$GetProfileException {
  const factory GetProfileException.offline() = _GetProfileExceptionOffline;
}
