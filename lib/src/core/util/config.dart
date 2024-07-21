import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Config {
  static double get height => 1.sh;
  static double get width => 1.sw;

  static TextTheme get textTheme => TextTheme(
        titleLarge:
            GoogleFonts.sora(fontSize: 32.sp, fontWeight: FontWeight.w600),
        titleMedium:
            GoogleFonts.sora(fontSize: 28.sp, fontWeight: FontWeight.w600),
        titleSmall:
            GoogleFonts.sora(fontSize: 18.sp, fontWeight: FontWeight.w600),
        bodyLarge:
            GoogleFonts.sora(fontSize: 16.sp, fontWeight: FontWeight.w600),
        bodyMedium: GoogleFonts.sora(fontSize: 14.sp),
        bodySmall: GoogleFonts.sora(fontSize: 12.sp),
        labelLarge:
            GoogleFonts.sora(fontSize: 12.sp, fontWeight: FontWeight.w600),
        labelMedium: GoogleFonts.sora(fontSize: 12.sp),
        labelSmall: GoogleFonts.sora(fontSize: 10.sp),
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
  static BorderRadius get radius16 => BorderRadius.circular(16);
  static BorderRadius get radius24 => BorderRadius.circular(24);
  static BorderRadius get radius32 => BorderRadius.circular(32);

  static Duration get duration300 => const Duration(milliseconds: 300);
  static Duration get duration600 => const Duration(milliseconds: 600);
}
