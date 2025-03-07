import 'package:flutter/material.dart';

class TrapezedPainter extends CustomPainter {
  final Color color;

  TrapezedPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();

    double cornerRadius = 20;
    double topSkewAmount = 10; // Top edges are indented (wider at bottom)
    double bottomWidth = size.width;
    double topWidth =
        size.width - (topSkewAmount * 2); // Top is narrower than bottom

    // Calculate key points
    double topLeft = topSkewAmount;
    double topRight = topLeft + topWidth;

    // Start at top-left with rounded corner
    path.moveTo(topLeft + cornerRadius, 0);

    // Top edge (straight line)
    path.lineTo(topRight - cornerRadius, 0);

    // Top-right rounded corner
    path.arcToPoint(
      Offset(topRight, cornerRadius),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );

    // Right edge (sloped outward from top to bottom)
    path.lineTo(bottomWidth - cornerRadius, size.height - cornerRadius);

    // Bottom-right rounded corner
    path.arcToPoint(
      Offset(bottomWidth - cornerRadius * 2, size.height),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );

    // Bottom edge (straight line)
    path.lineTo(cornerRadius * 2, size.height);

    // Bottom-left rounded corner
    path.arcToPoint(
      Offset(cornerRadius, size.height - cornerRadius),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );

    // Left edge (sloped inward from bottom to top)
    path.lineTo(topLeft, cornerRadius);

    // Top-left rounded corner
    path.arcToPoint(
      Offset(topLeft + cornerRadius, 0),
      radius: Radius.circular(cornerRadius),
      clockwise: true,
    );

    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}