import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:skribla/src/core/resource/app_icons.dart';
import 'package:skribla/src/core/util/config.dart';
import 'package:skribla/src/core/util/constants.dart';
import 'package:skribla/src/core/util/enums.dart';

extension StringExt on String {
  String get routeName {
    if (this == '/') return this;
    if (startsWith('/')) return split('/').last;

    return this;
  }

  String get capitalize {
    if (length < 2) return toUpperCase();
    return substring(0, 1).toUpperCase() + substring(1).toLowerCase();
  }
}

extension WidgetExt on Widget {
  Widget rotate(int quarterTurns) {
    return RotatedBox(quarterTurns: quarterTurns, child: this);
  }
}

extension DateTimeExt on DateTime {
  String get formatEDMHM => DateFormat('EEE d MMM HH:mm').format(this);
  bool get isNotExpired => DateTime.now().isBefore(this);
}

extension ListExt on List<Object> {
  int get lastIndex => length - 1;
}

extension MapExtension on Map<String, dynamic> {
  Map<String, dynamic> get removeNull =>
      this..removeWhere((String key, dynamic value) => value == null);
}

extension BuildContextExt on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  Brightness get brightness => theme.brightness;
  TextTheme get textTheme => theme.textTheme;
  Color? get textColor => theme.textTheme.bodyMedium?.color;
  Size get screenSize => MediaQuery.sizeOf(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);
  EdgeInsets get padding => MediaQuery.viewPaddingOf(this);
  AppLocalizations get loc => AppLocalizations.of(this);
  RoundedRectangleBorder get modalShape => RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Config.radius16.topLeft,
          topRight: Config.radius16.topRight,
        ),
      );

  ButtonStyle get iconButtonStyle => IconButton.styleFrom(
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      );

  Future<Color?> showColorPicker(Color? prevColor) {
    return showDialog<Color>(
      context: this,
      builder: (context) {
        return AlertDialog.adaptive(
          content: Wrap(
            alignment: WrapAlignment.center,
            runSpacing: Config.h(8),
            spacing: Config.h(8),
            children: Constants.allColors
                .map(
                  (color) => GestureDetector(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: Config.h(15),
                          backgroundColor: color,
                        ),
                        if (prevColor == color) ...[
                          Icon(
                            AppIcons.check,
                            color: Colors.white,
                            size: Config.h(16),
                          ),
                        ],
                      ],
                    ),
                    onTap: () => context.pop(color),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  Future<T?> showModal<T>(Widget child) {
    return showModalBottomSheet<T>(
      context: this,
      shape: modalShape,
      isScrollControlled: true,
      builder: (context) => child,
    );
  }

  Future<SafetyOption?> showSafetyOptions({String username = ''}) async {
    return showCupertinoModalPopup<SafetyOption>(
      context: this,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () => context.pop(SafetyOption.report),
              child: Text(loc.report(username).trim()),
            ),
            CupertinoActionSheetAction(
              onPressed: () => context.pop(SafetyOption.block),
              child: Text(loc.block(username).trim()),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: context.pop,
            child: Text(context.loc.cancel),
          ),
        );
      },
    );
  }
}
