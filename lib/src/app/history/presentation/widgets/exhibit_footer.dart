import 'package:flutter/material.dart';
import 'package:skribla/src/app/history/data/models/exhibit_model.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/widgets/app_button.dart';

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
        Config.vBox8,
        Padding(
          padding: Config.symmetric(h: 15),
          child: Text.rich(
            TextSpan(
              text: exhibit.word.locText,
              children: [
                TextSpan(
                  text: ' ${context.loc.by} ',
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
          text: context.loc.shareBtnTxt,
          onPressed: onShare,
        ),
        Config.vBox30,
      ],
    );
  }
}
