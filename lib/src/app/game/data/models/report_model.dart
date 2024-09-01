import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/report_model.g.dart';

@JsonSerializable()
class ReportModel {
  const ReportModel(
    this.uid,
    this.gameId,
    this.reason,
    this.createdAt,
  );

  factory ReportModel.fromJson(Map<String, dynamic> json) => _$ReportModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReportModelToJson(this);

  final String uid;
  final String gameId;
  final String reason;
  final DateTime createdAt;
}
