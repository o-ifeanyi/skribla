import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:skribla/src/core/service/support.dart';
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: topSpacer ?? Config.height * 0.3),
        Text(
          'Something went wrong',
          textAlign: TextAlign.center,
          style: context.textTheme.titleSmall,
        ),
        Config.vBox12,
        Text.rich(
          TextSpan(
            text: 'Try again or contact us at ',
            children: [
              TextSpan(
                text: Constants.email,
                style: const TextStyle(decoration: TextDecoration.underline),
                recognizer: TapGestureRecognizer()..onTap = Support.instance.contactSupport,
              ),
            ],
          ),
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
