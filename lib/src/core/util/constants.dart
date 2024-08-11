import 'package:flutter/material.dart';
import 'package:skribla/src/app/game/data/models/word_model.dart';

abstract class Constants {
  static const points = 10;
  static const email = 'skriblaapp@gmail.com';
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
  static const privacy = 'https://skribla.com/privacy';
  static const terms = 'https://skribla.com/terms';
  static const website = 'https://skribla.com/';
  static const playstore = 'https://skribla.com/';
  static const appstore = 'https://skribla.com/';
}
