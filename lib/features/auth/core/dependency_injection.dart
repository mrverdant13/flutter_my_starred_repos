import 'package:creds_lds/creds_lds.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../core/config.dart';
import '../../../core/dependency_injection.dart';
import '../application/authenticator_cubit/authenticator_cubit.dart';
import '../infrastructure/data_sources/authenticator/github.dart';
import '../infrastructure/data_sources/authenticator/interface.dart';
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

final credsLDSPod = Provider<CredsLDS>(
  (ref) {
    final flutterSecureStorage = ref.watch(flutterSecureStoragePod);
    return CredsLDSImp(
      flutterSecureStorage: flutterSecureStorage,
    );
  },
);

final authInterceptorPod = Provider<AuthInterceptor>(
  (ref) {
    final credsLDS = ref.watch(credsLDSPod);
    return AuthInterceptor(
      credsLDS: credsLDS,
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
    final credsLDS = ref.watch(credsLDSPod);
    return AuthServiceImp(
      authenticator: authenticator,
      credsLDS: credsLDS,
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
