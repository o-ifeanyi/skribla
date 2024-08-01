import 'package:draw_and_guess/src/app/game/presentation/widgets/art_painter.dart';
import 'package:draw_and_guess/src/app/history/data/models/exhibit_model.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:flutter/material.dart';

class ArtScroll extends StatefulWidget {
  const ArtScroll({
    required this.scrollController,
    required this.exhibits,
    required this.height,
    this.onTap,
    this.onSelectedItemChanged,
    super.key,
  });
  final FixedExtentScrollController scrollController;
  final List<ExhibitModel> exhibits;
  final double height;
  final void Function(int)? onTap;
  final void Function(int)? onSelectedItemChanged;

  @override
  State<ArtScroll> createState() => _ArtScrollState();
}

class _ArtScrollState extends State<ArtScroll> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          ListWheelScrollView(
            controller: widget.scrollController,
            offAxisFraction: 0.5,
            clipBehavior: Clip.none,
            squeeze: 0.9,
            itemExtent: widget.height,
            onSelectedItemChanged: (value) {
              setState(() {
                _selectedIndex = value;
              });
              _animationController
                ..reset()
                ..forward();
              widget.onSelectedItemChanged?.call(_selectedIndex);
            },
            children: List.generate(
              widget.exhibits.length,
              (index) {
                final exhibit = widget.exhibits[index];
                return GestureDetector(
                  onTap: () => widget.onTap?.call(index),
                  child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                          color: context.theme.inputDecorationTheme.fillColor,
                          borderRadius: Config.radius8,
                        ),
                        child: CustomPaint(
                          size: Size.square(widget.height),
                          painter: AnimatedArtPainter(
                            art: exhibit.art,
                            progress: (_animationController.isAnimating && _selectedIndex == index)
                                ? _animation.value
                                : 1,
                          ),
                        ).rotate(1),
                      );
                    },
                  ),
                );
              },
            ),
          ).rotate(-1),
        ],
      ),
    );
  }
}
