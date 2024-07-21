import 'package:draw_and_guess/src/app/game/data/models/line_model.dart';
import 'package:flutter/material.dart';

class ArtPainter extends CustomPainter {
  ArtPainter({required this.art, this.repaint = true});
  final List<LineModel> art;
  final bool repaint;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeCap = StrokeCap.round;

    for (var i = 0; i < art.length; ++i) {
      final line = art[i];
      // Calculate the scaling factors
      final scaleX = size.width / line.size.width;
      final scaleY = size.height / line.size.height;

      for (var j = 0; j < line.path.length - 1; ++j) {
        paint
          ..color = line.color
          ..strokeWidth = line.stroke.toDouble();

        // Scale the points
        final p1 = Offset(
          line.path[j].dx * scaleX,
          line.path[j].dy * scaleY,
        );
        final p2 = Offset(
          line.path[j + 1].dx * scaleX,
          line.path[j + 1].dy * scaleY,
        );

        canvas.drawLine(p1, p2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(ArtPainter oldDelegate) => repaint;
}
