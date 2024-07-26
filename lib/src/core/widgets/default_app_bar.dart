import 'package:draw_and_guess/src/core/resource/app_icons.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
    return SafeArea(
      child: Container(
        constraints:
            BoxConstraints.tight(const Size.fromHeight(kToolbarHeight)),
        padding: Config.symmetric(h: 15),
        child: Row(
          children: [
            if (automaticallyImplyLeading) ...[
              GestureDetector(
                onTap: context.pop,
                child: CircleAvatar(
                  backgroundColor: context.theme.inputDecorationTheme.fillColor,
                  child: Icon(AppIcons.x, size: 18),
                ),
              ),
            ] else if (leading != null) ...[
              Padding(
                padding: Config.symmetric(h: 15),
                child: leading,
              ),
            ],
            if (title != null) ...[
              Padding(
                padding: Config.symmetric(h: 25),
                child: title,
              ),
            ],
            if (actions.isNotEmpty) ...[
              const Spacer(),
              ...actions,
            ],
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
