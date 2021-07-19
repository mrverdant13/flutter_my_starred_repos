import 'package:dio/dio.dart';
import 'package:flutter_app_template/core/flavors.dart';
import 'package:flutter_app_template/features/users_placeholder/application/users_cubit/cubit.dart';
import 'package:flutter_app_template/features/users_placeholder/core/dependency_injection.dart';
import 'package:flutter_app_template/features/users_placeholder/infrastructure/data_sources/users_rds/interface.dart';
import 'package:flutter_app_template/features/users_placeholder/infrastructure/facades/interface.dart';
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';
import 'package:graphql/client.dart';

void main() {
  group(
    '''
  
GIVEN an injector function''',
    () {
      final getIt = GetIt.instance;
      for (final flavor in Flavor.values) {
        group(
          '''
  
AND the ${flavor.tag} flavor
WHEN the injection process is triggered''',
          () {
            setUp(
              () async {
                getIt.reset();
                await injectDependencies(
                  flavor: flavor,
                );
              },
            );

            test(
              '''

THEN a single users remote data source should be injected
AND a single users repo should be injected
AND a single users cubit should be injected
''',
              () async {
                // ARRANGE

                // ACT

                // ASSERT
                expect(
                  getIt.isRegistered<UsersRDS>(),
                  true,
                );
                expect(
                  getIt.isRegistered<UsersRepo>(),
                  true,
                );
                expect(
                  getIt.isRegistered<UsersCubit>(),
                  true,
                );
              },
            );

            test(
              '''

THEN a single users cubit can be accessed
''',
              () async {
                // ARRANGE

                // ACT

                // ASSERT
                expect(
                  getIt.get<UsersCubit>(),
                  isNotNull,
                );
              },
            );

            if (flavor == Flavor.dev || flavor == Flavor.prod) {
              test(
                '''

THEN a single HTTP client is injected
''',
                () async {
                  // ARRANGE

                  // ACT

                  // ASSERT
                  expect(
                    getIt.isRegistered<Dio>(),
                    true,
                  );
                },
              );
            } else if (flavor == Flavor.stg) {
              test(
                '''

THEN a single GraphQL client is injected
''',
                () async {
                  // ARRANGE

                  // ACT

                  // ASSERT
                  expect(
                    getIt.isRegistered<GraphQLClient>(),
                    true,
                  );
                },
              );
            }
          },
        );
      }
    },
  );
}
