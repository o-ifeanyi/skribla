import 'package:flutter/material.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';

class StartAction extends StatelessWidget {
  const StartAction({
    required this.icon,
    required this.text,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: context.theme.inputDecorationTheme.fillColor,
            child: Icon(
              icon,
              size: 24,
            ),
          ),
          Config.vBox12,
          Text(text),
        ],
      ),
    );
  }
}
