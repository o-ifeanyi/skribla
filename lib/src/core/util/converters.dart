import 'dart:ui';

import 'package:json_annotation/json_annotation.dart';

class OffsetConverter implements JsonConverter<Offset, Map<String, dynamic>> {
  const OffsetConverter();

  @override
  Offset fromJson(Map<String, dynamic> json) => Offset(
        double.tryParse('${json['dx']}') ?? 0,
        double.tryParse('${json['dy']}') ?? 0,
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
        double.tryParse('${json['width']}') ?? 0,
        double.tryParse('${json['height']}') ?? 0,
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
