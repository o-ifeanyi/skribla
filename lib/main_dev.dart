import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/firebase_options_dev.dart';
import 'package:skribla/src/app/main_app.dart';
import 'package:skribla/src/core/observers/provider_watch.dart';
import 'package:skribla/src/core/service/logger.dart';
import 'package:url_strategy/url_strategy.dart';

void main() {
  const logger = Logger('Main Dev');
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      // FlutterNativeSplash.preserve(widgetsBinding: binding);
      setPathUrlStrategy();
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      // debugRepaintRainbowEnabled = true;

      runApp(
        ProviderScope(
          observers: [ProviderWatch()],
          child: const MainApp(),
        ),
      );
    },
    (error, stack) {
      logger.error(error.toString(), stack: stack);
    },
  );
}
