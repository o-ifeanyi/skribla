import 'package:draw_and_guess/src/app/game/data/models/player_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/user_model.freezed.dart';
part 'generated/user_model.g.dart';

enum AuthStatus { anonymous, verified }

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    required DateTime createdAt,
    @Default('') String name,
    @Default('') String email,
    @Default(AuthStatus.anonymous) AuthStatus status,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromCredential(UserCredential credential) {
    final user = credential.user!;
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      status: (user.email ?? '').isEmpty
          ? AuthStatus.anonymous
          : AuthStatus.verified,
      createdAt: DateTime.now(),
    );
  }

  PlayerModel toPlayer() {
    return PlayerModel(
      uid: uid,
      name: name,
      createdAt: createdAt,
    );
  }
}
