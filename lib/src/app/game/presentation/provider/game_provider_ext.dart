part of 'game_provider.dart';

extension GameProviderExt on GameProvider {
  Offset? _getCurrentLocalPoint(BuildContext context, Offset globalPosition) {
    final box = context.findRenderObject() as RenderBox?;
    return box?.globalToLocal(globalPosition);
  }

  bool _exceedsBoundry(Offset point, BoxConstraints constraint) {
    return point.dx < 0 ||
        point.dx > constraint.maxWidth ||
        point.dy < 0 ||
        point.dy > constraint.maxHeight;
  }

  void _gameChangeHandler({
    required GameModel? prev,
    required GameModel current,
    required VoidCallback update,
  }) {
    final user = ref.read(authProvider).user;
    final timer = ref.read(timerProvider.notifier);
    // only first online player actually calls the [updateNextPlayer] method
    // others just begin timers & shit

    if (prev == null) {
      update();
      return;
    } else if (current.status == Status.complete) {
      // game ended
      // stop all timers & cancel sunscription
      if (current.online.first == user?.uid) {
        Analytics.instance.capture(
          Event.gameEnd,
          properties: {
            'num_of_arts': current.numOfArts,
            'num_of_players': current.players.length,
          },
        );
      }

      timer.reset();
      _gameStreamSub?.cancel();
      update();
      return;
    } else if (prev.online.length > current.online.length && current.online.length < 2) {
      // a player just left and only one(this) player left
      // the invite players screen should be showing at this point
      timer.reset();
      update();
      return;
    } else if ((prev.correctGuess.length != current.correctGuess.length) &&
        (current.correctGuess.length == current.onlinePlayers.length - 1)) {
      // all players guessed correctly
      timer
        ..stopTurnTimer()
        ..startCompleteTimer(
          callback: () {
            if (current.online.first == user?.uid) {
              updateNextPlayer();
            }
          },
        );
      update();
      return;
    } else if (prev.currentPlayer.uid != current.currentPlayer.uid) {
      // current player changed
      // start cool down timer after which skip timer starts
      timer
        ..stopSkipTimer()
        ..stopCompleteTimer()
        ..startCoolTimer(
          callback: () {
            timer.startSkipTimer(
              callback: () {
                if (current.online.first == user?.uid) {
                  updateNextPlayer();
                }
              },
              useHaptics: current.currentPlayer.uid == user?.uid,
            );
          },
        );
      update();
      return;
    } else if (current.currentArt.isNotEmpty) {
      // player started drawing
      // stop skip timer, start turn timer
      // can be called mutiple times because turn timer cannot be trigger more than once
      timer
        ..stopSkipTimer()
        ..startTurnTimer(
          callback: () {
            if (current.online.first == user?.uid) {
              updateNextPlayer();
            }
          },
          useHaptics: current.currentPlayer.uid == user?.uid,
        );
      update();
      return;
    }

    // it was not a change that needed a reaction
    update();
  }
}
