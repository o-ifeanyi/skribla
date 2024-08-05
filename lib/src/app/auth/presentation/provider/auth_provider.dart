import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/auth/data/repository/auth_repository.dart';
import 'package:skribla/src/app/auth/presentation/provider/auth_state.dart';

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider({required this.authRepository}) : super(const AuthState());

  final AuthRepository authRepository;

  Future<bool> signInAnonymously() async {
    final res = await authRepository.signInAnonymously();
    return res.when(
      success: (user) {
        state = state.copyWith(user: user);
        return true;
      },
      error: (error) => false,
    );
  }

  Future<bool> signInWithProvider(AuthOptions option) async {
    final res = await authRepository.signInWithProvider(option);
    return res.when(
      success: (user) {
        state = state.copyWith(user: user);
        return true;
      },
      error: (error) => false,
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
    final res = await authRepository.deleteAccount();
    return res.when(
      success: (success) {
        state = state.copyWith(user: null);
        return true;
      },
      error: (error) => false,
    );
  }
}
