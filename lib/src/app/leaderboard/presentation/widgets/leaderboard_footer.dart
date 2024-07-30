import 'dart:io';

import 'package:draw_and_guess/src/app/auth/data/models/user_model.dart';
import 'package:draw_and_guess/src/app/leaderboard/presentation/widgets/leaderboard_item.dart';
import 'package:draw_and_guess/src/core/di/di.dart';
import 'package:draw_and_guess/src/core/resource/app_icons.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:draw_and_guess/src/core/util/types.dart';
import 'package:draw_and_guess/src/core/widgets/app_button.dart';
import 'package:draw_and_guess/src/core/widgets/shimmer_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaderboardFooter extends ConsumerStatefulWidget {
  const LeaderboardFooter({
    super.key,
  });

  @override
  ConsumerState<LeaderboardFooter> createState() => _LeaderboardFooterState();
}

class _LeaderboardFooterState extends ConsumerState<LeaderboardFooter> {
  final getPosition = FutureProvider<LeaderboardPosition>(
    (ref) async {
      // await Future.delayed(Duration(seconds: 3));
      return ref.read(leaderboardProvider.notifier).getLeaderboardPosition();
    },
  );

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider.select((it) => it.user));
    ref.listen(
      leaderboardProvider.select((it) => it.type),
      (_, __) {
        if (user?.status != AuthStatus.verified) return;
        return ref.refresh(getPosition);
      },
    );
    final positionRef = ref.watch(getPosition);
    return Padding(
      padding: Config.symmetric(h: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Config.vBox12,
          if (user?.status == AuthStatus.anonymous) ...[
            const Text(
              'Sign up to join the leadearboard',
              textAlign: TextAlign.center,
            ),
            Config.vBox12,
            if (!kIsWeb && Platform.isIOS) ...[
              AppButton(
                hPadding: 15,
                icon: Icon(AppIcons.appleLogo),
                text: 'Continue with Apple',
                onPressed: () {},
              ),
            ] else ...[
              AppButton(
                hPadding: 15,
                icon: Icon(AppIcons.googleLogo),
                text: 'Continue with Google',
                onPressed: () {},
              ),
            ],
          ] else if (user?.status == AuthStatus.verified) ...[
            positionRef.when(
              skipLoadingOnRefresh: false,
              data: (data) {
                return LeaderboardItem(
                  data: data,
                  name: user?.name,
                );
              },
              error: (error, stackTrace) {
                return Text(
                  error.toString(),
                  textAlign: TextAlign.center,
                );
              },
              loading: () {
                return ShimmerWidget(
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const CircleAvatar(),
                    title: ColoredBox(
                      color: context.colorScheme.surface,
                      child: const Text(''),
                    ),
                    subtitle: ColoredBox(
                      color: context.colorScheme.surface,
                      child: Text('', style: context.textTheme.bodySmall),
                    ),
                  ),
                );
              },
            ),
          ],
          Config.vBox30,
        ],
      ),
    );
  }
}
