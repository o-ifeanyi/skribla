import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';

class PlayersView extends ConsumerWidget {
  const PlayersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider.select((it) => it.game));
    return Container(
      decoration: BoxDecoration(
        borderRadius: Config.radius8,
        color: context.theme.inputDecorationTheme.fillColor,
      ),
      child: ListView.separated(
        padding: Config.all(8),
        itemCount: (game?.onlinePlayers ?? []).length,
        separatorBuilder: (_, __) => Config.vBox8,
        itemBuilder: (context, index) {
          final player = (game?.onlinePlayers ?? [])[index];
          return Row(
            children: [
              CircleAvatar(
                radius: Config.h(15),
                backgroundColor: context.colorScheme.tertiaryContainer,
                child: (game?.canDraw(player.uid) ?? false)
                    ? Icon(AppIcons.highlighter, size: Config.h(14))
                    : (game?.correctGuess ?? []).contains(player.uid)
                        ? Icon(AppIcons.check, size: Config.h(14))
                        : null,
              ),
              Config.hBox4,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelMedium,
                    ),
                    FittedBox(
                      child: Text(
                        '${player.points} pts',
                        style: context.textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
