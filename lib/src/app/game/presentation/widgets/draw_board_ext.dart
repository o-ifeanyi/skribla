part of 'draw_board.dart';

class _BoardOverlay extends ConsumerWidget {
  const _BoardOverlay();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider.select((it) => it.user));
    final game = ref.watch(gameProvider.select((it) => it.game));
    final timerType = ref.watch(
      timerProvider.select((it) => it.timerType),
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (game?.status == GameStatus.complete) ...[
          Text.rich(
            TextSpan(
              text: '${context.loc.game} ',
              children: [
                TextSpan(
                  text: context.loc.completed,
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
          Wrap(
            spacing: Config.w(12),
            runSpacing: Config.h(12),
            alignment: WrapAlignment.center,
            children: [
              AppButton(
                text: context.loc.leaderboardBtnTxt,
                onPressed: () {
                  Support.instance.requestReview();
                  ref.read(gameProvider.notifier).leaveGame();
                  context.goNamed(Routes.leaderboard);
                },
              ),
              AppButton(
                text: context.loc.historyBtnTxt,
                onPressed: () {
                  Support.instance.requestReview();
                  ref.read(gameProvider.notifier).leaveGame();
                  context.goNamed(Routes.history);
                },
              ),
            ],
          ),
        ] else if ((game?.online ?? []).length < 2) ...[
          Text(
            game?.status == GameStatus.private
                ? context.loc.privateWaitingTxt
                : context.loc.publicWaitingTxt,
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
                  label: Text(context.loc.copy),
                  shape: RoundedRectangleBorder(borderRadius: Config.radius10),
                  avatar: Icon(AppIcons.copy),
                  onPressed: () => Support.instance
                      .copyToClipboard('${Env.baseUrl}/join/${game?.id}')
                      .then((success) {
                    if (success && context.mounted) {
                      Analytics.instance.capture(Event.copyLink);
                      Toast.instance.showSucess(
                        '${Env.baseUrl}/join/${game?.id}',
                        title: context.loc.copiedToClipboard,
                      );
                    }
                  }),
                ),
              ),
            ),
          ),
        ] else if (timerType == TimerType.cool) ...[
          if (game?.currentPlayer.uid == user?.uid) ...[
            Text.rich(
              TextSpan(
                text: '${context.loc.getReady} ',
                children: [
                  TextSpan(
                    text: '${game?.currentPlayer.name}',
                    style: TextStyle(
                      color: context.colorScheme.secondary,
                    ),
                  ),
                  TextSpan(text: '\n${context.loc.youAreUpNext}'),
                ],
              ),
              style: context.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ] else ...[
            Text.rich(
              TextSpan(
                text: '${game?.currentPlayer.name}',
                style: TextStyle(
                  color: context.colorScheme.secondary,
                ),
                children: [
                  TextSpan(
                    text: ' ${context.loc.isUpNext}',
                    style: TextStyle(
                      color: context.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              style: context.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ] else if (timerType == TimerType.complete) ...[
          Text(
            '🥳 ${context.loc.everyoneGuessedCorrectly}',
            style: context.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ] else if (game?.canDraw(user?.uid) ?? false) ...[
          if ((game?.currentArt ?? []).isEmpty)
            Text.rich(
              TextSpan(
                text: '${context.loc.draw} ',
                children: [
                  TextSpan(
                    text: '${game?.currentWord.locText}',
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
