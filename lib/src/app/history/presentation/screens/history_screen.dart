import 'package:draw_and_guess/src/app/history/presentation/widgets/history_card.dart';
import 'package:draw_and_guess/src/core/di/di.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:draw_and_guess/src/core/util/types.dart';
import 'package:draw_and_guess/src/core/widgets/default_app_bar.dart';
import 'package:draw_and_guess/src/core/widgets/paged_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final _controller = HistoryController(firstPageKey: null);
  @override
  void initState() {
    super.initState();
    final history = ref.read(historyProvider.notifier);
    _controller.addPageRequestListener(
      (lastItem) => history.getHistory(controller: _controller, lastItem: lastItem),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Text(
          'Play history',
          style: context.textTheme.bodyLarge,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _controller.refresh(),
        child: PagedWidget(
          pageType: PageType.grid,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: Config.w(450),
            childAspectRatio: 3 / 1.6,
            mainAxisSpacing: Config.h(12),
            crossAxisSpacing: Config.h(12),
          ),
          padding: Config.all(15),
          pagingController: _controller,
          itemBuilder: (context, game, index) {
            return HistoryCard(game: game);
          },
          noItemsFoundIndicatorBuilder: (_) {
            return Column(
              children: [
                SizedBox(height: Config.height * 0.3),
                Text(
                  'Nothing to see here',
                  style: context.textTheme.titleSmall,
                ),
                Config.vBox12,
                const Text(
                  'Games you played will show up here',
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    ).watchBuild('HistoryScreen');
  }
}
