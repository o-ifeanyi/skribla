import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

abstract class AppIcons {
  static IconData get play => PhosphorIcons.play();
  static IconData get minusCircle => PhosphorIcons.minusCircle();
  static IconData get plusCircle => PhosphorIcons.plusCircle();
  static IconData get eraser => PhosphorIcons.eraser();
  static IconData get pencilSimple => PhosphorIcons.pencilSimple();
  static IconData get check => PhosphorIcons.check(PhosphorIconsStyle.bold);
  static IconData get paperPlaneRight => PhosphorIcons.paperPlaneRight(
        PhosphorIconsStyle.fill,
      );
  static IconData get x => PhosphorIcons.x(PhosphorIconsStyle.bold);
}
