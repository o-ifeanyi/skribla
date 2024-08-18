import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/game/presentation/widgets/board_config.dart';
import 'package:skribla/src/app/game/presentation/widgets/draw_board.dart';
import 'package:skribla/src/app/game/presentation/widgets/message_view.dart';
import 'package:skribla/src/app/game/presentation/widgets/players_view.dart';
import 'package:skribla/src/app/game/presentation/widgets/send_message_field.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/widgets/default_app_bar.dart';
import 'package:skribla/src/core/widgets/progress_bar.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({required this.id, super.key});
  final String id;

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  final GlobalKey _bottomSheetKey = GlobalKey();
  final _bottomSheetHeight = ValueNotifier<double>(90);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bottomSheetHeight.value = _bottomSheetKey.currentContext?.size?.height ?? 90;
      ref.read(gameProvider.notifier).getGameStream(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvokedWithResult: (_, __) {
        ref.read(gameProvider.notifier).leaveGame();
      },
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
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
              if (Config.width < 800) ...[
                const Expanded(
                  flex: 3,
                  child: RepaintBoundary(child: DrawBoard()),
                ),
                const BoardConfig(),
                Config.vBox8,
                Expanded(
                  flex: 2,
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
              ] else
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            const Expanded(child: RepaintBoundary(child: DrawBoard())),
                            const BoardConfig(),
                            Config.vBox8,
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: Config.fromLTRB(0, 0, 15, 0),
                          child: Column(
                            children: [
                              const Expanded(child: PlayersView()),
                              Config.vBox8,
                              Expanded(child: MessagesView(id: widget.id)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ValueListenableBuilder(
                valueListenable: _bottomSheetHeight,
                builder: (context, height, child) {
                  return SizedBox(height: height);
                },
              ),
              Config.vBox8,
            ],
          ),
          bottomSheet: Column(
            key: _bottomSheetKey,
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedPadding(
                duration: const Duration(milliseconds: 50),
                padding: context.padding.copyWith(
                  top: Config.h(8),
                  left: Config.w(15),
                  right: Config.w(15),
                  bottom: context.viewInsets.bottom + (kIsWeb ? 8 : 30),
                ),
                child: const SendMessageField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
