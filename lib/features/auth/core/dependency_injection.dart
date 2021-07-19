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

/// Injects all instances required for auth funcionality.
Future<void> injectDependencies() async {
  // Config
  getIt.registerLazySingleton(
    () => getIt<AppConfig>().githubAuthConfig,
  );

  // External
  getIt.registerLazySingleton(
    () => const FlutterSecureStorage(),
  );
  getIt.registerLazySingleton(
    () => AuthInterceptor(
      credsStorage: getIt(),
    ),
  );

  // Data sources
  getIt.registerLazySingleton<Authenticator>(
    () => AuthenticatorImp(
      githubAuthConfig: getIt(),
    ),
  );
  getIt.registerLazySingleton<CredsStorage>(
    () => CredsStorageImp(
      flutterSecureStorage: getIt(),
    ),
  );

  // Facades
  getIt.registerLazySingleton<AuthService>(
    () => AuthServiceImp(
      authenticator: getIt(),
      credsStorage: getIt(),
    ),
  );

  // State managers
  getIt.registerFactory(
    () => AuthenticatorCubit(
      authService: getIt(),
    ),
  );
}
