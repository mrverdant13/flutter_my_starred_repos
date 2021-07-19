import 'package:flutter_app_template/core/config.dart';
import 'package:flutter_app_template/features/auth/application/authenticator_cubit/authenticator_cubit.dart';
import 'package:flutter_app_template/features/auth/core/dependency_injection.dart';
import 'package:flutter_app_template/features/auth/infrastructure/data_sources/authenticator/interface.dart';
import 'package:flutter_app_template/features/auth/infrastructure/external/dio_interceptors.dart';
import 'package:flutter_app_template/features/auth/infrastructure/facades/auth_service/interface.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:test/test.dart';

void main() {
  test(
    '''
  
GIVEN an injector function
AND a previously injected app config
WHEN the injection process is triggered
THEN a single GitHub auth config should be injected
AND a single Flutter secure storage should be injected
AND a single auth interceptor should be injected
AND a single authenticator data source should be injected
AND a single auth service should be injected
AND a single auth cubit should be injected''',
    () async {
      // ARRANGE
      final getIt = GetIt.instance;
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

      // ASSERT
      expect(
        getIt.isRegistered<GithubAuthConfig>(),
        true,
      );
      expect(
        getIt.isRegistered<FlutterSecureStorage>(),
        true,
      );
      expect(
        getIt.isRegistered<AuthInterceptor>(),
        true,
      );
      expect(
        getIt.isRegistered<Authenticator>(),
        true,
      );
      expect(
        getIt.isRegistered<AuthService>(),
        true,
      );
      expect(
        getIt.isRegistered<AuthenticatorCubit>(),
        true,
      );
    },
  );
}
