import 'package:auth_config/auth_config.dart';
import 'package:auth_rds/auth_rds.dart';
import 'package:auth_service/auth_service.dart';
import 'package:flutter_my_starred_repos/core/config.dart';
import 'package:flutter_my_starred_repos/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/features/auth/application/authenticator_cubit/authenticator_cubit.dart';
import 'package:flutter_my_starred_repos/features/auth/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/features/auth/infrastructure/external/dio_interceptors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:test/test.dart';

void main() {
  group(
    '''

GIVEN a dependencies container
AND a previously injected app config
WHEN the injection process is triggered''',
    () {
      late ProviderContainer container;

      setUp(
        () async {
          // ARRANGE
          const githubAuthConfig = GithubAuthConfig(
            clientId: 'clientId',
            clientSecret: 'clientSecret',
          );
          const appConfig = AppConfig(
            githubAuthConfig: githubAuthConfig,
          );

          // ACT
          container = ProviderContainer(
            overrides: [
              appConfigPod.overrideWithValue(appConfig),
            ],
          );
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
            container.read(githubAuthConfigPod),
            isA<GithubAuthConfig>(),
          );
          expect(
            container.read(flutterSecureStoragePod),
            isA<FlutterSecureStorage>(),
          );
          expect(
            container.read(authInterceptorPod),
            isA<AuthInterceptor>(),
          );
          expect(
            container.read(authenticatorPod),
            isA<Authenticator>(),
          );
          expect(
            container.read(authServicePod),
            isA<AuthService>(),
          );
          expect(
            container.read(authenticatorCubitPod),
            isA<AuthenticatorCubit>(),
          );
        },
      );
    },
  );
}
