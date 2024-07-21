import 'package:draw_and_guess/src/app/game/presentation/provider/game_state.dart';
import 'package:draw_and_guess/src/core/di/di.dart';
import 'package:draw_and_guess/src/core/resource/app_icons.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SendMessageField extends StatefulWidget {
  const SendMessageField({
    super.key,
  });

  @override
  State<SendMessageField> createState() => _SendMessageFieldState();
}

class _SendMessageFieldState extends State<SendMessageField> {
  final _msgCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final status = ref.watch(
          gameProvider.select((it) => it.status),
        );
        return Row(
          children: [
            Expanded(
              child: InputField(
                readOnly: status == GameStatus.sendingMessage,
                controller: _msgCtrl,
                hint: 'guess or chat...',
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
                            if (success) _msgCtrl.clear();
                          });
                        },
                  child: Icon(AppIcons.paperPlaneRight),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
