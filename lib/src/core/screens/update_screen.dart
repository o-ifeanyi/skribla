import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/router/routes.dart';
import 'package:skribla/src/core/service/support.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/enums.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/widgets/app_button.dart';

class UpdateScreen extends StatelessWidget {
  const UpdateScreen({
    this.forced = false,
    super.key,
  });

  final bool forced;

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
              AppIcons.downloadSimple,
              size: Config.height * 0.2,
              color: context.colorScheme.primary,
            ),
            Text(
              context.loc.updateTitle,
              textAlign: TextAlign.center,
              style: context.textTheme.titleSmall,
            ),
            Config.vBox12,
            Text(
              context.loc.updateSubtitle,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomSheet: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Config.vBox12,
          AppButton(
            hPadding: 15,
            text: context.loc.update,
            onPressed: Support.instance.openStore,
          ),
          if (!forced) ...[
            Config.vBox12,
            AppButton(
              hPadding: 15,
              type: ButtonType.outlined,
              text: context.loc.maybeLater,
              onPressed: () => context.go(Routes.home),
            ),
          ],
          Config.vBox30,
        ],
      ),
    );
  }
}
