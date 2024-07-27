import 'package:draw_and_guess/src/app/game/data/models/message_model.dart';
import 'package:draw_and_guess/src/core/di/di.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesView extends StatefulWidget {
  const MessagesView({
    required this.id,
    super.key,
  });
  final String id;

  @override
  State<MessagesView> createState() => _MessagesViewState();
}

class _MessagesViewState extends State<MessagesView> {
  final getMessages = StreamProvider.family<List<MessageModel>, String>(
    (ref, id) async* {
      final messages = ref.read(gameProvider.notifier).getMessages(id);
      await for (final message in messages) {
        yield message;
      }
    },
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Config.radius8,
        color: context.theme.inputDecorationTheme.fillColor,
      ),
      child: Consumer(
        builder: (context, ref, child) {
          final messagesRef = ref.watch(getMessages(widget.id));
          return messagesRef.maybeWhen(
            data: (data) {
              return ListView.separated(
                padding: Config.all(8),
                reverse: true,
                itemCount: data.length,
                separatorBuilder: (_, __) => Config.vBox8,
                itemBuilder: (context, index) {
                  final message = data.reversed.toList()[index];
                  return Container(
                    padding: Config.symmetric(h: 10, v: 4),
                    decoration: BoxDecoration(
                      borderRadius: Config.radius8,
                      color: context.colorScheme.tertiaryContainer,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (message.correctGuess || message.name == null) ...[
                          Text(
                            message.text.toUpperCase(),
                            style: context.textTheme.labelLarge,
                          ),
                        ] else ...[
                          Text(
                            '@ ${message.name}',
                            style: context.textTheme.labelSmall,
                          ),
                          Text(
                            message.text,
                            style: context.textTheme.bodySmall,
                          ),
                        ],
                      ],
                    ),
                  );
                },
              );
            },
            orElse: () => const SizedBox.expand(),
          );
        },
      ).watchBuild('MessagesView'),
    );
  }
}
