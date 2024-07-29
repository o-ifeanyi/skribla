import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:flutter/material.dart';

enum ButtonType { filled, outlined, elevated, text }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    super.key,
    this.icon,
    this.onPressed,
    this.style,
    this.child,
    this.hPadding = 0,
    this.cPadding = 15,
    this.type = ButtonType.filled,
  }) : assert(text != null || child != null, 'text or child is needed');

  final void Function()? onPressed;
  final String? text;
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
            style: Config.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
    );

    return Padding(
      padding: Config.symmetric(h: hPadding),
      child: switch (type) {
        ButtonType.filled => FilledButton.icon(
            onPressed: onPressed,
            label: content,
            icon: icon ?? const SizedBox.shrink(),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: Config.radius8,
              ),
            ),
          ),
        ButtonType.outlined => OutlinedButton.icon(
            onPressed: onPressed,
            label: content,
            icon: icon ?? const SizedBox.shrink(),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: Config.radius8,
              ),
            ),
          ),
        ButtonType.elevated => ElevatedButton.icon(
            onPressed: onPressed,
            label: content,
            icon: icon ?? const SizedBox.shrink(),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: Config.radius8,
              ),
            ),
          ),
        ButtonType.text => TextButton.icon(
            onPressed: onPressed,
            label: content,
            icon: icon ?? const SizedBox.shrink(),
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: Config.radius8,
              ),
            ),
          ),
      },
    );
  }
}
