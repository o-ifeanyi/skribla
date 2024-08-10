import 'package:flutter/material.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/widgets/gradient_text.dart';

class LogoText extends StatelessWidget {
  const LogoText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        GradientText(
          'Skribla',
          style: context.textTheme.displayLarge,
          gradient: LinearGradient(
            stops: const [0.2, 0.5, 0.8],
            colors: [
              context.colorScheme.primaryContainer,
              context.colorScheme.primary,
              context.colorScheme.primaryContainer,
            ],
          ),
        ),
        Text(
          'draw, guess, and have fun',
          textAlign: TextAlign.center,
          style: context.textTheme.bodyLarge,
        ),
      ],
    );
  }
}
