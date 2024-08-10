import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
    this.title,
    this.titleStyle,
    this.leading,
    this.actions = const [],
    this.automaticallyImplyLeading = true,
  });

  final Widget? title;
  final TextStyle? titleStyle;
  final Widget? leading;
  final List<Widget> actions;
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: context.theme.scaffoldBackgroundColor,
      scrolledUnderElevation: 0,
      elevation: 0,
      centerTitle: true,
      leading: kIsWeb || !automaticallyImplyLeading
          ? const SizedBox.shrink()
          : Padding(
              padding: Config.fromLTRB(15, 0, 0, 0),
              child: GestureDetector(
                onTap: context.pop,
                child: CircleAvatar(
                  backgroundColor: context.theme.inputDecorationTheme.fillColor,
                  child: Icon(AppIcons.x, size: 18),
                ),
              ),
            ),
      title: title,
      actions: [
        ...actions,
        if (actions.isNotEmpty) Config.hBox16,
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
