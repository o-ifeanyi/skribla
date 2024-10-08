import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/core/di/di.dart';
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
      children: [
        SizedBox(height: topSpacer ?? Config.height * 0.3),
        Text(
          context.loc.errorTitle,
          textAlign: TextAlign.center,
          style: context.textTheme.titleSmall,
        ),
        Config.vBox12,
        Consumer(
          builder: (context, ref, child) {
            final user = ref.watch(authProvider.select((it) => it.user));

            return Text.rich(
              TextSpan(
                text: '${context.loc.errorSubtitle} ',
                children: [
                  TextSpan(
                    text: Constants.email,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: context.colorScheme.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => Support.instance.contactSupport(user),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            );
          },
        ),
        if (retry != null) ...[
          Config.vBox12,
          AppButton(
            text: context.loc.retry,
            onPressed: retry,
          ),
        ],
      ],
    );
  }
}
