import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/themes/theme_provider.dart';

class ParticleBackground extends StatefulWidget {
  const ParticleBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<ParticleBackground> createState() => _ParticleBackgroundState();
}

class _ParticleBackgroundState extends State<ParticleBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  double _scrollOffset = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = context.watch<ThemeProvider>();
    final accent = themeProvider.accent.color;
    final palette = themeProvider.palette;
    final isDark = theme.brightness == Brightness.dark;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.axis == Axis.vertical) {
          final nextOffset = notification.metrics.pixels;
          if ((nextOffset - _scrollOffset).abs() > 2) {
            setState(() {
              _scrollOffset = nextOffset;
            });
          }
        }
        return false;
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: RepaintBoundary(
                child: CustomPaint(
                  painter: _ParticlePainter(
                    progress: _controller,
                    accent: accent,
                    isDark: isDark,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: -120 + (_scrollOffset * 0.04),
            right: -80,
            child: IgnorePointer(
              child: _BackgroundHalo(
                size: 220,
                color: accent.withOpacity(isDark ? 0.14 : 0.10),
              ),
            ),
          ),
          Positioned(
            bottom: -100 - (_scrollOffset * 0.03),
            left: -90,
            child: IgnorePointer(
              child: _BackgroundHalo(
                size: 240,
                color: palette.secondary.withOpacity(isDark ? 0.10 : 0.08),
              ),
            ),
          ),
          Positioned.fill(child: widget.child),
        ],
      ),
    );
  }
}

class _BackgroundHalo extends StatelessWidget {
  const _BackgroundHalo({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color,
            color.withOpacity(0),
          ],
        ),
      ),
    );
  }
}

class _ParticlePainter extends CustomPainter {
  _ParticlePainter({
    required this.progress,
    required this.accent,
    required this.isDark,
  }) : super(repaint: progress);

  final Animation<double> progress;
  final Color accent;
  final bool isDark;

  static const _particles = [
    _ParticleSeed(0.10, 0.14, 1.6, 0.011, 0.013, 0.22),
    _ParticleSeed(0.28, 0.32, 2.2, 0.010, 0.009, 0.18),
    _ParticleSeed(0.44, 0.22, 1.4, 0.008, 0.011, 0.20),
    _ParticleSeed(0.62, 0.18, 2.8, 0.013, 0.008, 0.24),
    _ParticleSeed(0.78, 0.28, 1.8, 0.010, 0.010, 0.20),
    _ParticleSeed(0.18, 0.62, 2.4, 0.012, 0.007, 0.18),
    _ParticleSeed(0.34, 0.70, 1.5, 0.009, 0.010, 0.20),
    _ParticleSeed(0.56, 0.58, 2.0, 0.008, 0.012, 0.18),
    _ParticleSeed(0.74, 0.66, 1.7, 0.010, 0.009, 0.20),
    _ParticleSeed(0.88, 0.78, 2.5, 0.011, 0.010, 0.16),
    _ParticleSeed(0.12, 0.84, 1.6, 0.009, 0.012, 0.15),
    _ParticleSeed(0.50, 0.88, 2.1, 0.007, 0.010, 0.16),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final animationValue = progress.value;
    final paint = Paint()..style = PaintingStyle.fill;
    final linePaint = Paint()
      ..color = accent.withOpacity(isDark ? 0.10 : 0.06)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.1;

    final topLine = Path()
      ..moveTo(-20, size.height * 0.18)
      ..quadraticBezierTo(
        size.width * 0.32,
        size.height * (0.08 + (animationValue * 0.02)),
        size.width * 0.72,
        size.height * 0.22,
      )
      ..quadraticBezierTo(
        size.width * 0.9,
        size.height * 0.28,
        size.width + 16,
        size.height * 0.2,
      );
    final bottomLine = Path()
      ..moveTo(-24, size.height * 0.82)
      ..quadraticBezierTo(
        size.width * 0.26,
        size.height * 0.74,
        size.width * 0.58,
        size.height * (0.88 - (animationValue * 0.02)),
      )
      ..quadraticBezierTo(
        size.width * 0.88,
        size.height * 0.96,
        size.width + 24,
        size.height * 0.86,
      );

    canvas.drawPath(topLine, linePaint);
    canvas.drawPath(bottomLine, linePaint);

    for (final particle in _particles) {
      final dx =
          ((particle.x + animationValue * particle.vx) % 1) * size.width;
      final dy =
          ((particle.y + animationValue * particle.vy) % 1) * size.height;
      final radius = particle.radius * (size.shortestSide / 180);
      paint.color = accent.withOpacity(
        particle.opacity * (isDark ? 1 : 0.85),
      );
      canvas.drawCircle(Offset(dx, dy), radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) {
    return oldDelegate.accent != accent || oldDelegate.isDark != isDark;
  }
}

class _ParticleSeed {
  const _ParticleSeed(
    this.x,
    this.y,
    this.radius,
    this.vx,
    this.vy,
    this.opacity,
  );

  final double x;
  final double y;
  final double radius;
  final double vx;
  final double vy;
  final double opacity;
}
