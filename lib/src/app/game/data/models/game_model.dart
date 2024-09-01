import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skribla/src/app/auth/data/models/user_model.dart';
import 'package:skribla/src/app/game/data/models/line_model.dart';
import 'package:skribla/src/app/game/data/models/player_model.dart';
import 'package:skribla/src/app/game/data/models/word_model.dart';
import 'package:skribla/src/core/util/enums.dart';
import 'package:skribla/src/core/util/extension.dart';

part 'generated/game_model.freezed.dart';
part 'generated/game_model.g.dart';

@freezed
class GameModel with _$GameModel {
  const factory GameModel({
    required String id,
    required DateTime createdAt,
    required PlayerModel currentPlayer,
    required WordModel currentWord,
    @Default(GameStatus.open) GameStatus status,
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

  bool canDraw(String? uid) =>
      currentPlayer.uid == uid && online.length > 1 && status != GameStatus.complete;

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

  bool isCorrectGuess(String word) =>
      currentWord.text.toLowerCase() == word.toLowerCase() ||
      currentWord.loc.values.map((e) => e.toLowerCase()).contains(word.toLowerCase());

  bool hasBlockedUserConflict(UserModel user) {
    final isUserBlockingPlayer = players.any((player) => user.blockedUsers.contains(player.uid));
    final isPlayerBlockingUser = players.any((player) => player.blockedUsers.contains(user.uid));
    return isUserBlockingPlayer || isPlayerBlockingUser;
  }
}
