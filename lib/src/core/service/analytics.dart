import 'package:flutter/foundation.dart';
import 'package:lukehog/lukehog.dart';
import 'package:skribla/env/env.dart';
import 'package:skribla/src/core/service/logger.dart';

enum Event {
  appOpen('app_open'),
  playGame('play_game'),
  createGame('create_game'),
  joinGame('join_game'),
  copyLink('copy_link'),
  viewLeaderboard('view_leaderboard'),
  viewHistory('view_history'),
  viewSettings('view_settings'),
  shareArt('share_art'),
  gameEnd('game_end'),
  signUp('sign_up');

  const Event(this.value);
  final String value;
}

final class Analytics {
  Analytics._internal();
  static final _singleton = Analytics._internal();
  static const _logger = Logger('Analytics');

  static Analytics get instance => _singleton;

  late Lukehog analytics;

  void init() {
    try {
      if (kDebugMode) return;
      analytics = Lukehog(Env.lukeHogId);
      capture(Event.appOpen);
    } catch (e, s) {
      _logger.error('capture $e', stack: s);
    }
  }

  void capture(Event event, {Map<String, dynamic> properties = const {}}) {
    try {
      if (kDebugMode) {
        _logger.info('Capturing ${event.value}');
        return;
      }
      analytics.capture(event.value, properties: properties);
    } catch (e, s) {
      _logger.error('capture $e', stack: s);
    }
  }
}
