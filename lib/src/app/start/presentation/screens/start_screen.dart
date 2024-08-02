import 'package:draw_and_guess/src/app/start/presentation/provider/start_state.dart';
import 'package:draw_and_guess/src/app/start/presentation/widgets/start_action.dart';
import 'package:draw_and_guess/src/core/di/di.dart';
import 'package:draw_and_guess/src/core/resource/app_icons.dart';
import 'package:draw_and_guess/src/core/router/routes.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:draw_and_guess/src/core/widgets/app_button.dart';
import 'package:draw_and_guess/src/core/widgets/gradient_text.dart';
import 'package:draw_and_guess/src/core/widgets/input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class StartScreen extends ConsumerStatefulWidget {
  const StartScreen({super.key});

  @override
  ConsumerState<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends ConsumerState<StartScreen> {
  final _nameCtrl = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final isLoggedIn = FirebaseAuth.instance.currentUser != null;
      if (isLoggedIn) {
        await ref.read(authProvider.notifier).getUser();
      } else {
        await ref.read(authProvider.notifier).signInAnonymously();
      }
      final user = ref.read(authProvider).user;
      setState(() {
        _nameCtrl.text = user?.name ?? '';
      });
      // FlutterNativeSplash.remove();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider.select((it) => it.user));
    final status = ref.watch(startProvider.select((it) => it.status));

    return Scaffold(
      body: Padding(
        padding: Config.symmetric(h: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GradientText(
              'Draw & Guess',
              style: context.textTheme.titleLarge,
              gradient: LinearGradient(
                colors: [
                  context.colorScheme.secondary,
                  context.colorScheme.primary,
                  context.colorScheme.secondary,
                ],
              ),
            ),
            Config.vBox24,
            InputField(
              controller: _nameCtrl,
              hint: 'Enter name',
              textAlign: TextAlign.center,
              readOnly: status == StartStatus.findingGame,
            ),
            Config.vBox24,
            ValueListenableBuilder(
              valueListenable: _nameCtrl,
              builder: (context, value, child) {
                return AppButton(
                  text: 'Play',
                  onPressed: value.text.trim().isEmpty ||
                          user == null ||
                          status == StartStatus.findingGame
                      ? null
                      : () async {
                          if (user.name != value.text.trim()) {
                            await ref.read(authProvider.notifier).updateUserName(value.text.trim());
                          }

                          if (!context.mounted) return;

                          await ref
                              .read(startProvider.notifier)
                              .findGame(user.copyWith(name: value.text.trim()))
                              .then((id) {
                            if (id != null) {
                              context.goNamed(Routes.game, pathParameters: {'id': id});
                            }
                          });
                        },
                );
              },
            ),
            Config.vBox24,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                StartAction(
                  icon: AppIcons.gear,
                  text: 'Settings',
                  onTap: () {},
                ),
                StartAction(
                  icon: AppIcons.trophy,
                  text: 'Leaderboard',
                  onTap: () => context.goNamed(Routes.leaderboard),
                ),
                StartAction(
                  icon: AppIcons.clockCounterClockwise,
                  text: 'History',
                  onTap: () => context.goNamed(Routes.history),
                ),
              ],
            ),
          ],
        ),
      ),
    ).watchBuild('StartScreen');
  }
}
