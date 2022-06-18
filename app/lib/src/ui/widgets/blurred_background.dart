import 'dart:ui';

import 'package:flutter/material.dart';

class BlurredBackground extends StatelessWidget {
  const BlurredBackground({
    required this.child,
    required this.color,
    super.key,
  });

  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: -100.0,
            right: -100.0,
            child: _BackgroundCircle(
              color: color,
              height: 300.0,
              width: 300.0,
            ),
          ),
          Positioned(
            top: height / 2 - 100.0,
            left: -100.0,
            child: _BackgroundCircle(
              color: color,
              height: 200.0,
              width: 200.0,
            ),
          ),
          Positioned(
            bottom: -150.0,
            left: width / 2 - 150.0,
            child: _BackgroundCircle(
              color: color,
              height: 300.0,
              width: 300.0,
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 50.0,
              sigmaY: 50.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.0),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _BackgroundCircle extends StatelessWidget {
  const _BackgroundCircle({
    required this.color,
    required this.height,
    required this.width,
  });

  final Color color;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(500.0),
          color: color,
        ),
      );
}
