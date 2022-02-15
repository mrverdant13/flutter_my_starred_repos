import 'package:auth/src/domain/login_failure.dart';
import 'package:auth/src/domain/login_method.dart';
import 'package:auth/src/infrastructure/auth.service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:state_notifier/state_notifier.dart';

part 'auth.notifier.freezed.dart';
part 'auth.failure.dart';
part 'auth.state.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier({
    required AuthService authService,
  })  : _authService = authService,
        super(const AuthState.loading(isLoggedIn: false));

  final AuthService _authService;

  bool get isLoading => state is _AuthStateLoading;

  Future<void> checkAuthStatus() async {
    state = AuthState.loading(isLoggedIn: state.isLoggedIn);
    final isLoggedIn = await _authService.isLoggedIn();
    state = AuthState.loaded(isLoggedIn: isLoggedIn);
  }

  Future<void> logIn({
    required LoginMethod method,
  }) async {
    state = AuthState.loading(isLoggedIn: state.isLoggedIn);
    final failureOrNothing = await _authService.logIn(method: method);
    state = failureOrNothing.when(
      err: (f) => AuthState.failure(
        isLoggedIn: state.isLoggedIn,
        failure: AuthFailure.logIn(f),
      ),
      ok: (_) => const AuthState.loaded(
        isLoggedIn: true,
      ),
    );
  }

  Future<void> logOut() async {
    state = AuthState.loading(isLoggedIn: state.isLoggedIn);
    await _authService.logOut();
    state = const AuthState.loaded(isLoggedIn: false);
  }
}
