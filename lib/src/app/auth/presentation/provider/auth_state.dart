import 'package:draw_and_guess/src/app/auth/data/models/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/auth_state.freezed.dart';

enum AuthStatus { idle, signingIn, gettingUser }

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(null) UserModel? user,
  }) = _AuthState;
}
