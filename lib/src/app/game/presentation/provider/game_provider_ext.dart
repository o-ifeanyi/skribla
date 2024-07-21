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
    // only first online player actually calls the [updateNextPlayer] method
    // others just begin timers & shit

    if (prev == null) {
      update();
      return;
    }

    if (current.status == Status.complete) {
      // game ended
      // stop all timers & cancel sunscription
      timerProvider.reset();
      _gameStreamSub?.cancel();
      update();
      return;
    }

    if (current.currentArt.isNotEmpty) {
      // player started drawing
      // stop skip timer, start turn timer
      timerProvider
        ..stopSkipTimer()
        ..startTurnTimer(
          callback: () {
            if (current.online.first == user?.uid) {
              updateNextPlayer();
            }
          },
        );
    }

    if (prev.currentPlayer.uid != current.currentPlayer.uid) {
      // current player changed
      // start cool down timer after which skip timer starts
      timerProvider.startCoolTimer(
        callback: () {
          timerProvider.startSkipTimer(
            callback: () {
              if (current.online.first == user?.uid) {
                updateNextPlayer();
              }
            },
          );
        },
      );
    }
    update();
  }
}
