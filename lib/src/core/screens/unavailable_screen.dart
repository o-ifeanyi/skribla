import 'package:flutter/material.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';

class UnavailableScreen extends StatelessWidget {
  const UnavailableScreen({super.key});

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
              AppIcons.cloudSlash,
              size: Config.height * 0.2,
              color: context.colorScheme.primary,
            ),
            Text(
              context.loc.unavailableTitle,
              textAlign: TextAlign.center,
              style: context.textTheme.titleSmall,
            ),
            Config.vBox12,
            Text(
              context.loc.unavailableSubtitle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
