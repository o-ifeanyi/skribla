import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skribla/src/app/game/data/models/game_model.dart';
import 'package:skribla/src/app/game/presentation/widgets/art_painter.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/router/routes.dart';
import 'package:skribla/src/core/service/deeplink.dart';
import 'package:skribla/src/core/service/support.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/constants.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/widgets/app_button.dart';

part 'draw_board_ext.dart';

class DrawBoard extends ConsumerWidget {
  const DrawBoard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider.select((it) => it.game));
    final user = ref.watch(authProvider.select((it) => it.user));
    final showCoolTimer = ref.watch(
      timerProvider.select((it) => it.showCoolTimer),
    );

    return Column(
      children: [
        Container(
          margin: Config.symmetric(h: 15),
          height: Config.height * 0.45,
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
                      art: game?.currentArt ?? [],
                    ),
                  ),
                  Padding(
                    padding: Config.all(10),
                    child: const _BoardOverlay(),
                  ),
                  if ((game?.canDraw(user?.uid) ?? false) && !showCoolTimer)
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
              );
            },
          ),
        ),
        AnimatedSwitcher(
          duration: Config.duration300,
          child:
              (game?.canDraw(user?.uid) ?? false) ? const _BoardConfig() : const SizedBox.shrink(),
        ),
        Config.vBox8,
      ],
    ).watchBuild('DrawBoard');
  }
}
