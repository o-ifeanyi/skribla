import 'package:draw_and_guess/src/app/game/data/models/line_model.dart';
import 'package:draw_and_guess/src/app/game/data/models/player_model.dart';
import 'package:draw_and_guess/src/app/game/data/models/word_model.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/game_model.freezed.dart';
part 'generated/game_model.g.dart';

enum Status { open, closed, complete }

@freezed
class GameModel with _$GameModel {
  const factory GameModel({
    required String id,
    required DateTime createdAt,
    required PlayerModel currentPlayer,
    required WordModel currentWord,
    @Default(Status.open) Status status,
    @Default([]) List<String> uids,
    @Default([]) List<String> correctGuess,
    @Default([]) List<PlayerModel> players,
    @Default([]) List<String> online,
    @Default([]) List<LineModel> currentArt,
    @Default(4) int numOfPlayers,
    @Default(0) int numOfArts,
  }) = _GameModel;

  const GameModel._();

  factory GameModel.fromJson(Map<String, Object?> json) => _$GameModelFromJson(json);

  bool canDraw(String? uid) => currentPlayer.uid == uid && status != Status.complete;

  List<WordModel> get availableWords => onlinePlayers
      .map((player) => player.words.where((word) => word.available))
      .fold([], (prev, current) => [...prev, ...current]);

  ({PlayerModel player, WordModel? word}) nextPlayerAndWord(int index) {
    PlayerModel nextPlayer;
    if (index < online.lastIndex) {
      final uid = online[index + 1];
      nextPlayer = players.firstWhere((player) => player.uid == uid);
    } else {
      final uid = online[0];
      nextPlayer = players.firstWhere((player) => player.uid == uid);
    }
    if (availableWords.length > 1) {
      // there is a player left with word to draw
      final nextWord = nextPlayer.nextWord;
      if (nextWord != null) {
        return (player: nextPlayer, word: nextWord);
      } else {
        return nextPlayerAndWord(index + 1);
      }
    } else {
      // all words have been drawn
      return (player: nextPlayer, word: null);
    }
  }

  List<PlayerModel> get onlinePlayers => players
      .where(
        (player) => online.contains(player.uid),
      )
      .toList();
}
