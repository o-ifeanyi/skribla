import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({
    required this.duration,
    super.key,
    this.height,
  });

  final Duration duration;
  final double? height;

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  bool _animate = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        _animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: ClipRRect(
            borderRadius: Config.radius8,
            child: Stack(
              children: [
                Container(
                  height: Config.h(widget.height ?? 8),
                  color: context.colorScheme.primaryContainer,
                ),
                AnimatedContainer(
                  height: Config.h(widget.height ?? 8),
                  duration: widget.duration,
                  width: _animate ? 0 : constraints.maxWidth,
                  child: ColoredBox(
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ).watchBuild('ProgressBar');
  }
}
