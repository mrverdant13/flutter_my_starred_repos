import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/config.dart';
import '../../../core/dependency_injection.dart';
import '../application/authenticator_cubit/authenticator_cubit.dart';
import '../infrastructure/data_sources/authenticator/github.dart';
import '../infrastructure/data_sources/authenticator/interface.dart';
import '../infrastructure/data_sources/creds_storage/flutter_secure_storage.dart';
import '../infrastructure/data_sources/creds_storage/interface.dart';
import '../infrastructure/external/dio_interceptors.dart';
import '../infrastructure/facades/auth_service/implementation.dart';
import '../infrastructure/facades/auth_service/interface.dart';

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
    return CredsStorageImp(
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

final authenticatorPod = Provider<Authenticator>(
  (ref) {
    final githubAuthConfig = ref.watch(githubAuthConfigPod);
    return AuthenticatorImp(
      githubAuthConfig: githubAuthConfig,
    );
  },
);

final authServicePod = Provider<AuthService>(
  (ref) {
    final authenticator = ref.watch(authenticatorPod);
    final credsStorage = ref.watch(credsStoragePod);
    return AuthServiceImp(
      authenticator: authenticator,
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

Future<List<Override>> overrides() async => const [];
