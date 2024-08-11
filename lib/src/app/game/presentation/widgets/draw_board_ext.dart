part of 'draw_board.dart';

class _BoardOverlay extends ConsumerWidget {
  const _BoardOverlay();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider.select((it) => it.user));
    final game = ref.watch(gameProvider.select((it) => it.game));
    final showCoolTimer = ref.watch(
      timerProvider.select((it) => it.showCoolTimer),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (game?.status == Status.complete) ...[
          Text.rich(
            TextSpan(
              text: 'Game ',
              children: [
                TextSpan(
                  text: 'Completed!',
                  style: TextStyle(
                    color: context.colorScheme.secondary,
                  ),
                ),
              ],
            ),
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Config.vBox12,
          AppButton(
            text: 'View Gallery',
            onPressed: () {
              Support.instance.requestReview();
              ref.read(gameProvider.notifier).leaveGame();
              context.goNamed(Routes.history);
            },
          ),
        ] else if ((game?.online ?? []).length < 2) ...[
          Text(
            game?.status == Status.private
                ? 'Only invited players can join'
                : 'Waiting for players to join',
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Config.vBox12,
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: InputField(
              key: ValueKey(game?.id),
              readOnly: true,
              initialValue: '${Env.baseUrl}/join/${game?.id}',
              fillColor: context.colorScheme.surface,
              suffixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ActionChip(
                  label: const Text('Copy'),
                  shape: RoundedRectangleBorder(borderRadius: Config.radius10),
                  avatar: Icon(AppIcons.copy),
                  onPressed: () => Deeplink.instance.copyJoinLink(id: game?.id),
                ),
              ),
            ),
          ),
        ] else if (showCoolTimer) ...[
          Text.rich(
            TextSpan(
              text: 'Get ready ',
              children: [
                TextSpan(
                  text: '${game?.currentPlayer.name}',
                  style: TextStyle(
                    color: context.colorScheme.secondary,
                  ),
                ),
                const TextSpan(text: "\nYou're up next"),
              ],
            ),
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ] else if (game?.canDraw(user?.uid) ?? false) ...[
          if ((game?.currentArt ?? []).isEmpty)
            Text.rich(
              TextSpan(
                text: 'Draw ',
                children: [
                  TextSpan(
                    text: '${game?.currentWord.text}',
                    style: TextStyle(
                      color: context.colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              style: context.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
        ],
      ],
    );
  }
}

class _BoardConfig extends ConsumerWidget {
  const _BoardConfig();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stroke = ref.watch(gameProvider.select((it) => it.stroke));
    final stateColor = ref.watch(gameProvider.select((it) => it.color));
    return Column(
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
                    const Text('Clear'),
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
                child: Text('Stroke: $stroke'),
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
    );
  }
}
