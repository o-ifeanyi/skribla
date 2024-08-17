import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class Config {
  static double get height => 1.sh;
  static double get width => 1.sw;

  static TextTheme get textTheme => TextTheme(
        displayLarge: TextStyle(fontSize: 44.sp, fontFamily: 'MoreSugarMedium'),
        displayMedium: TextStyle(fontSize: 40.sp, fontFamily: 'MoreSugarMedium'),
        displaySmall: TextStyle(fontSize: 36.sp, fontFamily: 'MoreSugarMedium'),
        titleLarge: TextStyle(fontSize: 32.sp, fontFamily: 'MoreSugarMedium'),
        titleMedium: TextStyle(fontSize: 28.sp, fontFamily: 'MoreSugarMedium'),
        titleSmall: TextStyle(fontSize: 20.sp, fontFamily: 'MoreSugarMedium'),
        bodyLarge: TextStyle(fontSize: 18.sp, fontFamily: 'MoreSugarMedium'),
        bodyMedium: TextStyle(fontSize: 16.sp, fontFamily: 'MoreSugarRegular'),
        bodySmall: TextStyle(fontSize: 14.sp, fontFamily: 'MoreSugarRegular'),
        labelLarge: TextStyle(fontSize: 12.sp, fontFamily: 'MoreSugarMedium'),
        labelMedium: TextStyle(fontSize: 10.sp, fontFamily: 'MoreSugarRegular'),
        labelSmall: TextStyle(fontSize: 8.sp, fontFamily: 'MoreSugarRegular'),
      );

  static EdgeInsets all(double padding) => EdgeInsets.all(padding.w);

  static EdgeInsets symmetric({double? h, double? v}) =>
      EdgeInsets.symmetric(horizontal: (h ?? 0).w, vertical: (v ?? 0).h);

  static EdgeInsets fromLTRB(double l, double t, double r, double b) =>
      EdgeInsets.fromLTRB(l.w, t.h, r.w, b.h);

  static double h(double height) => height.h;
  static double w(double width) => width.w;
  static double dg(double diagonal) => diagonal.dg;

  static SizedBox get hBox4 => 4.horizontalSpace;
  static SizedBox get hBox8 => 8.horizontalSpace;
  static SizedBox get hBox12 => 12.horizontalSpace;
  static SizedBox get hBox16 => 16.horizontalSpace;
  static SizedBox get hBox20 => 20.horizontalSpace;
  static SizedBox get hBox24 => 24.horizontalSpace;

  static SizedBox get vBox4 => 4.verticalSpace;
  static SizedBox get vBox8 => 8.verticalSpace;
  static SizedBox get vBox12 => 12.verticalSpace;
  static SizedBox get vBox16 => 16.verticalSpace;
  static SizedBox get vBox20 => 20.verticalSpace;
  static SizedBox get vBox24 => 24.verticalSpace;
  static SizedBox get vBox30 => 30.verticalSpace;

  static BorderRadius get radius8 => BorderRadius.circular(8);
  static BorderRadius get radius10 => BorderRadius.circular(10);
  static BorderRadius get radius16 => BorderRadius.circular(16);
  static BorderRadius get radius24 => BorderRadius.circular(24);
  static BorderRadius get radius32 => BorderRadius.circular(32);

  static Duration get duration150 => const Duration(milliseconds: 150);
  static Duration get duration300 => const Duration(milliseconds: 300);
  static Duration get duration600 => const Duration(milliseconds: 600);
  static Duration get duration1000 => const Duration(milliseconds: 1000);
}
