import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql/client.dart';

import '../application/cubit/users/users_cubit.dart';
import '../domain/facades/users_repo.dart';
import '../domain/use_cases/get_users/use_case.dart';
import '../infrastructure/data_sources/users/remote/gql_implementation.dart'
    as gql_users_rds;
import '../infrastructure/data_sources/users/remote/http_implementation.dart'
    as http_users_rds;
import '../infrastructure/data_sources/users/remote/interface.dart';
import '../infrastructure/facades/users_repo.dart';
import 'flavors.dart';

final getIt = GetIt.instance;

Future<void> injectDependencies(Flavor flavor) async {
  getIt.registerSingleton(flavor);

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

  // Use cases
  getIt.registerLazySingleton<GetUsers>(
    () => GetUsers(
      usersRepo: getIt(),
    ),
  );

  // State managers
  getIt.registerFactory<UsersCubit>(
    () => UsersCubit(
      getUsers: getIt(),
    ),
  );
}
