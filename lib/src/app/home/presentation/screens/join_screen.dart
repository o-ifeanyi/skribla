import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skribla/src/app/home/presentation/provider/home_state.dart';
import 'package:skribla/src/app/home/presentation/widgets/logo_text.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/router/routes.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/widgets/app_button.dart';
import 'package:skribla/src/core/widgets/input_field.dart';

class JoinScreen extends ConsumerStatefulWidget {
  const JoinScreen({required this.id, super.key});

  final String id;

  @override
  ConsumerState<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends ConsumerState<JoinScreen> {
  final _nameCtrl = TextEditingController();

  @override
  void setState(VoidCallback fn) {
    if (!mounted) return;
    super.setState(fn);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
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
              readOnly: status == HomeStatus.joiningGame,
            ),
            Config.vBox24,
            ValueListenableBuilder(
              valueListenable: _nameCtrl,
              builder: (context, value, child) {
                return AppButton(
                  text: 'Join game',
                  onPressed: value.text.trim().isEmpty ||
                          user == null ||
                          status == HomeStatus.joiningGame
                      ? null
                      : () async {
                          if (user.name != value.text.trim()) {
                            await ref.read(authProvider.notifier).updateUserName(value.text.trim());
                          }

                          if (!context.mounted) return;

                          await ref
                              .read(homeProvider.notifier)
                              .joinGame(
                                id: widget.id,
                                user: user.copyWith(name: value.text.trim()),
                              )
                              .then((id) {
                            if (id != null) {
                              context.replaceNamed(Routes.game, pathParameters: {'id': id});
                            }
                          });
                        },
                );
              },
            ),
            Config.vBox16,
            AppButton(
              text: 'Go to home page',
              type: ButtonType.outlined,
              onPressed: context.pop,
            ),
            Config.vBox24,
          ],
        ),
      ),
    ).watchBuild('JoinScreen');
  }
}
