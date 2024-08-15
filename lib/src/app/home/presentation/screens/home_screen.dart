import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skribla/src/app/home/presentation/provider/home_state.dart';
import 'package:skribla/src/app/home/presentation/widgets/logo_text.dart';
import 'package:skribla/src/app/home/presentation/widgets/start_action.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/router/routes.dart';
import 'package:skribla/src/core/service/analytics.dart';
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
      FlutterNativeSplash.remove();

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
      body: Center(
        child: Container(
          padding: Config.symmetric(h: 15),
          constraints: const BoxConstraints(maxWidth: 600),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LogoText(),
              Config.vBox24,
              InputField(
                controller: _nameCtrl,
                hint: context.loc.gotoHomeBtnTxt,
                textAlign: TextAlign.center,
                readOnly: status == HomeStatus.findingGame || status == HomeStatus.creatingGame,
              ),
              Config.vBox24,
              ValueListenableBuilder(
                valueListenable: _nameCtrl,
                builder: (context, value, child) {
                  final inValid = value.text.trim().isEmpty ||
                      user == null ||
                      status == HomeStatus.findingGame ||
                      status == HomeStatus.creatingGame;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AppButton(
                        text: context.loc.playBtnTxt,
                        onPressed: inValid
                            ? null
                            : () async {
                                await ref
                                    .read(homeProvider.notifier)
                                    .findGame(user.copyWith(name: value.text.trim()))
                                    .then((id) {
                                  if (id != null && context.mounted) {
                                    Analytics.instance.capture(Event.playGame);
                                    context.goNamed(Routes.game, pathParameters: {'id': id});
                                  }
                                });
                              },
                      ),
                      Config.vBox16,
                      AppButton(
                        text: context.loc.createGameBtnTxt,
                        type: ButtonType.outlined,
                        onPressed: inValid
                            ? null
                            : () async {
                                await ref
                                    .read(homeProvider.notifier)
                                    .createGame(user.copyWith(name: value.text.trim()))
                                    .then((id) {
                                  if (id != null && context.mounted) {
                                    Analytics.instance.capture(Event.createGame);
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: StartAction(
                      icon: AppIcons.gear,
                      text: context.loc.settingsBtnTxt,
                      onTap: () => context.goNamed(Routes.settings),
                    ),
                  ),
                  Expanded(
                    child: StartAction(
                      icon: AppIcons.trophy,
                      text: context.loc.leaderboardBtnTxt,
                      onTap: user == null ? null : () => context.goNamed(Routes.leaderboard),
                    ),
                  ),
                  Expanded(
                    child: StartAction(
                      icon: AppIcons.clockCounterClockwise,
                      text: context.loc.historyBtnTxt,
                      onTap: user == null ? null : () => context.goNamed(Routes.history),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
