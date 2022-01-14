import 'package:auth/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth.cubit.freezed.dart';
part 'auth.state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required AuthService authService,
  })  : _authService = authService,
        super(const AuthState.loading(isLoggedIn: false));

  final AuthService _authService;

  bool get isLoading => state is _AuthStateLoading;

  Future<void> checkAuthStatus() async {
    emit(AuthState.loading(isLoggedIn: state.isLoggedIn));
    final isLoggedIn = await _authService.isLoggedIn();
    emit(AuthState.loaded(isLoggedIn: isLoggedIn));
  }

  Future<void> logIn({
    required LoginMethod method,
  }) async {
    emit(AuthState.loading(isLoggedIn: state.isLoggedIn));
    final failureOrNothing = await _authService.logIn(method: method);
    emit(
      failureOrNothing.when(
        err: (f) => AuthState.failure(
          isLoggedIn: state.isLoggedIn,
          failure: AuthenticatorFailure.logIn(f),
        ),
        ok: (_) => const AuthState.loaded(
          isLoggedIn: true,
        ),
      ),
    );
  }

  Future<void> logOut() async {
    emit(AuthState.loading(isLoggedIn: state.isLoggedIn));
    await _authService.logOut();
    emit(const AuthState.loaded(isLoggedIn: false));
  }
}
