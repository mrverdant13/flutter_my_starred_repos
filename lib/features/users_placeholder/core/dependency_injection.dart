import 'package:dio/dio.dart';
import 'package:graphql/client.dart';

import '../../../core/dependency_injection.dart';
import '../../../core/flavors.dart';
import '../application/users_cubit/cubit.dart';
import '../infrastructure/data_sources/users_rds/gql_implementation.dart'
    as gql_users_rds;
import '../infrastructure/data_sources/users_rds/interface.dart';
import '../infrastructure/data_sources/users_rds/rest_implementation.dart'
    as http_users_rds;
import '../infrastructure/facades/implementation.dart';
import '../infrastructure/facades/interface.dart';

Future<void> injectDependencies({
  required Flavor flavor,
}) async {
  // External
  switch (flavor) {
    case Flavor.dev:
    case Flavor.prod:
      getIt.registerLazySingleton<Dio>(
        () => Dio(
          BaseOptions(
            baseUrl: 'http://jsonplaceholder.typicode.com',
          ),
        ),
      );
      break;
    case Flavor.stg:
      final graphQLHttpLink = HttpLink('https://graphqlzero.almansi.me/api');
      final graphQLCache = GraphQLCache();
      getIt.registerLazySingleton<GraphQLClient>(
        () => GraphQLClient(
          link: graphQLHttpLink,
          cache: graphQLCache,
        ),
      );
      break;
  }

  // Data sources
  getIt.registerLazySingleton<UsersRDS>(
    () {
      switch (flavor) {
        case Flavor.dev:
        case Flavor.prod:
          return http_users_rds.UsersRDSImp(
            dio: getIt(),
          );
        case Flavor.stg:
          return gql_users_rds.UsersRDSImp(
            gqlClient: getIt(),
          );
      }
    },
  );

  // Facades
  getIt.registerLazySingleton<UsersRepo>(
    () => UsersRepoImp(
      usersRDS: getIt(),
    ),
  );

  // State managers
  getIt.registerFactory<UsersCubit>(
    () => UsersCubit(
      usersRepo: getIt(),
    ),
  );
}
