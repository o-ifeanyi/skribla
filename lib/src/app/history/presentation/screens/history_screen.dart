import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/src/app/history/presentation/widgets/history_card.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';
import 'package:skribla/src/core/util/types.dart';
import 'package:skribla/src/core/widgets/default_app_bar.dart';
import 'package:skribla/src/core/widgets/paged_widget.dart';
import 'package:skribla/src/core/widgets/shimmer_widget.dart';

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
          context.loc.historyBtnTxt,
          style: context.textTheme.bodyLarge,
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _controller.refresh(),
        child: PagedWidget(
          pageType: PageType.grid,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 700,
            mainAxisExtent: 220,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
          ),
          padding: Config.all(15),
          pagingController: _controller,
          itemBuilder: (context, game, index) {
            return HistoryCard(game: game);
          },
          firstPageProgressIndicatorBuilder: (_) {
            return SizedBox(
              height: 220,
              child: GridView.builder(
                itemCount: 10,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 700,
                  mainAxisExtent: 220,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                padding: Config.all(15),
                itemBuilder: (context, index) {
                  return ShimmerWidget(
                    child: ColoredBox(
                      color: context.colorScheme.surface,
                    ),
                  );
                },
              ),
            );
          },
          noItemsFoundIndicatorBuilder: (_) {
            return Column(
              children: [
                SizedBox(height: Config.height * 0.3),
                Text(
                  context.loc.historyEmptyTitle,
                  style: context.textTheme.titleSmall,
                ),
                Config.vBox12,
                Text(
                  context.loc.historyEmptySubtitle,
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
