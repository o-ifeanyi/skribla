import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/service/support.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/constants.dart';
import 'package:skribla/src/core/util/extension.dart';

class SuspendedScreen extends StatelessWidget {
  const SuspendedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Config.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              AppIcons.warning,
              size: Config.height * 0.2,
              color: context.colorScheme.primary,
            ),
            Text(
              context.loc.suspendedTitle,
              textAlign: TextAlign.center,
              style: context.textTheme.titleSmall,
            ),
            Config.vBox12,
            Consumer(
              builder: (context, ref, child) {
                final user = ref.watch(authProvider.select((it) => it.user));
                return Text.rich(
                  TextSpan(
                    text: '${context.loc.suspendedSubtitle} ',
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
          ],
        ),
      ),
    );
  }
}
