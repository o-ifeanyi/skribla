import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/auth/data/models/user_model.dart';
import 'package:skribla/src/app/auth/data/repository/auth_repository.dart';
import 'package:skribla/src/app/leaderboard/presentation/widgets/leaderboard_item.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/util/types.dart';
import 'package:skribla/src/core/widgets/app_button.dart';
import 'package:skribla/src/core/widgets/shimmer_widget.dart';

class LeaderboardFooter extends ConsumerStatefulWidget {
  const LeaderboardFooter({
    super.key,
  });

  @override
  ConsumerState<LeaderboardFooter> createState() => _LeaderboardFooterState();
}

class _LeaderboardFooterState extends ConsumerState<LeaderboardFooter> {
  final getPosition = FutureProvider<LeaderboardPosition?>(
    (ref) async {
      return ref.read(leaderboardProvider.notifier).getLeaderboardPosition();
    },
  );

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider.select((it) => it.user));
    ref.listen(
      leaderboardProvider.select((it) => it.type),
      (_, __) => ref.refresh(getPosition),
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
              'Sign in to join the leadearboard',
              textAlign: TextAlign.center,
            ),
            Config.vBox12,
            if (!kIsWeb && Platform.isIOS) ...[
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      icon: Icon(AppIcons.appleLogo),
                      text: 'Apple',
                      onPressed: () {
                        ref
                            .read(authProvider.notifier)
                            .signInWithProvider(AuthOptions.apple)
                            .then((success) {
                          if (success) {
                            final _ = ref.refresh(getPosition);
                          }
                        });
                      },
                    ),
                  ),
                  Config.hBox12,
                  Expanded(
                    child: AppButton(
                      icon: Icon(AppIcons.googleLogo),
                      text: 'Google',
                      onPressed: () {
                        ref
                            .read(authProvider.notifier)
                            .signInWithProvider(AuthOptions.google)
                            .then((success) {
                          if (success) {
                            final _ = ref.refresh(getPosition);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ] else ...[
              AppButton(
                icon: Icon(AppIcons.googleLogo),
                text: 'Continue with Google',
                onPressed: () {
                  ref
                      .read(authProvider.notifier)
                      .signInWithProvider(AuthOptions.google)
                      .then((success) {
                    if (success) {
                      final _ = ref.refresh(getPosition);
                    }
                  });
                },
              ),
            ],
          ] else if (user?.status == AuthStatus.verified) ...[
            positionRef.when(
              skipLoadingOnRefresh: false,
              data: (data) {
                if (data == null) return const SizedBox.shrink();
                return LeaderboardItem(
                  data: data,
                  name: '${user?.name} (you)',
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
