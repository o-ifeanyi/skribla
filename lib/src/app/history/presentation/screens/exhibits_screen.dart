import 'package:draw_and_guess/src/app/history/data/models/exhibit_model.dart';
import 'package:draw_and_guess/src/app/history/presentation/widgets/art_scroll.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExhibitsScreen extends ConsumerStatefulWidget {
  const ExhibitsScreen({
    required this.id,
    required this.exhibits,
    this.index = 0,
    super.key,
  });
  final int index;
  final String id;
  final List<ExhibitModel> exhibits;

  @override
  ConsumerState<ExhibitsScreen> createState() => _ExhibitsScreenState();
}

class _ExhibitsScreenState extends ConsumerState<ExhibitsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  late final FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Config.duration1000,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.bounceInOut),
    );
    _scrollController = FixedExtentScrollController(
      onAttach: (position) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future<void>.delayed(Config.duration300).then((_) {
            try {
              _scrollController.animateToItem(
                widget.index,
                duration: Config.duration1000,
                curve: Curves.bounceOut,
              );
            } catch (_) {}
          });
        });
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: context.pop,
      child: Scaffold(
        backgroundColor: Colors.black45,
        body: Stack(
          children: [
            Center(
              child: Hero(
                tag: widget.id,
                child: ArtScroll(
                  scrollController: _scrollController,
                  exhibits: widget.exhibits,
                  height: 200,
                  onSelectedItemChanged: (_) {
                    _animationController
                      ..reset()
                      ..forward();
                  },
                ),
              ),
            ),
            IgnorePointer(
              child: AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Opacity(
                    opacity: _animation.value,
                    child: CustomPaint(
                      size: Size(Config.width, Config.height / 1.8),
                      painter: LightPainter(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ).watchBuild('ExhibitsScreen'),
    );
  }
}

class LightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.1, 0.6, 1.0],
        colors: [Colors.white38, Colors.white12, Colors.transparent],
      ).createShader(
        Rect.fromPoints(
          Offset(size.width / 2, 0),
          Offset(size.width / 2, size.height),
        ),
      );

    final path = Path()
      ..moveTo(size.width / 2 - Config.w(10), 20)
      ..lineTo(Config.w(20), size.height)
      ..lineTo(size.width - Config.w(20), size.height)
      ..lineTo(size.width / 2 + Config.w(10), 20)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
