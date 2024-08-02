import 'package:draw_and_guess/src/app/leaderboard/presentation/widgets/leaderboard_app_bar.dart';
import 'package:draw_and_guess/src/app/leaderboard/presentation/widgets/leaderboard_footer.dart';
import 'package:draw_and_guess/src/app/leaderboard/presentation/widgets/leaderboard_item.dart';
import 'package:draw_and_guess/src/core/di/di.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:draw_and_guess/src/core/util/types.dart';
import 'package:draw_and_guess/src/core/widgets/paged_widget.dart';
import 'package:draw_and_guess/src/core/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LeaderboardScreen extends ConsumerStatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  ConsumerState<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends ConsumerState<LeaderboardScreen> {
  final _controller = LeaderboardController(firstPageKey: null);
  @override
  void initState() {
    super.initState();
    final leaderboard = ref.read(leaderboardProvider.notifier);
    _controller.addPageRequestListener(
      (lastItem) => leaderboard.getLeaderboard(
        controller: _controller,
        lastItem: lastItem,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      leaderboardProvider.select((it) => it.type),
      (_, __) => _controller.refresh(),
    );
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxScrolled) {
          return [const LeaderboardAppBar()];
        },
        body: RefreshIndicator(
          onRefresh: () async => _controller.refresh(),
          child: PagedWidget(
            pageType: PageType.list,
            padding: Config.symmetric(h: 15),
            pagingController: _controller,
            itemBuilder: (context, leaderboard, index) {
              return LeaderboardItem(
                data: (model: leaderboard, position: index + 4),
                name: leaderboard.name,
              );
            },
            topSpacer: Config.height * 0.15,
            firstPageProgressIndicatorBuilder: (_) {
              return Column(
                children: List.generate(
                  10,
                  (_) => ShimmerWidget(
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(),
                      title: ColoredBox(
                        color: context.colorScheme.surface,
                        child: const Text(''),
                      ),
                      subtitle: ColoredBox(
                        color: context.colorScheme.surface,
                        child: Text('', style: context.textTheme.bodySmall),
                      ),
                    ),
                  ),
                ),
              );
            },
            noItemsFoundIndicatorBuilder: (_) {
              return Column(
                children: [
                  SizedBox(height: Config.height * 0.15),
                  Text(
                    'Nothing to see here',
                    style: context.textTheme.titleSmall,
                  ),
                  Config.vBox12,
                  const Text(
                    'Players in the leaderboard will show up here',
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            },
          ),
        ),
      ),
      bottomSheet: const LeaderboardFooter(),
    );
  }
}
