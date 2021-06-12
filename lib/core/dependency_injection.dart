import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../application/cubit/users/users_cubit.dart';
import '../domain/facades/users_repo.dart';
import '../domain/use_cases/get_users/use_case.dart';
import '../infrastructure/data_sources/users/remote/implementation.dart';
import '../infrastructure/data_sources/users/remote/interface.dart';
import '../infrastructure/facades/users_repo.dart';
import 'flavors.dart';

final getIt = GetIt.instance;

Future<void> injectDependencies(Flavor flavor) async {
  getIt.registerSingleton(flavor);

  // External
  getIt.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: 'https://api.github.com',
      ),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<UsersRDS>(
    () => UsersRDSImp(
      dio: getIt(),
    ),
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
