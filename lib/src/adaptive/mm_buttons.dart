import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import 'mm_glass.dart';
import 'mm_pressable.dart';

/// How prominent an [MmButton] is.
enum MmButtonVariant {
  /// The main action: filled with the accent.
  filled,

  /// A secondary action on a soft accent background.
  tonal,

  /// A low-emphasis action: text only.
  text,
}

/// A button that is a `FilledButton`/`TextButton` in Material, a
/// `CupertinoButton` in Cupertino, and a glass capsule in Glass.
class MmButton extends StatelessWidget {
  /// Creates a button with a [label] and optional [icon].
  const MmButton({
    required this.label,
    required this.onPressed,
    super.key,
    this.icon,
    this.variant = MmButtonVariant.filled,
    this.style,
  });

  /// The button text.
  final String label;

  /// An icon before the label.
  final IconData? icon;

  /// Called on press; `null` disables the button.
  final VoidCallback? onPressed;

  /// How prominent the button is.
  final MmButtonVariant variant;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  @override
  Widget build(BuildContext context) {
    final style = MyanmarCalendarScope.styleOf(context, this.style);
    final theme = MyanmarCalendarScope.themeOf(context);
    final text = Text(label, maxLines: 1, overflow: TextOverflow.ellipsis);

    switch (style) {
      case MmVisualStyle.material:
      case MmVisualStyle.automatic:
        // Only enabled colours are set, so disabled buttons keep Material's
        // disabled look.
        Color? enabledOnly(Set<WidgetState> states, Color? color) =>
            states.contains(WidgetState.disabled) ? null : color;
        final buttonStyle = ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => enabledOnly(states, switch (variant) {
              MmButtonVariant.filled => theme.accent,
              MmButtonVariant.tonal => theme.accentContainer,
              MmButtonVariant.text => null,
            }),
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => enabledOnly(
              states,
              variant == MmButtonVariant.filled ? theme.onAccent : theme.accent,
            ),
          ),
        );
        final child = icon == null
            ? text
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(icon, size: 18),
                  const SizedBox(width: 8),
                  text,
                ],
              );
        return switch (variant) {
          MmButtonVariant.text => TextButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: child,
          ),
          _ => FilledButton(
            onPressed: onPressed,
            style: buttonStyle,
            child: child,
          ),
        };

      case MmVisualStyle.cupertino:
        final child = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18),
              const SizedBox(width: 6),
            ],
            text,
          ],
        );
        return switch (variant) {
          MmButtonVariant.filled => CupertinoButton.filled(
            onPressed: onPressed,
            color: theme.accent,
            sizeStyle: CupertinoButtonSize.medium,
            child: DefaultTextStyle.merge(
              style: TextStyle(color: theme.onAccent),
              child: IconTheme.merge(
                data: IconThemeData(color: theme.onAccent),
                child: child,
              ),
            ),
          ),
          MmButtonVariant.tonal => CupertinoButton.tinted(
            onPressed: onPressed,
            color: theme.accent,
            sizeStyle: CupertinoButtonSize.medium,
            child: child,
          ),
          MmButtonVariant.text => CupertinoButton(
            onPressed: onPressed,
            sizeStyle: CupertinoButtonSize.medium,
            child: DefaultTextStyle.merge(
              style: TextStyle(color: theme.accent),
              child: IconTheme.merge(
                data: IconThemeData(color: theme.accent),
                child: child,
              ),
            ),
          ),
        };

      case MmVisualStyle.glass:
        final filled = variant == MmButtonVariant.filled;
        final fg = filled ? theme.onAccent : theme.ink;
        final face = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
          child: DefaultTextStyle.merge(
            style: TextStyle(color: fg, fontWeight: FontWeight.w600),
            child: IconTheme.merge(
              data: IconThemeData(color: fg, size: 18),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[Icon(icon), const SizedBox(width: 6)],
                  text,
                ],
              ),
            ),
          ),
        );
        return MmPressable(
          onPressed: onPressed,
          focusColor: theme.accent,
          child: variant == MmButtonVariant.text
              ? face
              : MmGlass(
                  borderRadius: BorderRadius.circular(999),
                  thickness: MmGlassThickness.clear,
                  shadow: filled,
                  tint: filled ? theme.accent.withValues(alpha: 0.82) : null,
                  child: face,
                ),
        );
    }
  }
}

/// An icon-only button: `IconButton` in Material, `CupertinoButton` in
/// Cupertino, a round glass button in Glass. Always has a [tooltip], which is
/// also its accessible label.
class MmIconButton extends StatelessWidget {
  /// Creates an icon button.
  const MmIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    super.key,
    this.style,
  });

  /// The icon.
  final IconData icon;

  /// What the button does, shown on hover and read by screen readers.
  final String tooltip;

  /// Called on press; `null` disables the button.
  final VoidCallback? onPressed;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  @override
  Widget build(BuildContext context) {
    final style = MyanmarCalendarScope.styleOf(context, this.style);
    final theme = MyanmarCalendarScope.themeOf(context);
    switch (style) {
      case MmVisualStyle.material:
      case MmVisualStyle.automatic:
        return IconButton(
          icon: Icon(icon),
          tooltip: tooltip,
          color: theme.ink,
          onPressed: onPressed,
        );
      case MmVisualStyle.cupertino:
        return Tooltip(
          message: tooltip,
          excludeFromSemantics: true,
          child: Semantics(
            label: tooltip,
            button: true,
            excludeSemantics: true,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              minimumSize: const Size.square(44),
              onPressed: onPressed,
              child: Icon(icon, color: theme.accent),
            ),
          ),
        );
      case MmVisualStyle.glass:
        return Tooltip(
          message: tooltip,
          excludeFromSemantics: true,
          child: MmPressable(
            onPressed: onPressed,
            semanticLabel: tooltip,
            focusColor: theme.accent,
            child: MmGlass(
              borderRadius: BorderRadius.circular(999),
              thickness: MmGlassThickness.clear,
              shadow: false,
              child: SizedBox.square(
                dimension: 38,
                child: Icon(icon, size: 20, color: theme.ink),
              ),
            ),
          ),
        );
    }
  }
}
