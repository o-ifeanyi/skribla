import 'package:flutter/material.dart';
import 'package:skribla/src/core/util/config.dart';

class LightPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.1, 0.6, 1.0],
        colors: [Colors.white38, Colors.white12, Colors.transparent],
      ).createShader(
        Rect.fromPoints(
          Offset(size.width / 2, 0),
          Offset(size.width / 2, size.height),
        ),
      );

    final path = Path()
      ..moveTo(size.width / 2 - Config.w(10), 20)
      ..lineTo(Config.w(15), size.height)
      ..lineTo(size.width - Config.w(15), size.height)
      ..lineTo(size.width / 2 + Config.w(10), 20)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
