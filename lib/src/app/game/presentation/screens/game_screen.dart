import 'package:draw_and_guess/src/app/game/presentation/widgets/draw_board.dart';
import 'package:draw_and_guess/src/app/game/presentation/widgets/message_view.dart';
import 'package:draw_and_guess/src/app/game/presentation/widgets/players_view.dart';
import 'package:draw_and_guess/src/app/game/presentation/widgets/send_message_field.dart';
import 'package:draw_and_guess/src/core/di/di.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:draw_and_guess/src/core/widgets/default_app_bar.dart';
import 'package:draw_and_guess/src/core/widgets/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({required this.id, super.key});
  final String id;

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameProvider.notifier).getGameStream(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (didPop) {
        ref.read(gameProvider.notifier).leaveGame();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: DefaultAppBar(
          title: Consumer(
            builder: (context, timer, child) {
              final state = timer.watch(timerProvider);
              if (state.showCoolTimer) {
                return ProgressBar(
                  key: const ValueKey('cool_timer'),
                  duration: state.coolTimer,
                );
              } else if (state.showSkipTimer) {
                return ProgressBar(
                  key: const ValueKey('skip_timer'),
                  duration: state.skipTimer,
                );
              } else if (state.showTurnTimer) {
                return ProgressBar(
                  key: const ValueKey('turn_timer'),
                  duration: state.turnTimer,
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
        body: Column(
          children: [
            const RepaintBoundary(child: DrawBoard()),
            Expanded(
              child: Padding(
                padding: Config.symmetric(h: 15),
                child: Row(
                  children: [
                    const Expanded(child: PlayersView()),
                    Config.hBox8,
                    Expanded(
                      flex: 3,
                      child: MessagesView(id: widget.id),
                    ),
                  ],
                ),
              ),
            ),
            Config.vBox8,
            Padding(
              padding: Config.symmetric(h: 15),
              child: const SendMessageField(),
            ),
            Config.vBox30,
          ],
        ),
      ),
    ).watchBuild('GameScreen');
  }
}
