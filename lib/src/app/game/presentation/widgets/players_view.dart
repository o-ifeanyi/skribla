import 'package:draw_and_guess/src/core/di/di.dart';
import 'package:draw_and_guess/src/core/resource/app_icons.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayersView extends ConsumerWidget {
  const PlayersView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final game = ref.watch(gameProvider.select((it) => it.game));
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: (game?.onlinePlayers ?? []).length,
      separatorBuilder: (_, __) => Config.vBox8,
      itemBuilder: (context, index) {
        final player = (game?.onlinePlayers ?? [])[index];
        return Row(
          children: [
            CircleAvatar(
              radius: Config.w(15),
              backgroundColor: context.colorScheme.tertiaryContainer,
              child: (game?.canDraw(player.uid) ?? false)
                  ? Icon(AppIcons.pencilSimple, size: Config.dg(14))
                  : (game?.correctGuess ?? []).contains(player.uid)
                      ? Icon(AppIcons.check, size: Config.dg(14))
                      : null,
            ),
            Config.hBox4,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.name,
                    style: context.textTheme.labelSmall,
                  ),
                  Text(
                    '${10 * (index + 1)} pts',
                    style: context.textTheme.labelLarge,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ).watchBuild('PlayersView');
  }
}
