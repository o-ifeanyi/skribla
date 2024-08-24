import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/game/data/models/message_model.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';

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
      final messages = ref.read(gameRepoProvider).getMessages(id);
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
                  return _MessageBubble(
                    title: switch (message.messageType) {
                      MessageType.correctGuess || MessageType.wordReveal => context.loc.gamebot,
                      _ => message.name,
                    },
                    subtitle: switch (message.messageType) {
                      MessageType.correctGuess => context.loc.correctGuessMsg(message.text),
                      MessageType.wordReveal => context.loc.revealWordMsg(message.locText),
                      _ => message.text,
                    },
                  );
                },
              );
            },
            orElse: () => const SizedBox.expand(),
          );
        },
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Config.symmetric(h: 10, v: 4),
      decoration: BoxDecoration(
        borderRadius: Config.radius8,
        color: context.colorScheme.tertiaryContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '@ $title',
            style: context.textTheme.labelMedium,
          ),
          Text(
            subtitle,
            style: context.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
