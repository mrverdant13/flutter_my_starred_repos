import 'package:graphql/client.dart';

import '../../dto/user.dart';
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
  Future<List<UserDto>> getUsers() async {
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
      (_jsonUser) {
        final jsonUser = (_jsonUser as Map<String, dynamic>).map(
          (key, value) => MapEntry(
            key,
            key == 'id' ? int.tryParse(value as String) : value,
          ),
        );
        return UserDto.fromJson(
          jsonUser,
          // HACK: Does not work with tests.
          // (jsonUser as Map<String, dynamic>)
          //   ..update(
          //     'id',
          //     (idStr) => int.tryParse(idStr as String),
          //   ),
        );
      },
    ).toList();

    return users;
  }
}
