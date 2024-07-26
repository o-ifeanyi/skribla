import 'package:draw_and_guess/src/app/game/data/models/line_model.dart';
import 'package:draw_and_guess/src/app/game/data/models/player_model.dart';
import 'package:draw_and_guess/src/app/game/data/models/word_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'generated/exhibit_model.g.dart';

enum WordCategory { all }

@JsonSerializable()
class ExhibitModel {
  const ExhibitModel({
    required this.id,
    required this.player,
    required this.word,
    required this.art,
    required this.createdAt,
  });

  factory ExhibitModel.fromJson(Map<String, dynamic> json) =>
      _$ExhibitModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExhibitModelToJson(this);

  final String id;
  final PlayerModel player;
  final WordModel word;
  final List<LineModel> art;
  final DateTime createdAt;
}
