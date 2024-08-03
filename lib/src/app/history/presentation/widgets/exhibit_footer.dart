import 'package:draw_and_guess/src/app/history/data/models/exhibit_model.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:draw_and_guess/src/core/widgets/app_button.dart';
import 'package:flutter/material.dart';

class ExhibitFooter extends StatelessWidget {
  const ExhibitFooter({
    required this.exhibit,
    required this.onShare,
    super.key,
  });

  final ExhibitModel exhibit;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: Config.all(15),
          child: Text.rich(
            TextSpan(
              text: exhibit.word.text,
              children: [
                TextSpan(
                  text: ' by ',
                  style: TextStyle(
                    color: context.colorScheme.secondary,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                TextSpan(text: exhibit.player.name),
              ],
            ),
            style: context.textTheme.titleSmall,
            textAlign: TextAlign.center,
          ),
        ),
        Config.vBox12,
        AppButton(
          hPadding: 15,
          text: 'Share',
          onPressed: onShare,
        ),
        Config.vBox30,
      ],
    );
  }
}
