import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:skribla/src/app/game/presentation/screens/game_screen.dart';
import 'package:skribla/src/app/history/presentation/screens/history_screen.dart';
import 'package:skribla/src/app/home/presentation/screens/home_screen.dart';
import 'package:skribla/src/app/home/presentation/screens/join_screen.dart';
import 'package:skribla/src/app/leaderboard/presentation/screens/leaderboard_screen.dart';
import 'package:skribla/src/app/settings/presentation/screens/settings_screen.dart';
import 'package:skribla/src/core/router/routes.dart';
import 'package:skribla/src/core/screens/unavailable_screen.dart';
import 'package:skribla/src/core/screens/update_screen.dart';
import 'package:skribla/src/core/util/extension.dart';

final class Router {
  Router._internal();
  static final _singleton = Router._internal();
  static Router get instance => _singleton;

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static Page<dynamic> _pushScreen(Widget screen) {
    if (kIsWeb || Platform.isAndroid) {
      return MaterialPage<void>(child: screen);
    }
    return CupertinoPage(child: screen);
  }

  static GoRoute _route({
    required String path,
    required Widget? screen,
    Widget Function(BuildContext, GoRouterState)? builder,
    List<RouteBase> routes = const <RouteBase>[],
  }) {
    assert(screen != null || builder != null, 'Both screen and builder cannot be null');

    return GoRoute(
      path: path,
      name: path.routeName,
      builder: builder,
      pageBuilder: screen != null ? (_, __) => _pushScreen(screen) : null,
      routes: routes,
    );
  }

  final goRouter = GoRouter(
    initialLocation: Routes.home,
    navigatorKey: _rootNavigatorKey,
    observers: [SentryNavigatorObserver()],
    routes: [
      _route(
        path: Routes.home,
        screen: const HomeScreen(),
        routes: [
          _route(
            path: Routes.join,
            screen: null,
            builder: (_, state) {
              final id = state.pathParameters['id'] ?? '';
              return JoinScreen(id: id);
            },
          ),
          _route(
            path: Routes.game,
            screen: null,
            builder: (_, state) {
              final id = state.pathParameters['id'] ?? '';
              return GameScreen(id: id);
            },
          ),
          _route(
            path: Routes.history,
            screen: const HistoryScreen(),
          ),
          _route(
            path: Routes.leaderboard,
            screen: const LeaderboardScreen(),
          ),
          _route(
            path: Routes.settings,
            screen: const SettingsScreen(),
          ),
        ],
      ),
      _route(
        path: Routes.unavailable,
        screen: const UnavailableScreen(),
      ),
      _route(
        path: Routes.update,
        screen: null,
        builder: (_, state) {
          final forced = state.extra as bool? ?? false;
          return UpdateScreen(forced: forced);
        },
      ),
    ],
  );
}

class TransparentRoute<T> extends PageRoute<T> {
  TransparentRoute({required this.builder}) : super(fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => Colors.transparent;

  @override
  String get barrierLabel => '';

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 350);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: builder(context),
    );
  }
}
