import 'package:flutter/material.dart';

class SectionContainer extends StatelessWidget {
  const SectionContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(22),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withOpacity(isDark ? 0.88 : 0.94),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(isDark ? 0.11 : 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.18 : 0.06),
            blurRadius: 32,
            spreadRadius: -8,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(isDark ? 0.05 : 0.03),
            blurRadius: 40,
            spreadRadius: -14,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: child,
    );
  }
}
