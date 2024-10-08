import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/auth/data/repository/auth_repository.dart';
import 'package:skribla/src/app/auth/presentation/provider/auth_state.dart';
import 'package:skribla/src/core/service/analytics.dart';
import 'package:skribla/src/core/service/toast.dart';
import 'package:skribla/src/core/util/enums.dart';

/// A provider class for managing authentication-related operations.
///
/// This class extends [StateNotifier] and manages the state of type [AuthState].
/// It provides functionality for signing in anonymously, signing in with providers (Apple and Google),
/// and retrieving the current user. It interacts with [AuthRepository] for authentication operations.
///
/// Key features:
/// - Supports anonymous sign-in
/// - Implements sign-in with Apple and Google providers
/// - Retrieves the current user
/// - Updates the user's name
/// - Deletes the user's account
/// - Manages the authentication state of the application
///
/// Usage:
/// This provider is typically used in conjunction with Riverpod to manage
/// the authentication state of the application throughout the app.

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider({
    required this.toast,
    required this.authRepository,
  }) : super(const AuthState());

  final Toast toast;
  final AuthRepository authRepository;

  Future<bool> signInAnonymously() async {
    state = state.copyWith(status: AuthStatus.signingIn);
    final res = await authRepository.signInAnonymously();
    state = state.copyWith(status: AuthStatus.idle);
    return res.when(
      success: (user) {
        state = state.copyWith(user: user);
        return true;
      },
      error: (error) {
        toast.showError(error.message);
        return false;
      },
    );
  }

  Future<bool> signInWithProvider(AuthOptions option) async {
    state = state.copyWith(status: AuthStatus.signingIn);
    final res = await authRepository.signInWithProvider(option);
    state = state.copyWith(status: AuthStatus.idle);
    return res.when(
      success: (user) {
        state = state.copyWith(user: user);
        Analytics.instance.capture(Event.signUp);
        return true;
      },
      error: (error) {
        toast.showError(error.message);
        return false;
      },
    );
  }

  Future<bool> getUser() async {
    final res = await authRepository.getUser();
    return res.when(
      success: (user) {
        state = state.copyWith(user: user);
        return true;
      },
      error: (error) => false,
    );
  }

  Future<bool> updateUserName(String name) async {
    if (state.user == null) return false;
    final res = await authRepository.updateUserName(name);
    return res.when(
      success: (success) {
        state = state.copyWith(user: state.user!.copyWith(name: name));
        return true;
      },
      error: (error) => false,
    );
  }

  Future<bool> deleteAccount() async {
    if (state.user == null) return false;
    state = state.copyWith(status: AuthStatus.deletingAccount);
    final res = await authRepository.deleteAccount();
    state = state.copyWith(status: AuthStatus.idle);
    return res.when(
      success: (success) {
        state = state.copyWith(user: null);
        signInAnonymously();
        return true;
      },
      error: (error) {
        toast.showError(error.message);
        return false;
      },
    );
  }
}
