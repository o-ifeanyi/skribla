import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/material.dart' hide Router;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/router/router.dart';
import 'package:skribla/src/core/service/analytics.dart';
import 'package:skribla/src/core/service/haptics.dart';
import 'package:skribla/src/core/service/toast.dart';
import 'package:skribla/src/core/theme/app_theme.dart';
import 'package:skribla/src/core/util/extension.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    Analytics.instance.init();
    Haptics.instance.init();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      fontSizeResolver: (fontSize, instance) => fontSize.toDouble(),
      child: Consumer(
        builder: (context, ref, child) {
          final routerConfig = Router.instance.goRouter;
          final themeMode = ref.watch(settingsProvider.select((it) => it.theme));

          return MaterialApp.router(
            title: 'Skribla',
            scrollBehavior: const MaterialScrollBehavior().copyWith(
              dragDevices: {
                PointerDeviceKind.mouse,
                PointerDeviceKind.touch,
                PointerDeviceKind.stylus,
                PointerDeviceKind.trackpad,
                PointerDeviceKind.unknown,
              },
            ),
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            theme: AppTheme.lightTheme,
            routerConfig: routerConfig,
            locale: const Locale('en'),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            builder: (BuildContext context, Widget? child) {
              final scale = context.mediaQuery.textScaler.clamp(
                minScaleFactor: 0.5,
                maxScaleFactor: 1,
              );
              return MediaQuery(
                data: context.mediaQuery.copyWith(
                  textScaler: scale,
                ),
                child: ToastProvider(child: child!),
              );
            },
          );
        },
      ),
    );
  }
}
