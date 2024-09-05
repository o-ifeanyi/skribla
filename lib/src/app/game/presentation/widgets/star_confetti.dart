import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class StarConfetti extends StatelessWidget {
  const StarConfetti({required this.confettiController, super.key});

  final ConfettiController confettiController;

  @override
  Widget build(BuildContext context) {
    return ConfettiWidget(
      confettiController: confettiController,
      numberOfParticles: 20,
      blastDirectionality: BlastDirectionality.explosive,
      colors: Colors.primaries,
      createParticlePath: drawStar,
    );
  }
}

Path drawStar(Size size) {
  // Method to convert degree to radians
  double degToRad(double deg) => deg * (pi / 180.0);

  const numberOfPoints = 5;
  final halfWidth = size.width / 2;
  final externalRadius = halfWidth;
  final internalRadius = halfWidth / 2.5;
  final degreesPerStep = degToRad(360 / numberOfPoints);
  final halfDegreesPerStep = degreesPerStep / 2;
  final path = Path();
  final fullAngle = degToRad(360);
  path.moveTo(size.width, halfWidth);

  for (var step = 0.0; step < fullAngle; step += degreesPerStep) {
    path
      ..lineTo(
        halfWidth + externalRadius * cos(step),
        halfWidth + externalRadius * sin(step),
      )
      ..lineTo(
        halfWidth + internalRadius * cos(step + halfDegreesPerStep),
        halfWidth + internalRadius * sin(step + halfDegreesPerStep),
      );
  }
  path.close();
  return path;
}
