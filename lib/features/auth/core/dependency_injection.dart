import 'package:auth/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/dependency_injection.dart';
import '../infrastructure/external/dio_interceptors.dart';

final githubAuthConfigPod = Provider<GithubAuthConfig>(
  (ref) => ref.watch(appConfigPod).githubAuthConfig,
);

final flutterSecureStoragePod = Provider<FlutterSecureStorage>(
  (_) => const FlutterSecureStorage(),
);

final credsStoragePod = Provider<CredsStorage>(
  (ref) => CredsStorage(
    flutterSecureStorage: ref.watch(flutterSecureStoragePod),
  ),
);

final authInterceptorPod = Provider<AuthInterceptor>(
  (ref) => AuthInterceptor(
    credsStorage: ref.watch(credsStoragePod),
  ),
);

final githubAuthApiPod = Provider<GithubAuthApi>(
  (ref) => GithubAuthApi(
    githubAuthConfig: ref.watch(githubAuthConfigPod),
  ),
);

final authServicePod = Provider<AuthService>(
  (ref) => AuthService(
    githubAuthApi: ref.watch(githubAuthApiPod),
    credsStorage: ref.watch(credsStoragePod),
  ),
);

final authCubitPod = Provider<AuthCubit>(
  (ref) {
    return AuthCubit(
      authService: ref.watch(authServicePod),
    );
  },
);
