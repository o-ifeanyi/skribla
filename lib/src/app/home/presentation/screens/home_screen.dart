import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skribla/src/app/home/presentation/provider/home_state.dart';
import 'package:skribla/src/app/home/presentation/widgets/logo_text.dart';
import 'package:skribla/src/app/home/presentation/widgets/start_action.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/router/routes.dart';
import 'package:skribla/src/core/service/remote_config.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/widgets/app_button.dart';
import 'package:skribla/src/core/widgets/input_field.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _nameCtrl = TextEditingController();

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await RemoteConfig.instance.init();

      final isLoggedIn = FirebaseAuth.instance.currentUser != null;
      if (isLoggedIn) {
        await ref.read(authProvider.notifier).getUser();
      } else {
        await ref.read(authProvider.notifier).signInAnonymously();
      }
      // FlutterNativeSplash.remove();

      if (!mounted) return;
      final user = ref.read(authProvider).user;
      setState(() {
        _nameCtrl.text = user?.name ?? '';
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      authProvider.select((it) => it.user),
      (_, user) => setState(() {
        _nameCtrl.text = user?.name ?? '';
      }),
    );

    final user = ref.watch(authProvider.select((it) => it.user));
    final status = ref.watch(homeProvider.select((it) => it.status));

    return Scaffold(
      body: Padding(
        padding: Config.symmetric(h: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LogoText(),
            Config.vBox24,
            InputField(
              controller: _nameCtrl,
              hint: 'Enter name',
              textAlign: TextAlign.center,
              readOnly: status == HomeStatus.findingGame,
            ),
            Config.vBox24,
            ValueListenableBuilder(
              valueListenable: _nameCtrl,
              builder: (context, value, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppButton(
                      text: 'Play',
                      onPressed: value.text.trim().isEmpty ||
                              user == null ||
                              status == HomeStatus.findingGame
                          ? null
                          : () async {
                              if (user.name != value.text.trim()) {
                                await ref
                                    .read(authProvider.notifier)
                                    .updateUserName(value.text.trim());
                              }

                              if (!context.mounted) return;

                              await ref
                                  .read(homeProvider.notifier)
                                  .findGame(user.copyWith(name: value.text.trim()))
                                  .then((id) {
                                if (id != null) {
                                  context.goNamed(Routes.game, pathParameters: {'id': id});
                                }
                              });
                            },
                    ),
                    Config.vBox16,
                    AppButton(
                      text: 'Create game',
                      type: ButtonType.outlined,
                      onPressed: value.text.trim().isEmpty ||
                              user == null ||
                              status == HomeStatus.findingGame
                          ? null
                          : () async {
                              if (user.name != value.text.trim()) {
                                await ref
                                    .read(authProvider.notifier)
                                    .updateUserName(value.text.trim());
                              }

                              if (!context.mounted) return;

                              await ref
                                  .read(homeProvider.notifier)
                                  .createGame(user.copyWith(name: value.text.trim()))
                                  .then((id) {
                                if (id != null) {
                                  context.goNamed(Routes.game, pathParameters: {'id': id});
                                }
                              });
                            },
                    ),
                  ],
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
                  onTap: () => context.goNamed(Routes.settings),
                ),
                StartAction(
                  icon: AppIcons.trophy,
                  text: 'Leaderboard',
                  onTap: user == null ? null : () => context.goNamed(Routes.leaderboard),
                ),
                StartAction(
                  icon: AppIcons.clockCounterClockwise,
                  text: 'History',
                  onTap: user == null ? null : () => context.goNamed(Routes.history),
                ),
              ],
            ),
          ],
        ),
      ),
    ).watchBuild('StartScreen');
  }
}
