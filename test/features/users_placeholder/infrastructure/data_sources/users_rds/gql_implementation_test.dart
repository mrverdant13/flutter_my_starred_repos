import 'package:flutter/foundation.dart';
import 'package:flutter_app_template/features/users_placeholder/infrastructure/data_sources/users_rds/gql_implementation.dart';
import 'package:flutter_app_template/features/users_placeholder/infrastructure/data_sources/users_rds/interface.dart';
import 'package:flutter_app_template/features/users_placeholder/infrastructure/dto/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql/client.dart';
import 'package:mocktail/mocktail.dart';

class MockGQLClient extends Mock implements GraphQLClient {}

class FakeQueryOptions extends Fake implements QueryOptions {}

void main() {
  group(
    '''

GIVEN a users remote data source''',
    () {
      // External dependencies
      late MockGQLClient mockGQLClient;

      // Remota data source
      late UsersRDSImp usersRDS;

      setUp(
        () {
          registerFallbackValue(FakeQueryOptions());
          mockGQLClient = MockGQLClient();
          usersRDS = UsersRDSImp(
            gqlClient: mockGQLClient,
          );
        },
      );

      test(
        '''

WHEN the users list is requested
THEN a set of remote user models is returned
      ''',
        () async {
          // ARRANGE
          final usersJson = [
            {
              'id': '1',
              'name': 'User 1',
              'username': 'user1',
            },
            {
              'id': '2',
              'name': 'User 2',
              'username': 'user2',
            },
            {
              'id': '3',
              'name': 'User 3',
              'username': 'user3',
            },
          ];
          final users = [
            const UserDto(id: 1, name: 'User 1', username: 'user1'),
            const UserDto(id: 2, name: 'User 2', username: 'user2'),
            const UserDto(id: 3, name: 'User 3', username: 'user3'),
          ];

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
THEN an exception is thrown
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
