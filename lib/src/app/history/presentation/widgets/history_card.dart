import 'package:draw_and_guess/src/app/game/data/models/game_model.dart';
import 'package:draw_and_guess/src/app/history/data/models/exhibit_model.dart';
import 'package:draw_and_guess/src/app/history/presentation/screens/exhibits_screen.dart';
import 'package:draw_and_guess/src/app/history/presentation/widgets/art_scroll.dart';
import 'package:draw_and_guess/src/core/di/di.dart';
import 'package:draw_and_guess/src/core/router/router.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:draw_and_guess/src/core/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryCard extends StatefulWidget {
  const HistoryCard({
    required this.game,
    super.key,
  });
  final GameModel game;

  @override
  State<HistoryCard> createState() => _HistoryCardState();
}

class _HistoryCardState extends State<HistoryCard> {
  late final FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(
      onAttach: (position) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future<void>.delayed(Config.duration300).then((_) {
            try {
              _scrollController.animateTo(
                position.maxScrollExtent / 2,
                duration: const Duration(seconds: 1),
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

  final getExhibits = FutureProvider.family<List<ExhibitModel>, String>(
    (ref, id) async {
      return ref.read(historyProvider.notifier).getExhibits(id);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Config.radius16,
      ),
      child: Column(
        children: [
          Padding(
            padding: Config.symmetric(h: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${widget.game.players.length} players joined'),
                Text(
                  widget.game.createdAt.formatEDMHM,
                  style: context.textTheme.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Consumer(
            builder: (context, ref, child) {
              final exhibitsRef = ref.watch(getExhibits(widget.game.id));
              return exhibitsRef.when(
                data: (data) {
                  return Hero(
                    tag: widget.game.id,
                    child: ArtScroll(
                      scrollController: _scrollController,
                      exhibits: data,
                      height: 150,
                      onTap: (index) {
                        Navigator.of(context).push(
                          TransparentRoute<void>(
                            builder: (context) => ExhibitsScreen(
                              id: widget.game.id,
                              exhibits: data,
                              index: index,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                error: (error, _) {
                  return Text(error.toString());
                },
                loading: () {
                  return SizedBox(
                    height: 150,
                    child: ListWheelScrollView(
                      controller: FixedExtentScrollController(
                        initialItem: widget.game.numOfArts ~/ 2,
                      ),
                      offAxisFraction: 0.5,
                      squeeze: 0.9,
                      itemExtent: 150,
                      children: List.generate(
                        widget.game.numOfArts,
                        (_) => const ShimmerWidget(
                          height: 150,
                          width: 150,
                        ),
                      ),
                    ).rotate(-1),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
