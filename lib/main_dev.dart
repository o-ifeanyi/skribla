import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skribla/firebase_options_dev.dart';
import 'package:skribla/src/app/main_app.dart';
import 'package:skribla/src/core/observers/provider_watch.dart';
import 'package:skribla/src/core/service/logger.dart';

void main() {
  const logger = Logger('Main Dev');
  runZonedGuarded(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
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
