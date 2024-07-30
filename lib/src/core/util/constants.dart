import 'package:draw_and_guess/src/app/game/data/models/word_model.dart';
import 'package:flutter/material.dart';

abstract class Constants {
  static const points = 10;
  static final colors = [...Colors.primaries];
  static final allColors = [...Colors.primaries, ...Colors.accents];
  static const words = [
    WordModel(
      id: '1',
      text: 'Apple',
    ),
    WordModel(
      id: '2',
      text: 'Car',
    ),
    WordModel(
      id: '3',
      text: 'Laptop',
    ),
    WordModel(
      id: '4',
      text: 'Headphone',
    ),
  ];
}
