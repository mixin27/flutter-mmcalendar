import 'package:flutter/material.dart';

import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import 'mm_pressable.dart';

/// A small coloured label, such as a holiday or Sabbath badge.
///
/// Chips are tinted fills even in the glass style: a backdrop filter per chip
/// would cost too much in a list of days.
class MmChip extends StatelessWidget {
  /// Creates a chip.
  const MmChip({
    required this.label,
    super.key,
    this.color,
    this.dot = false,
    this.outlined = false,
    this.icon,
    this.onPressed,
    this.style,
  });

  /// The text.
  final String label;

  /// The chip's colour; defaults to the muted text colour.
  final Color? color;

  /// Whether to lead with a coloured dot.
  final bool dot;

  /// Draws an outline instead of a fill, e.g. for custom holidays.
  final bool outlined;

  /// An icon before the label.
  final IconData? icon;

  /// Makes the chip tappable.
  final VoidCallback? onPressed;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  @override
  Widget build(BuildContext context) {
    final style = MyanmarCalendarScope.styleOf(context, this.style);
    final theme = MyanmarCalendarScope.themeOf(context);
    final c = color ?? theme.muted;
    final radius = BorderRadius.circular(switch (style) {
      MmVisualStyle.cupertino => 6,
      MmVisualStyle.glass => 999,
      _ => 8,
    });
    final chip = DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        color: outlined
            ? null
            : c.withValues(
                alpha: theme.brightness == Brightness.dark ? 0.2 : 0.13,
              ),
        border: outlined ? Border.all(color: c) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (dot) ...[
              DecoratedBox(
                decoration: BoxDecoration(color: c, shape: BoxShape.circle),
                child: const SizedBox.square(dimension: 6),
              ),
              const SizedBox(width: 5),
            ],
            if (icon != null) ...[
              Icon(icon, size: 14, color: c),
              const SizedBox(width: 4),
            ],
            Flexible(
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: c,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    if (onPressed == null) return chip;
    return MmPressable(
      onPressed: onPressed,
      borderRadius: radius,
      focusColor: theme.accent,
      minSize: 32,
      child: chip,
    );
  }
}
