import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:skribla/env/env.dart';
import 'package:skribla/firebase_options_prod.dart';
import 'package:skribla/src/app/main_app.dart';
import 'package:skribla/src/core/observers/provider_watch.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  SentryFlutter.init(
    (options) {
      options
        ..dsn = Env.sentryDNS
        ..environment = 'prod'
        ..tracesSampleRate = 1.0
        ..profilesSampleRate = 1.0;
    },
    appRunner: () async {
      WidgetsFlutterBinding.ensureInitialized();
      setPathUrlStrategy();
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      runApp(
        ProviderScope(
          observers: [ProviderWatch()],
          child: const MainApp(),
        ),
      );
    },
  );
}
