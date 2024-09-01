import 'package:flutter/material.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/enums.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    this.textStyle,
    this.icon,
    this.onPressed,
    this.style,
    this.child,
    this.hPadding = 0,
    this.cPadding = 15,
    this.type = ButtonType.filled,
    super.key,
  }) : assert(text != null || child != null, 'text or child is needed');

  final void Function()? onPressed;
  final String? text;
  final TextStyle? textStyle;
  final double hPadding;
  final double cPadding;
  final Widget? icon;
  final Widget? child;
  final ButtonStyle? style;
  final ButtonType type;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: EdgeInsets.all(cPadding),
      child: child ??
          Text(
            text!,
            style: textStyle ?? Config.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
    );

    return Padding(
      padding: Config.symmetric(h: hPadding),
      child: switch (type) {
        ButtonType.filled => FilledButton.icon(
            onPressed: onPressed,
            label: content,
            icon: icon ?? const SizedBox.shrink(),
            style: style ??
                FilledButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: Config.radius8,
                  ),
                ),
          ),
        ButtonType.outlined => OutlinedButton.icon(
            onPressed: onPressed,
            label: content,
            icon: icon ?? const SizedBox.shrink(),
            style: style ??
                OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: Config.radius8,
                  ),
                ),
          ),
        ButtonType.elevated => ElevatedButton.icon(
            onPressed: onPressed,
            label: content,
            icon: icon ?? const SizedBox.shrink(),
            style: style ??
                ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: Config.radius8,
                  ),
                ),
          ),
        ButtonType.text => TextButton.icon(
            onPressed: onPressed,
            label: content,
            icon: icon ?? const SizedBox.shrink(),
            style: style ??
                TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: Config.radius8,
                  ),
                ),
          ),
      },
    );
  }
}
