import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skribla/src/core/theme/colors.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/widgets/shimmer_widget.dart';

class TopThreeItem extends StatelessWidget {
  const TopThreeItem({
    required this.height,
    required this.width,
    required this.color,
    required this.position,
    required this.posiionStyle,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final double height;
  final double width;
  final Color color;
  final String position;
  final TextStyle? posiionStyle;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: color,
              highlightColor: Colors.white,
              child: Container(
                height: height,
                width: width,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Text(
              position,
              style: posiionStyle?.copyWith(color: flexSchemeDark.onSurface),
            ),
          ],
        ),
        Config.vBox8,
        Text(
          title,
          style: context.textTheme.bodyLarge,
        ),
        Config.vBox4,
        Text(
          subtitle,
          style: context.textTheme.bodySmall,
        ),
      ],
    );
  }
}

class TopThreeShimmer extends StatelessWidget {
  const TopThreeShimmer({
    required this.constraints,
    super.key,
  });

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return ShimmerWidget(
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: Config.fromLTRB(15, 45, 15, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _TopThreeItemShimmer(
              height: constraints.maxHeight * 0.15,
              width: constraints.maxWidth * 0.2,
            ),
            Config.hBox12,
            _TopThreeItemShimmer(
              height: constraints.maxHeight * 0.25,
              width: constraints.maxWidth * 0.4,
            ),
            Config.hBox12,
            _TopThreeItemShimmer(
              height: constraints.maxHeight * 0.12,
              width: constraints.maxWidth * 0.2,
            ),
          ],
        ),
      ),
    );
  }
}

class _TopThreeItemShimmer extends StatelessWidget {
  const _TopThreeItemShimmer({
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            shape: BoxShape.circle,
          ),
        ),
        Config.vBox12,
        ColoredBox(
          color: context.colorScheme.surface,
          child: const SizedBox(height: 12, width: 80),
        ),
        Config.vBox8,
        ColoredBox(
          color: context.colorScheme.surface,
          child: const SizedBox(height: 12, width: 80),
        ),
      ],
    );
  }
}
