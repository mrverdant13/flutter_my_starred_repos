import 'package:auth/auth.dart';
import 'package:flutter_my_starred_repos/features/auth/application/authenticator_cubit/authenticator_cubit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/dependency_injection.dart';
import '../infrastructure/external/dio_interceptors.dart';

final githubAuthConfigPod = Provider<GithubAuthConfig>(
  (ref) {
    final appConfig = ref.watch(appConfigPod);
    return appConfig.githubAuthConfig;
  },
);

final flutterSecureStoragePod = Provider<FlutterSecureStorage>(
  (_) => const FlutterSecureStorage(),
);

final credsStoragePod = Provider<CredsStorage>(
  (ref) {
    final flutterSecureStorage = ref.watch(flutterSecureStoragePod);
    return CredsStorage(
      flutterSecureStorage: flutterSecureStorage,
    );
  },
);

final authInterceptorPod = Provider<AuthInterceptor>(
  (ref) {
    final credsStorage = ref.watch(credsStoragePod);
    return AuthInterceptor(
      credsStorage: credsStorage,
    );
  },
);

final githubAuthApiPod = Provider<GithubAuthApi>(
  (ref) {
    final githubAuthConfig = ref.watch(githubAuthConfigPod);
    return GithubAuthApi(
      githubAuthConfig: githubAuthConfig,
    );
  },
);

final authServicePod = Provider<AuthService>(
  (ref) {
    final githubAuthApi = ref.watch(githubAuthApiPod);
    final credsStorage = ref.watch(credsStoragePod);
    return AuthService(
      githubAuthApi: githubAuthApi,
      credsStorage: credsStorage,
    );
  },
);

final authenticatorCubitPod = Provider<AuthenticatorCubit>(
  (ref) {
    final authService = ref.watch(authServicePod);
    return AuthenticatorCubit(
      authService: authService,
    );
  },
);
