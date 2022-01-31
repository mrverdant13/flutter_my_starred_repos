import 'package:auth/auth.dart';
import 'package:flutter_my_starred_repos/core/config.dart';
import 'package:flutter_my_starred_repos/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/features/auth/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/features/profile/core/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mocktail/mocktail.dart';
import 'package:profile/profile.dart';
import 'package:test/test.dart';

class FakeProfileApi extends Fake implements ProfileApi {}

class FakeProfileStorage extends Fake implements ProfileStorage {}

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
              profileApiPod.overrideWithValue(FakeProfileApi()),
              profileStoragePod.overrideWithValue(FakeProfileStorage()),
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
            container.read(githubAuthApiPod),
            isA<GithubAuthApi>(),
          );
          expect(
            container.read(authServicePod),
            isA<AuthService>(),
          );
          expect(
            container.read(authCubitPod),
            isA<AuthCubit>(),
          );
        },
      );
    },
  );
}
