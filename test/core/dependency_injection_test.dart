import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_app_template/application/cubit/users/users_cubit.dart';
import 'package:flutter_app_template/core/dependency_injection.dart';
import 'package:flutter_app_template/core/flavors.dart';
import 'package:flutter_app_template/domain/facades/users_repo.dart';
import 'package:flutter_app_template/domain/use_cases/get_users/use_case.dart';
import 'package:flutter_app_template/infrastructure/data_sources/users/remote/interface.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group(
    '''
  
GIVEN an injector function
AND any flavor''',
    () {
      final anyFlavor = Flavor.values[Random().nextInt(
        Flavor.values.length,
      )];

      setUp(
        () {
          getIt.reset();
        },
      );

      test(
        '''

WHEN the injection process is triggered
THEN the flavor should be injected
''',
        () async {
          // ARRANGE

          // ACT
          await injectDependencies(anyFlavor);

          // ASSERT
          expect(
            getIt.isRegistered<Flavor>(),
            true,
          );
          expect(kAppFlavor, anyFlavor);
        },
      );

      test(
        '''

WHEN the injection process is triggered
THEN a single HTTP client is injected
''',
        () async {
          // ARRANGE

          // ACT
          await injectDependencies(anyFlavor);

          // ASSERT
          expect(
            getIt.isRegistered<Dio>(),
            true,
          );
        },
      );

      test(
        '''

WHEN the injection process is triggered
THEN a single users remote data source should be injected
AND a single users repo should be injected
AND a single users getter use case should be injected
AND a single users cubit should be injected
''',
        () async {
          // ARRANGE

          // ACT
          await injectDependencies(anyFlavor);

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

WHEN the injection process is triggered
THEN a single users cubit can be accessed
''',
        () async {
          // ARRANGE

          // ACT
          await injectDependencies(anyFlavor);

          // ASSERT
          expect(
            getIt.get<UsersCubit>(),
            isNotNull,
          );
        },
      );
    },
  );
}
