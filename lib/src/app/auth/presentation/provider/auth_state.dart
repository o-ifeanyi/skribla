import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skribla/src/app/auth/data/models/user_model.dart';

part 'generated/auth_state.freezed.dart';

enum AuthStatus { idle, signingIn, deletingAccount }

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.idle) AuthStatus status,
    @Default(null) UserModel? user,
  }) = _AuthState;
}
