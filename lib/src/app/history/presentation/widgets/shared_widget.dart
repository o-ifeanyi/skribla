import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/game/presentation/widgets/art_painter.dart';
import 'package:skribla/src/app/history/data/models/exhibit_model.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';

class SharedWidget extends ConsumerWidget {
  const SharedWidget({
    required this.screenshotKey,
    required this.exhibit,
    super.key,
  });

  final GlobalKey screenshotKey;
  final ExhibitModel exhibit;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sharing = ref.watch(historyProvider.select((it) => it.sharing));

    return AnimatedCrossFade(
      crossFadeState: sharing ? CrossFadeState.showSecond : CrossFadeState.showFirst,
      duration: Config.duration300,
      firstChild: const SizedBox.shrink(),
      secondChild: RepaintBoundary(
        key: screenshotKey,
        child: Material(
          color: context.colorScheme.surface,
          borderRadius: Config.radius8,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: context.theme.inputDecorationTheme.fillColor,
                    borderRadius: Config.radius8,
                  ),
                  child: CustomPaint(
                    size: const Size.square(250),
                    painter: AnimatedArtPainter(
                      art: exhibit.art,
                      progress: 1,
                    ),
                  ),
                ),
                Config.vBox12,
                Text.rich(
                  TextSpan(
                    text: exhibit.word.text,
                    children: [
                      TextSpan(
                        text: ' ${context.loc.by} ',
                        style: TextStyle(
                          color: context.colorScheme.secondary,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      TextSpan(text: exhibit.player.name),
                    ],
                  ),
                  style: context.textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
