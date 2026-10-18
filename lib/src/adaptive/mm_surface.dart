import 'package:flutter/material.dart';

import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import 'mm_glass.dart';

/// A card for calendar content: a tonal card in Material, a hairline-edged
/// panel in Cupertino, and a glass panel in Glass.
class MmSurface extends StatelessWidget {
  /// Creates a surface around [child].
  const MmSurface({
    required this.child,
    super.key,
    this.padding,
    this.borderRadius,
    this.style,
    this.glassThickness = MmGlassThickness.regular,
  });

  /// The content.
  final Widget child;

  /// Space inside the edge.
  final EdgeInsetsGeometry? padding;

  /// Overrides the corner radius from the theme and style.
  final BorderRadius? borderRadius;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// How much the glass style blurs.
  final MmGlassThickness glassThickness;

  @override
  Widget build(BuildContext context) {
    final style = MyanmarCalendarScope.styleOf(context, this.style);
    final theme = MyanmarCalendarScope.themeOf(context);
    final radius =
        borderRadius ??
        BorderRadius.circular(theme.cardRadius ?? style.cardRadius);
    final content = padding == null
        ? child
        : Padding(padding: padding!, child: child);

    switch (style) {
      case MmVisualStyle.glass:
        return MmGlass(
          borderRadius: radius,
          thickness: glassThickness,
          child: content,
        );
      case MmVisualStyle.cupertino:
        return DecoratedBox(
          decoration: BoxDecoration(
            color: theme.surface,
            borderRadius: radius,
            border: Border.all(color: theme.outline, width: 0.5),
          ),
          child: content,
        );
      case MmVisualStyle.material:
      case MmVisualStyle.automatic:
        return Material(
          color: Color.alphaBlend(
            theme.accent.withValues(alpha: 0.05),
            theme.surface,
          ),
          elevation: 1,
          shadowColor: Colors.black.withValues(alpha: 0.4),
          surfaceTintColor: Colors.transparent,
          borderRadius: radius,
          clipBehavior: Clip.antiAlias,
          child: content,
        );
    }
  }
}
