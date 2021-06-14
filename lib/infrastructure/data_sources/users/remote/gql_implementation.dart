import 'package:graphql/client.dart';

import '../../../models/user.dart';
import 'interface.dart';

final getUsersDoc = gql(
  '''
query getUsers {
  users {
    data {
      id
      name
      username
    }
  }
}
''',
);

class UsersRDSImp extends UsersRDS {
  const UsersRDSImp({
    required this.gqlClient,
  });

  final GraphQLClient gqlClient;

  @override
  Future<Set<UserR>> getUsers() async {
    // API endpoint doc:
    // https://graphqlzero.almansi.me/

    final queryResult = await gqlClient.query(
      QueryOptions(document: getUsersDoc),
    );

    if (queryResult.exception?.linkException is NetworkException) {
      throw const GetUsersException.offline();
    }

    final jsonUsers = queryResult.data!['users']['data'] as List;

    final users = jsonUsers.map(
      (jsonUser) {
        jsonUser['id'] = int.tryParse(jsonUser['id'] as String);
        return UserR.fromJson(
          jsonUser as Map<String, dynamic>,
        );
      },
    );

    return users.toSet();
  }
}
