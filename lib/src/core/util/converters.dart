import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

class OffsetConverter implements JsonConverter<Offset, Map<String, dynamic>> {
  const OffsetConverter();

  @override
  Offset fromJson(Map<String, dynamic> json) => Offset(
        json['dx'] as double? ?? 0,
        json['dy'] as double? ?? 0,
      );

  @override
  Map<String, dynamic> toJson(Offset offset) => {
        'dx': offset.dx,
        'dy': offset.dy,
      };
}

class SizeConverter implements JsonConverter<Size, Map<String, dynamic>> {
  const SizeConverter();

  @override
  Size fromJson(Map<String, dynamic> json) => Size(
        json['width'] as double? ?? 0,
        json['height'] as double? ?? 0,
      );

  @override
  Map<String, dynamic> toJson(Size size) => {
        'width': size.width,
        'height': size.height,
      };
}

class ColorConverter implements JsonConverter<Color, String> {
  const ColorConverter();

  @override
  Color fromJson(String json) => Color(int.parse(json, radix: 16));

  @override
  String toJson(Color color) => color.value.toRadixString(16);
}
