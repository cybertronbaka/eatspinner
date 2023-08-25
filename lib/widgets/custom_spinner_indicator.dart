import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class CustomSpinnerIndicatorPainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  CustomSpinnerIndicatorPainter({this.strokeColor = Colors.black, this.strokeWidth = 3, this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;
    canvas.drawPath(getTopPartPath(size.width, size.height), paint);
    canvas.drawPath(getBottomPartPath(size.width, size.height), paint);
  }

  Path getTopPartPath(double x, double y) {
    y = topH(y);
    final topEdge1x = (x / 2) - 0.1 * x;
    final topEdge1y = 0.2 * y;
    final topEdge2x = (x / 2) + 0.1 * x;
    final topEdge2y = 0.2 * y;

    return Path()
      ..moveTo(0, y)
      ..lineTo(topEdge1x, topEdge1y)
      ..quadraticBezierTo(
          x/2, 0, topEdge2x, topEdge2y
      )
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  Path getBottomPartPath(double x, double y) {
    final h = topH(y);
    return Path()
      ..moveTo(0, h)
      ..arcTo(Rect.fromCircle(center: Offset(x/2, h), radius: x/2), degToRad(0), degToRad(180), true)
      ..lineTo(0, h);
  }

  double topH(double y) => y * 0.56;

  double degToRad(double deg) => deg * (math.pi / 180.0);

  @override
  bool shouldRepaint(CustomSpinnerIndicatorPainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

class CustomSpinnerIndicator extends StatelessWidget {
  const CustomSpinnerIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Transform.rotate(
          angle: math.pi,
          child: CustomPaint(
            painter: CustomSpinnerIndicatorPainter(
              strokeColor: const Color(0xFFDF1F1F),
              strokeWidth: 10,
              paintingStyle: PaintingStyle.fill,
            ),
            child: const SizedBox(
              height: 70,
              width: 40,
            ),
          ),
        ),
        Positioned(
          left: 5,
          top: 10,
          child: Transform.rotate(
            angle: math.pi,
            child: CustomPaint(
              painter: CustomSpinnerIndicatorPainter(
                strokeColor: const Color(0xFFEF2F2F).withOpacity(0.8),
                strokeWidth: 10,
                paintingStyle: PaintingStyle.fill,
              ),
              child: const SizedBox(
                height: 50,
                width: 30,
              ),
            ),
          ),
        )
      ],
    );
  }
}