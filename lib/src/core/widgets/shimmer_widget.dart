import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.child,
  });
  final double? height;
  final double? width;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? Config.radius8,
      child: Shimmer.fromColors(
        highlightColor: context.colorScheme.surface,
        baseColor:
            context.theme.inputDecorationTheme.fillColor ?? context.colorScheme.surfaceContainer,
        child: child ??
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
              ),
            ),
      ),
    );
  }
}
