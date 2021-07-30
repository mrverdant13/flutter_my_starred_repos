import 'package:flutter_my_starred_repos/core/config.dart';
import 'package:flutter_my_starred_repos/features/auth/application/authenticator_cubit/authenticator_cubit.dart';
import 'package:flutter_my_starred_repos/features/auth/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/features/auth/infrastructure/data_sources/authenticator/interface.dart';
import 'package:flutter_my_starred_repos/features/auth/infrastructure/external/dio_interceptors.dart';
import 'package:flutter_my_starred_repos/features/auth/infrastructure/facades/auth_service/interface.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

void main() {
  group(
    '''

GIVEN an injector function
AND a previously injected app config
WHEN the injection process is triggered''',
    () {
      final getIt = GetIt.instance;

      setUp(
        () async {
          // ARRANGE
          await getIt.reset();
          const githubAuthConfig = GithubAuthConfig(
            clientId: 'clientId',
            clientSecret: 'clientSecret',
          );
          const appConfig = AppConfig(
            githubAuthConfig: githubAuthConfig,
          );
          getIt.registerLazySingleton(() => appConfig);

          // ACT
          await injectDependencies();
        },
      );
      test(
        '''
  
THEN the necessary auth dependencies should be injected
├─ BY  injecting a single GitHub auth config
├─ AND injecting a single Flutter secure storage
├─ AND injecting a single auth interceptor
├─ AND injecting a single authenticator data source
├─ AND injecting a single auth service
├─ AND injecting an auth cubit factory
''',
        () async {
          // ASSERT
          expect(
            getIt<GithubAuthConfig>(),
            getIt<GithubAuthConfig>(),
          );
          expect(
            getIt<FlutterSecureStorage>(),
            getIt<FlutterSecureStorage>(),
          );
          expect(
            getIt<AuthInterceptor>(),
            getIt<AuthInterceptor>(),
          );
          expect(
            getIt<Authenticator>(),
            getIt<Authenticator>(),
          );
          expect(
            getIt<AuthService>(),
            getIt<AuthService>(),
          );
          expect(
            getIt<AuthenticatorCubit>(),
            isA<AuthenticatorCubit>(),
          );
        },
      );
    },
  );
}
