import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/game/presentation/provider/game_state.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/widgets/input_field.dart';

class SendMessageField extends ConsumerStatefulWidget {
  const SendMessageField({
    super.key,
  });

  @override
  ConsumerState<SendMessageField> createState() => _SendMessageFieldState();
}

class _SendMessageFieldState extends ConsumerState<SendMessageField> {
  final _msgCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider.select((it) => it.user));
    final game = ref.watch(gameProvider.select((it) => it.game));
    final status = ref.watch(gameProvider.select((it) => it.status));

    return Row(
      children: [
        Expanded(
          child: InputField(
            readOnly: (game?.canDraw(user?.uid) ?? false) || // your turn
                (game?.online ?? []).length < 2 || // only one person
                !(game?.online ?? []).contains(user?.uid) || // spectator (via deeplink)
                status == GameStatus.sendingMessage, // loading
            controller: _msgCtrl,
            hint: context.loc.guessOrChat,
            maxLines: null,
          ),
        ),
        Config.hBox8,
        ValueListenableBuilder(
          valueListenable: _msgCtrl,
          builder: (context, ctrl, child) {
            return GestureDetector(
              onTap: _msgCtrl.text.trim().isEmpty
                  ? null
                  : () {
                      final user = ref.read(authProvider).user;
                      if (user == null) return;
                      ref
                          .read(gameProvider.notifier)
                          .sendMessage(
                            text: _msgCtrl.text,
                            name: user.name,
                          )
                          .then((success) {
                        if (success && context.mounted) {
                          _msgCtrl.clear();
                          FocusScope.of(context).unfocus();
                        }
                      });
                    },
              child: Icon(AppIcons.paperPlaneRight),
            );
          },
        ),
      ],
    );
  }
}
