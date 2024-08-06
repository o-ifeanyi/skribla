import 'dart:ui' show PlatformDispatcher, PointerDeviceKind;

import 'package:flutter/material.dart' hide Router;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skribla/src/core/di/di.dart';
import 'package:skribla/src/core/router/router.dart';
import 'package:skribla/src/core/service/remote_config.dart';
import 'package:skribla/src/core/theme/app_theme.dart';
import 'package:skribla/src/core/util/extension.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
      ..addObserver(this)
      ..addPostFrameCallback((_) {
        RemoteConfig.instance.init(context);
      });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    AppTheme.brightness = PlatformDispatcher.instance.platformBrightness;
    setState(() {});
    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      minTextAdapt: true,
      fontSizeResolver: (fontSize, instance) => fontSize.toDouble(),
      child: Consumer(
        builder: (context, ref, child) {
          final routerConfig = ref.watch(routerProvider);
          final themeOption = ref.watch(themeProvider);
          return MaterialApp.router(
            title: 'Skribla',
            theme: AppTheme.themeOptions(themeOption),
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
            themeMode: context.themeMode,
            routerConfig: routerConfig,
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
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
