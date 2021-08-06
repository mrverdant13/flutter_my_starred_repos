import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

final usersDioPod = Provider<Dio>(
  (ref) => Dio(
    BaseOptions(
      baseUrl: 'http://jsonplaceholder.typicode.com',
    ),
  ),
);

final usersGQLClientPod = Provider<GraphQLClient>(
  (ref) {
    final graphQLHttpLink = HttpLink('https://graphqlzero.almansi.me/api');
    final graphQLCache = GraphQLCache();
    return GraphQLClient(
      link: graphQLHttpLink,
      cache: graphQLCache,
    );
  },
);

final usersRDSPod = Provider<UsersRDS>(
  (ref) {
    final flavor = ref.watch(flavorPod);
    switch (flavor) {
      case Flavor.dev:
      case Flavor.prod:
        final dio = ref.watch(usersDioPod);
        return http_users_rds.UsersRDSImp(
          dio: dio,
        );
      case Flavor.stg:
        final gqlClient = ref.watch(usersGQLClientPod);
        return gql_users_rds.UsersRDSImp(
          gqlClient: gqlClient,
        );
    }
  },
);

final usersRepoPod = Provider<UsersRepo>(
  (ref) {
    final usersRDS = ref.watch(usersRDSPod);
    return UsersRepoImp(
      usersRDS: usersRDS,
    );
  },
);

final usersCubitPod = Provider<UsersCubit>(
  (ref) {
    final usersRepo = ref.watch(usersRepoPod);
    return UsersCubit(
      usersRepo: usersRepo,
    );
  },
);
