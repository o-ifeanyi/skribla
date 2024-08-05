import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skribla/src/app/history/data/models/exhibit_model.dart';
import 'package:skribla/src/app/history/presentation/widgets/art_scroll.dart';
import 'package:skribla/src/app/history/presentation/widgets/exhibit_footer.dart';
import 'package:skribla/src/app/history/presentation/widgets/light_painter.dart';
import 'package:skribla/src/app/history/presentation/widgets/shared_widget.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';

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
  late final _screenshotKey = GlobalKey();
  late final AnimationController _animationController;
  late final Animation<double> _animation;
  late final FixedExtentScrollController _scrollController;

  int _currentIndex = 0;

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
              _scrollController
                  .animateToItem(
                widget.index,
                duration: Config.duration1000,
                curve: Curves.bounceOut,
              )
                  .whenComplete(() {
                _animationController.forward();
              });
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: widget.id,
                  child: ArtScroll(
                    scrollController: _scrollController,
                    exhibits: widget.exhibits,
                    height: 220,
                    onTap: (val) {
                      _scrollController.animateToItem(
                        val,
                        duration: Config.duration1000,
                        curve: Curves.bounceOut,
                      );
                    },
                    onSelectedItemChanged: (val) {
                      setState(() {
                        _currentIndex = val;
                      });
                    },
                  ),
                ),
              ],
            ),
            Align(
              child: SharedWidget(
                screenshotKey: _screenshotKey,
                exhibit: widget.exhibits[_currentIndex],
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
        bottomSheet: ExhibitFooter(
          exhibit: widget.exhibits[_currentIndex],
          onShare: () => ref.read(historyProvider.notifier).shareImage(_screenshotKey),
        ),
      ).watchBuild('ExhibitsScreen'),
    );
  }
}
