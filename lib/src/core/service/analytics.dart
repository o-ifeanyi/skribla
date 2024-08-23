import 'package:flutter/foundation.dart';
import 'package:lukehog/lukehog.dart';
import 'package:skribla/env/env.dart';
import 'package:skribla/src/core/service/logger.dart';

/// Enum for defining analytics events.
///
/// This enum is used to specify the type of event to be tracked in the analytics service.
/// Each event has a corresponding value that is used to identify the event in the analytics service.
///
/// Usage:
/// This enum is used in conjunction with the Analytics service to track specific events in the application.
/// For example, when the app is opened, the `appOpen` event is captured using the Analytics service.
/// Similarly, when a game is played, the `playGame` event is captured.
///

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

/// A singleton class for managing analytics in the application.
///
/// This class is responsible for capturing and sending analytics events to a third-party service.
/// It uses the Lukehog library for analytics tracking and provides methods for initializing the analytics service,
/// capturing events, and sending properties along with the events.
///
/// Key features:
/// - Initializes the analytics service with a Lukehog ID
/// - Captures analytics events with optional properties
/// - Provides a singleton instance for accessing analytics functionality throughout the app
///
/// Usage:
/// This class is typically used to capture analytics events throughout the application.
/// For example, when the app is opened, the `init` method is called to initialize the analytics service,
/// and then the `capture` method is used to capture the `appOpen` event. Similarly, other events can be captured
/// using the `capture` method with the corresponding event type and optional properties.
///

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

  /// Captures an analytics event with optional properties.
  ///
  /// This method is used to capture an analytics event with optional properties.
  /// If the app is in debug mode, the event is logged to the console instead of being sent to the analytics service.
  /// The event is captured using the Lukehog library, and the event type and optional properties are passed as parameters.
  ///
  /// Parameters:
  /// - `event`: The type of the event to be captured.
  /// - `properties`: Optional properties to be sent along with the event.
  ///
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
