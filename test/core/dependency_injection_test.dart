import 'package:dio/dio.dart';
import 'package:flutter_app_template/application/cubit/users/users_cubit.dart';
import 'package:flutter_app_template/core/config.dart';
import 'package:flutter_app_template/core/dependency_injection.dart';
import 'package:flutter_app_template/core/flavors.dart';
import 'package:flutter_app_template/domain/facades/users_repo.dart';
import 'package:flutter_app_template/domain/use_cases/get_users/use_case.dart';
import 'package:flutter_app_template/infrastructure/data_sources/users/remote/interface.dart';
import 'package:test/test.dart';
import 'package:graphql/client.dart';

void main() {
  group(
    '''
  
GIVEN an injector function''',
    () {
      const githubAuthConfig = GithubAuthConfig(
        clientId: 'clientId',
        clientSecret: 'clientSecret',
      );
      const appConfig = AppConfig(
        githubAuthConfig: githubAuthConfig,
      );
      for (final flavor in Flavor.values) {
        group(
          '''
  
AND the app config data
AND the ${flavor.tag} flavor
WHEN the injection process is triggered''',
          () {
            setUp(
              () async {
                getIt.reset();
                await injectDependencies(
                  config: appConfig,
                  flavor: flavor,
                );
              },
            );

            test(
              '''

THEN the flavor should be injected
''',
              () async {
                // ARRANGE

                // ACT

                // ASSERT
                expect(
                  getIt.isRegistered<Flavor>(),
                  true,
                );
                expect(kAppFlavor, flavor);
              },
            );

            test(
              '''

THEN the app congig should be injected
''',
              () async {
                // ARRANGE

                // ACT
                final registeredAppConfig = getIt<AppConfig>();

                // ASSERT
                expect(
                  registeredAppConfig,
                  appConfig,
                );
              },
            );

            test(
              '''

THEN a single users remote data source should be injected
AND a single users repo should be injected
AND a single users getter use case should be injected
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
                  getIt.isRegistered<GetUsers>(),
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

            if (flavor == Flavor.dev) {
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
            } else if (flavor == Flavor.prod) {
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
