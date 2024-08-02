import 'package:draw_and_guess/src/app/leaderboard/presentation/widgets/top_three_item.dart';
import 'package:draw_and_guess/src/core/di/di.dart';
import 'package:draw_and_guess/src/core/resource/app_icons.dart';
import 'package:draw_and_guess/src/core/util/config.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LeaderboardAppBar extends ConsumerStatefulWidget {
  const LeaderboardAppBar({super.key});

  @override
  ConsumerState<LeaderboardAppBar> createState() => _LeaderboardAppBarState();
}

class _LeaderboardAppBarState extends ConsumerState<LeaderboardAppBar> {
  @override
  Widget build(BuildContext context) {
    final topThree = ref.watch(leaderboardProvider.select((it) => it.topThree));
    return SliverAppBar(
      pinned: true,
      floating: true,
      centerTitle: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: Padding(
        padding: Config.fromLTRB(15, 0, 0, 0),
        child: GestureDetector(
          onTap: context.pop,
          child: CircleAvatar(
            backgroundColor: context.theme.inputDecorationTheme.fillColor,
            child: Icon(AppIcons.x, size: 18),
          ),
        ),
      ),
      title: Text(
        'Leaderboard',
        style: context.textTheme.bodyLarge,
      ),
      bottom: const _SliverBottomWidget(),
      expandedHeight: Config.height * 0.4,
      flexibleSpace: FlexibleSpaceBar(
        background: LayoutBuilder(
          builder: (context, constraints) {
            return topThree.isEmpty
                ? TopThreeShimmer(constraints: constraints)
                : Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: Config.fromLTRB(15, 45, 15, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (topThree.length > 1) ...[
                          TopThreeItem(
                            height: constraints.maxHeight * 0.15,
                            width: constraints.maxWidth * 0.2,
                            color: Colors.grey,
                            position: '2',
                            posiionStyle: context.textTheme.titleMedium,
                            title: topThree[1].name,
                            subtitle: '${topThree[1].points} pts',
                          ),
                        ],
                        if (topThree.isNotEmpty) ...[
                          Config.hBox12,
                          TopThreeItem(
                            height: constraints.maxHeight * 0.25,
                            width: constraints.maxWidth * 0.4,
                            color: Colors.orange,
                            position: '1',
                            posiionStyle: context.textTheme.titleLarge,
                            title: topThree[0].name,
                            subtitle: '${topThree[0].points} pts',
                          ),
                        ],
                        if (topThree.length > 2) ...[
                          Config.hBox12,
                          TopThreeItem(
                            height: constraints.maxHeight * 0.12,
                            width: constraints.maxWidth * 0.2,
                            color: Colors.brown,
                            position: '3',
                            posiionStyle: context.textTheme.titleSmall,
                            title: topThree[2].name,
                            subtitle: '${topThree[2].points} pts',
                          ),
                        ],
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}

class _SliverBottomWidget extends StatefulWidget implements PreferredSizeWidget {
  const _SliverBottomWidget();

  @override
  State<_SliverBottomWidget> createState() => _SliverBottomWidgetState();

  @override
  Size get preferredSize => const Size(0, kToolbarHeight + 22);
}

class _SliverBottomWidgetState extends State<_SliverBottomWidget>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(
        color: context.theme.inputDecorationTheme.fillColor,
        borderRadius: Config.radius24,
      ),
      child: Consumer(
        builder: (context, ref, child) {
          return TabBar(
            controller: _controller,
            splashBorderRadius: Config.radius24,
            tabs: const [
              Tab(text: 'Monthly'),
              Tab(text: 'All time'),
            ],
            dividerColor: Colors.transparent,
            labelStyle: context.textTheme.bodyMedium,
            unselectedLabelStyle: context.textTheme.bodyMedium,
            indicatorColor: context.colorScheme.primary,
            labelColor: context.colorScheme.onPrimary,
            unselectedLabelColor: context.colorScheme.onSurface,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              borderRadius: Config.radius24,
              color: context.colorScheme.primary,
            ),
            onTap: ref.read(leaderboardProvider.notifier).switchType,
          );
        },
      ),
    );
  }
}
