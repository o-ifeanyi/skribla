import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:skribla/src/app/leaderboard/presentation/widgets/top_three_item.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/extension.dart';

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
        padding: Config.fromLTRB(20, 0, 0, 0),
        child: GestureDetector(
          onTap: context.pop,
          child: CircleAvatar(
            backgroundColor: context.theme.inputDecorationTheme.fillColor,
            child: Icon(AppIcons.x, size: 18),
          ),
        ),
      ),
      title: Text(
        context.loc.leaderboardBtnTxt,
        style: context.textTheme.titleSmall,
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
                    padding: Config.fromLTRB(15, kIsWeb ? 15 : 45, 15, 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (topThree.length > 1) ...[
                          Expanded(
                            child: TopThreeItem(
                              height: constraints.maxHeight * 0.15,
                              width: constraints.maxWidth * 0.2,
                              color: Colors.grey,
                              position: '2',
                              posiionStyle: context.textTheme.titleMedium,
                              title: topThree[1].name,
                              subtitle: context.loc.npts(topThree[1].points),
                            ),
                          ),
                        ],
                        if (topThree.isNotEmpty) ...[
                          Config.hBox12,
                          Expanded(
                            child: TopThreeItem(
                              height: constraints.maxHeight * 0.25,
                              width: constraints.maxWidth * 0.4,
                              color: Colors.orange,
                              position: '1',
                              posiionStyle: context.textTheme.titleLarge,
                              title: topThree[0].name,
                              subtitle: context.loc.npts(topThree[0].points),
                            ),
                          ),
                        ],
                        if (topThree.length > 2) ...[
                          Config.hBox12,
                          Expanded(
                            child: TopThreeItem(
                              height: constraints.maxHeight * 0.12,
                              width: constraints.maxWidth * 0.2,
                              color: Colors.brown,
                              position: '3',
                              posiionStyle: context.textTheme.titleSmall,
                              title: topThree[2].name,
                              subtitle: context.loc.npts(topThree[2].points),
                            ),
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
  Size get preferredSize => Size(0, Config.h(65)); // 45 (tab) + 20 (v padding 10 + 10)
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
      margin: Config.symmetric(h: 30, v: 10),
      decoration: BoxDecoration(
        color: context.theme.inputDecorationTheme.fillColor,
        borderRadius: Config.radius24,
      ),
      child: Consumer(
        builder: (context, ref, child) {
          return TabBar(
            controller: _controller,
            indicatorWeight: 0,
            splashBorderRadius: Config.radius24,
            tabs: [
              Tab(text: context.loc.monthly, height: Config.h(45)),
              Tab(text: context.loc.allTime, height: Config.h(45)),
            ],
            dividerColor: Colors.transparent,
            labelStyle: context.textTheme.bodyLarge,
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
