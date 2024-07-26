import 'package:draw_and_guess/src/core/service/logger.dart';
import 'package:flutter/material.dart';

const _logger = Logger('Build Watch');

class BuildWatch extends StatelessWidget {
  const BuildWatch({
    required this.child,
    required this.name,
    super.key,
  });

  final Widget child;
  final String name;

  @override
  Widget build(BuildContext context) {
    _logger.build(name);
    return child;
  }
}
