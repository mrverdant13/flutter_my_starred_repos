import 'package:auth/auth.dart';
import 'package:flutter_my_starred_repos/core/dependency_injection.dart';
import 'package:flutter_my_starred_repos/features/profile/core/dependency_injection.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
    profileApi: ref.watch(profileApiPod),
    profileStorage: ref.watch(profileStoragePod),
  ),
);

final authNotifierPod = StateNotifierProvider<AuthNotifier, AuthState>(
  (ref) => AuthNotifier(
    authService: ref.watch(authServicePod),
  ),
);
