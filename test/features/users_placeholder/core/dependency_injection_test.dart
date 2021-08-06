import 'package:dio/dio.dart';
import 'package:flutter_my_starred_repos/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/core/flavors.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/application/users_cubit/cubit.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/features/users_placeholder/infrastructure/data_sources/users_rds/gql_implementation.dart'
    as gql;
import 'package:flutter_my_starred_repos/features/users_placeholder/infrastructure/data_sources/users_rds/rest_implementation.dart'
    as rest;
import 'package:flutter_my_starred_repos/features/users_placeholder/infrastructure/facades/interface.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/test.dart';
import 'package:graphql/client.dart';

void main() {
  // ARRANGE
  for (final flavor in Flavor.values) {
    group(
      '''

GIVEN a depencencies container
AND a previously injected ${flavor.tag} flavor
WHEN the injection process is triggered''',
      () {
        // ARRANGE
        late ProviderContainer container;

        setUp(
          () async {
            // ARRANGE
            final preconditionalOverrides = [
              flavorPod.overrideWithValue(flavor),
            ];
            // ACT
            container = ProviderContainer(
              overrides: [
                ...preconditionalOverrides,
              ],
            );
          },
        );

        test(
          '''

THEN the necessary flavor-independent users-related dependencies should be injected
├─ AND injecting a single users repository
├─ AND injecting a single users cubit
''',
          () async {
            // ASSERT
            expect(
              container.read(usersRepoPod),
              isA<UsersRepo>(),
            );
            expect(
              container.read(usersCubitPod),
              isA<UsersCubit>(),
            );
          },
        );

        switch (flavor) {
          case Flavor.dev:
          case Flavor.prod:
            test(
              '''

THEN the necessary users-related dependencies for the ${flavor.tag} flavor should be injected
├─ AND injecting a single Dio HTTP client
├─ AND injecting a single REST-based users remote data source
''',
              () async {
                // ASSERT
                expect(
                  container.read(usersDioPod),
                  isA<Dio>(),
                );
                expect(
                  container.read(usersRDSPod),
                  isA<rest.UsersRDSImp>(),
                );
              },
            );
            break;
          case Flavor.stg:
            test(
              '''

THEN the necessary users-related dependencies for the ${flavor.tag} flavor should be injected
├─ AND injecting a single GraphQL client
├─ AND injecting a single GraphQL-based users remote data source
''',
              () async {
                // ASSERT
                expect(
                  container.read(usersGQLClientPod),
                  isA<GraphQLClient>(),
                );
                expect(
                  container.read(usersRDSPod),
                  isA<gql.UsersRDSImp>(),
                );
              },
            );
            break;
        }
      },
    );
  }
}
