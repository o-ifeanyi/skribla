import 'dart:io';

import 'package:draw_and_guess/src/app/game/presentation/screens/game_screen.dart';
import 'package:draw_and_guess/src/app/start/presentation/screens/start_screen.dart';
import 'package:draw_and_guess/src/core/router/routes.dart';
import 'package:draw_and_guess/src/core/util/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>(
  (ref) {
    final rootNavigatorKey = GlobalKey<NavigatorState>();

    Page<dynamic> pushScreen(Widget screen) {
      if (kIsWeb || Platform.isAndroid) {
        return MaterialPage<void>(child: screen);
      }
      return CupertinoPage(child: screen);
    }

    GoRoute route({
      required String path,
      required Widget? screen,
      Page<dynamic> Function(BuildContext, GoRouterState)? pageBuilder,
      Widget Function(BuildContext, GoRouterState)? builder,
      List<RouteBase> routes = const <RouteBase>[],
    }) {
      return GoRoute(
        path: path,
        name: path.routeName,
        builder: builder,
        pageBuilder:
            screen != null ? (_, __) => pushScreen(screen) : pageBuilder,
        routes: routes,
      );
    }

    return GoRouter(
      initialLocation: Routes.start,
      navigatorKey: rootNavigatorKey,
      routes: [
        route(
          path: Routes.start,
          screen: const StartScreen(),
          routes: [
            route(
              path: Routes.game,
              screen: null,
              builder: (_, state) {
                final id = state.pathParameters['id'] ?? '';
                return GameScreen(id: id);
              },
            ),
          ],
        ),
      ],
    );
  },
);
