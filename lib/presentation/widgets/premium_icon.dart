import 'dart:math' as math;

import 'package:flutter/material.dart';

enum PremiumGlyph {
  menu,
  profile,
  bell,
  bank,
  topUp,
  pay,
  transfer,
}

class PremiumIcon extends StatelessWidget {
  const PremiumIcon({
    super.key,
    required this.glyph,
    this.size = 24,
    this.color,
    this.strokeWidth = 2,
  });

  final PremiumGlyph glyph;
  final double size;
  final Color? color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PremiumIconPainter(
          glyph: glyph,
          color: color ?? Theme.of(context).iconTheme.color ?? Colors.black,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _PremiumIconPainter extends CustomPainter {
  const _PremiumIconPainter({
    required this.glyph,
    required this.color,
    required this.strokeWidth,
  });

  final PremiumGlyph glyph;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fill = Paint()
      ..color = color.withOpacity(0.12)
      ..style = PaintingStyle.fill;

    switch (glyph) {
      case PremiumGlyph.menu:
        _drawMenu(canvas, size, stroke);
        break;
      case PremiumGlyph.profile:
        _drawProfile(canvas, size, stroke);
        break;
      case PremiumGlyph.bell:
        _drawBell(canvas, size, stroke, fill);
        break;
      case PremiumGlyph.bank:
        _drawBank(canvas, size, stroke, fill);
        break;
      case PremiumGlyph.topUp:
        _drawTopUp(canvas, size, stroke, fill);
        break;
      case PremiumGlyph.pay:
        _drawPay(canvas, size, stroke, fill);
        break;
      case PremiumGlyph.transfer:
        _drawTransfer(canvas, size, stroke);
        break;
    }
  }

  void _drawMenu(Canvas canvas, Size size, Paint stroke) {
    final width = size.width;
    final step = size.height / 4;
    canvas.drawLine(Offset(width * 0.2, step), Offset(width * 0.8, step), stroke);
    canvas.drawLine(
      Offset(width * 0.2, step * 2),
      Offset(width * 0.68, step * 2),
      stroke,
    );
    canvas.drawLine(
      Offset(width * 0.2, step * 3),
      Offset(width * 0.76, step * 3),
      stroke,
    );
  }

  void _drawProfile(Canvas canvas, Size size, Paint stroke) {
    final center = Offset(size.width / 2, size.height * 0.34);
    canvas.drawCircle(center, size.width * 0.16, stroke);

    final bodyRect = Rect.fromLTWH(
      size.width * 0.22,
      size.height * 0.48,
      size.width * 0.56,
      size.height * 0.26,
    );
    canvas.drawArc(bodyRect, math.pi, math.pi, false, stroke);
  }

  void _drawBell(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final path = Path()
      ..moveTo(size.width * 0.3, size.height * 0.45)
      ..quadraticBezierTo(
        size.width * 0.32,
        size.height * 0.2,
        size.width * 0.5,
        size.height * 0.2,
      )
      ..quadraticBezierTo(
        size.width * 0.68,
        size.height * 0.2,
        size.width * 0.7,
        size.height * 0.45,
      )
      ..lineTo(size.width * 0.78, size.height * 0.64)
      ..lineTo(size.width * 0.22, size.height * 0.64)
      ..close();

    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
    canvas.drawLine(
      Offset(size.width * 0.18, size.height * 0.67),
      Offset(size.width * 0.82, size.height * 0.67),
      stroke,
    );
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.76),
      size.width * 0.05,
      stroke,
    );
  }

  void _drawBank(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final roof = Path()
      ..moveTo(size.width * 0.18, size.height * 0.34)
      ..lineTo(size.width * 0.5, size.height * 0.14)
      ..lineTo(size.width * 0.82, size.height * 0.34)
      ..close();
    canvas.drawPath(roof, fill);
    canvas.drawPath(roof, stroke);

    for (final x in [0.28, 0.46, 0.64]) {
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(
          size.width * x,
          size.height * 0.38,
          size.width * 0.08,
          size.height * 0.24,
        ),
        Radius.circular(size.width * 0.02),
      );
      canvas.drawRRect(rect, fill);
      canvas.drawRRect(rect, stroke);
    }

    canvas.drawLine(
      Offset(size.width * 0.16, size.height * 0.67),
      Offset(size.width * 0.84, size.height * 0.67),
      stroke,
    );
  }

  void _drawTopUp(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final card = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.18,
        size.height * 0.3,
        size.width * 0.64,
        size.height * 0.38,
      ),
      Radius.circular(size.width * 0.12),
    );
    canvas.drawRRect(card, fill);
    canvas.drawRRect(card, stroke);
    canvas.drawLine(
      Offset(size.width * 0.32, size.height * 0.49),
      Offset(size.width * 0.58, size.height * 0.49),
      stroke,
    );
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.37),
      Offset(size.width * 0.64, size.height * 0.49),
      stroke,
    );
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.61),
      Offset(size.width * 0.64, size.height * 0.49),
      stroke,
    );
  }

  void _drawPay(Canvas canvas, Size size, Paint stroke, Paint fill) {
    final receipt = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        size.width * 0.24,
        size.height * 0.18,
        size.width * 0.52,
        size.height * 0.58,
      ),
      Radius.circular(size.width * 0.1),
    );
    canvas.drawRRect(receipt, fill);
    canvas.drawRRect(receipt, stroke);
    canvas.drawLine(
      Offset(size.width * 0.34, size.height * 0.36),
      Offset(size.width * 0.66, size.height * 0.36),
      stroke,
    );
    canvas.drawLine(
      Offset(size.width * 0.34, size.height * 0.48),
      Offset(size.width * 0.6, size.height * 0.48),
      stroke,
    );
    canvas.drawCircle(
      Offset(size.width * 0.5, size.height * 0.63),
      size.width * 0.07,
      stroke,
    );
  }

  void _drawTransfer(Canvas canvas, Size size, Paint stroke) {
    final upper = Path()
      ..moveTo(size.width * 0.2, size.height * 0.38)
      ..lineTo(size.width * 0.7, size.height * 0.38)
      ..lineTo(size.width * 0.58, size.height * 0.26);
    final lower = Path()
      ..moveTo(size.width * 0.8, size.height * 0.62)
      ..lineTo(size.width * 0.3, size.height * 0.62)
      ..lineTo(size.width * 0.42, size.height * 0.74);

    canvas.drawPath(upper, stroke);
    canvas.drawPath(lower, stroke);
  }

  @override
  bool shouldRepaint(covariant _PremiumIconPainter oldDelegate) {
    return oldDelegate.glyph != glyph ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
