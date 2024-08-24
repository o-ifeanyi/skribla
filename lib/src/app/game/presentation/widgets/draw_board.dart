import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skribla/env/env.dart';
import 'package:skribla/src/app/game/data/models/game_model.dart';
import 'package:skribla/src/app/game/presentation/provider/timer_state.dart';
import 'package:skribla/src/app/game/presentation/widgets/art_painter.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/router/routes.dart';
import 'package:skribla/src/core/service/analytics.dart';
import 'package:skribla/src/core/service/support.dart';
import 'package:skribla/src/core/service/toast.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/widgets/app_button.dart';
import 'package:skribla/src/core/widgets/input_field.dart';

part 'draw_board_ext.dart';

class DrawBoard extends ConsumerWidget {
  const DrawBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider.select((it) => it.game));
    final user = ref.watch(authProvider.select((it) => it.user));
    final timerType = ref.watch(
      timerProvider.select((it) => it.timerType),
    );

    return Container(
      margin: Config.symmetric(h: 15),
      decoration: BoxDecoration(
        borderRadius: Config.radius16,
        color: context.theme.inputDecorationTheme.fillColor,
      ),
      child: LayoutBuilder(
        builder: (context, constraint) {
          return Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(
                size: constraint.biggest,
                painter: ArtPainter(
                  art: timerType == TimerType.complete ? [] : (game?.currentArt ?? []),
                ),
              ),
              Padding(
                padding: Config.all(10),
                child: const _BoardOverlay(),
              ),
              if ((game?.canDraw(user?.uid) ?? false) && timerType != TimerType.cool) ...[
                GestureDetector(
                  onPanStart: (details) {
                    ref.read(gameProvider.notifier).onPanStart(context, details, constraint);
                  },
                  onPanUpdate: (details) {
                    ref.read(gameProvider.notifier).onPanUpdate(context, details, constraint);
                  },
                  onPanEnd: (details) {
                    ref.read(gameProvider.notifier).onPanEnd();
                  },
                ),
              ],
              if ((game?.currentArt ?? []).isNotEmpty)
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Config.radius16.topRight,
                      ),
                      color: context.colorScheme.surface,
                    ),
                    child: ((game?.canDraw(user?.uid) ?? false) && timerType != TimerType.cool)
                        ? Text(
                            game?.currentWord.locText ?? '',
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.secondary,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        : game != null
                            ? Text(
                                context.loc.nletterWord(game.currentWord.locText.split('').length),
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: context.colorScheme.secondary,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : null,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
