import 'package:draw_and_guess/src/core/util/converters.dart';
import 'package:flutter/painting.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/line_model.g.dart';

@JsonSerializable(
  converters: [OffsetConverter(), SizeConverter(), ColorConverter()],
)
class LineModel {
  const LineModel(
    this.path,
    this.size,
    this.color,
    this.stroke,
  );

  factory LineModel.fromJson(Map<String, dynamic> json) => _$LineModelFromJson(json);

  Map<String, dynamic> toJson() => _$LineModelToJson(this);

  final List<Offset> path;
  final Size size;
  final Color color;
  final int stroke;
}
