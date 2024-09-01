import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skribla/src/app/game/data/models/player_model.dart';
import 'package:skribla/src/core/util/enums.dart';

part 'generated/user_model.freezed.dart';
part 'generated/user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String uid,
    required DateTime createdAt,
    @Default('') String name,
    @Default('') String email,
    @Default(0) int reportCount,
    @Default([]) List<String> blockedUsers,
    @Default(null) int? lastWordIndex,
    @Default(UserStatus.anonymous) UserStatus status,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, Object?> json) => _$UserModelFromJson(json);

  factory UserModel.fromCredential(UserCredential credential) {
    final user = credential.user!;
    final random = List.generate(10, (index) => index)
      ..shuffle(Random(DateTime.now().millisecondsSinceEpoch));
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? 'anon_${random.take(4).join()}',
      status: (user.email ?? '').isEmpty ? UserStatus.anonymous : UserStatus.verified,
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
