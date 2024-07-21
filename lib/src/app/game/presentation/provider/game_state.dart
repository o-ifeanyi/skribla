import 'package:draw_and_guess/src/app/game/data/models/game_model.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/game_state.freezed.dart';

enum GameStatus { idle, sendingMessage }

@freezed
class GameState with _$GameState {
  const factory GameState({
    @Default(GameStatus.idle) GameStatus status,
    @Default(Colors.red) Color color,
    @Default(2) int stroke,
    @Default(null) GameModel? game,
  }) = _GameState;
}
