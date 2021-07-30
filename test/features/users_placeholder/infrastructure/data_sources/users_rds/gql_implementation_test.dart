import 'package:flutter/foundation.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/infrastructure/data_sources/users_rds/gql_implementation.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/infrastructure/data_sources/users_rds/interface.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/infrastructure/dto/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';

class MockGQLClient extends Mock implements GraphQLClient {}

class FakeQueryOptions extends Fake implements QueryOptions {}

void main() {
  group(
    '''

GIVEN a users remote data source
THAT uses a GraphQL client''',
    () {
      // ARRANGE
      late MockGQLClient mockGQLClient;
      late UsersRDSImp usersRDS;

      setUpAll(
        () {
          registerFallbackValue(FakeQueryOptions());
        },
      );

      setUp(
        () {
          mockGQLClient = MockGQLClient();
          usersRDS = UsersRDSImp(
            gqlClient: mockGQLClient,
          );
        },
      );

      test(
        '''

WHEN the users list is requested
THEN the GraphQL client should be used to retrieve the users
AND a set of user DTOs should be returned
      ''',
        () async {
          // ARRANGE
          const usersCount = 5;
          final usersJson = List.generate(
            usersCount,
            (idx) => {
              'id': '$idx',
              'name': 'User $idx',
              'username': 'user$idx',
            },
          );
          final users = List.generate(
            usersCount,
            (idx) => UserDto(
              id: idx,
              name: 'User $idx',
              username: 'user$idx',
            ),
          );

          when(
            () => mockGQLClient.query(
              any(),
            ),
          ).thenAnswer(
            (_) async => QueryResult(
              source: null,
              data: {
                'users': {
                  'data': usersJson,
                }
              },
            ),
          );

          // ACT
          final result = await usersRDS.getUsers();

          // ASSERT
          expect(listEquals(result, users), isTrue);
          final capturedQueryOptions = verify(
            () => mockGQLClient.query(
              captureAny(that: isA<QueryOptions>()),
            ),
          ).captured.single as QueryOptions;
          expect(capturedQueryOptions.document, getUsersDoc);
        },
      );

      test(
        '''

AND no internet connection
WHEN the users list is requested
THEN the GraphQL client should be used to retrieve the users
AND an exception should be thrown
      ''',
        () async {
          // ARRANGE
          when(
            () => mockGQLClient.query(
              any(),
            ),
          ).thenAnswer(
            (_) async => QueryResult(
              source: null,
              exception: OperationException(
                linkException: NetworkException(
                  uri: null,
                ),
              ),
            ),
          );

          // ACT
          Future<void> action() async => usersRDS.getUsers();

          // ASSERT
          expect(
            action,
            throwsA(
              const GetUsersException.offline(),
            ),
          );
          final capturedQueryOptions = verify(
            () => mockGQLClient.query(
              captureAny(that: isA<QueryOptions>()),
            ),
          ).captured.single as QueryOptions;
          expect(capturedQueryOptions.document, getUsersDoc);
        },
      );
    },
  );
}
