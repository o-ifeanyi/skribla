import 'package:flutter/material.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    required this.title,
    required this.icon,
    this.onTap,
    this.trailing,
    super.key,
  });

  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: Config.radius8),
      tileColor: context.theme.inputDecorationTheme.fillColor,
      leading: Icon(icon),
      title: Text(title, style: context.textTheme.bodyMedium),
      onTap: onTap,
      trailing: trailing,
    );
  }
}
