import 'package:flutter/material.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/constants.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/widgets/app_button.dart';

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    this.topSpacer,
    this.retry,
    super.key,
  });

  final double? topSpacer;
  final VoidCallback? retry;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: topSpacer ?? Config.height * 0.3),
        Text(
          'Something went wrong',
          style: context.textTheme.titleSmall,
        ),
        Config.vBox12,
        const Text(
          'Try again or contact us at ${Constants.email}',
          textAlign: TextAlign.center,
        ),
        if (retry != null) ...[
          Config.vBox12,
          AppButton(
            text: 'Retry',
            onPressed: retry,
          ),
        ],
      ],
    );
  }
}
