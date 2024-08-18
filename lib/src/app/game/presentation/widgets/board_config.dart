import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/constants.dart';
import 'package:skribla/src/core/util/extension.dart';

class BoardConfig extends ConsumerWidget {
  const BoardConfig({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider.select((it) => it.game));
    final user = ref.watch(authProvider.select((it) => it.user));
    final stroke = ref.watch(gameProvider.select((it) => it.stroke));
    final stateColor = ref.watch(gameProvider.select((it) => it.color));

    return (game?.canDraw(user?.uid) ?? false)
        ? Column(
            children: [
              Padding(
                padding: Config.symmetric(h: 15, v: 8),
                child: Row(
                  children: [
                    IconButton(
                      style: context.iconButtonStyle,
                      icon: Row(
                        children: [
                          Icon(AppIcons.eraser),
                          const SizedBox(width: 12),
                          Text(context.loc.clear),
                        ],
                      ),
                      onPressed: ref.read(gameProvider.notifier).clearBoard,
                    ),
                    const Spacer(),
                    IconButton(
                      style: context.iconButtonStyle,
                      icon: Icon(AppIcons.minusCircle),
                      onPressed: ref.read(gameProvider.notifier).decreaseStroke,
                    ),
                    Padding(
                      padding: Config.symmetric(h: 8),
                      child: Text('${context.loc.stroke}: $stroke'),
                    ),
                    IconButton(
                      style: context.iconButtonStyle,
                      icon: Icon(AppIcons.plusCircle),
                      onPressed: ref.read(gameProvider.notifier).increaseStroke,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Config.h(30),
                child: ListView.separated(
                  padding: Config.symmetric(h: 15),
                  itemCount: Constants.colors.length + 1,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => Config.hBox8,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return GestureDetector(
                        onTap: () {
                          final prevColor = ref.read(gameProvider).color;
                          context.showColorPicker(prevColor).then((color) {
                            if (color == null) return;
                            ref.read(gameProvider.notifier).changeColor(color);
                          });
                        },
                        child: Icon(
                          AppIcons.plusCircle,
                          size: Config.h(30),
                        ),
                      );
                    }
                    final color = Constants.colors[index - 1];
                    return GestureDetector(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: Config.h(15),
                            backgroundColor: color,
                          ),
                          if (stateColor == color) ...[
                            Icon(
                              AppIcons.check,
                              color: Colors.white,
                              size: Config.h(16),
                            ),
                          ],
                        ],
                      ),
                      onTap: () => ref.read(gameProvider.notifier).changeColor(color),
                    );
                  },
                ),
              ),
            ],
          )
        : const SizedBox.shrink();
  }
}
