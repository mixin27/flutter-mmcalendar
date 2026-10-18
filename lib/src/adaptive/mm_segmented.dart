import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import 'mm_glass.dart';
import 'mm_pressable.dart';

/// A choice of one option from a few: `SegmentedButton` in Material,
/// `CupertinoSlidingSegmentedControl` in Cupertino, and a glass capsule with
/// a sliding thumb in Glass.
class MmSegmented<T extends Object> extends StatelessWidget {
  /// Creates a segmented control. [segments] maps each value to its label,
  /// in display order.
  const MmSegmented({
    required this.segments,
    required this.selected,
    required this.onChanged,
    super.key,
    this.style,
  }) : assert(segments.length >= 2, 'A segmented control needs two options');

  /// Each option's label, in display order.
  final Map<T, String> segments;

  /// The selected option.
  final T selected;

  /// Called with the option the user picks; `null` disables the control.
  final ValueChanged<T>? onChanged;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  @override
  Widget build(BuildContext context) {
    final style = MyanmarCalendarScope.styleOf(context, this.style);
    final theme = MyanmarCalendarScope.themeOf(context);
    switch (style) {
      case MmVisualStyle.material:
      case MmVisualStyle.automatic:
        return SegmentedButton<T>(
          segments: [
            for (final e in segments.entries)
              ButtonSegment(value: e.key, label: Text(e.value, maxLines: 1)),
          ],
          selected: {selected},
          showSelectedIcon: false,
          onSelectionChanged: onChanged == null
              ? null
              : (values) => onChanged!(values.first),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith(
              (states) => states.contains(WidgetState.selected)
                  ? theme.accentContainer
                  : null,
            ),
          ),
        );
      case MmVisualStyle.cupertino:
        return CupertinoSlidingSegmentedControl<T>(
          groupValue: selected,
          backgroundColor: theme.surfaceVariant,
          thumbColor: theme.surface,
          onValueChanged: (v) {
            if (v != null) onChanged?.call(v);
          },
          children: {
            for (final e in segments.entries)
              e.key: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                child: Text(e.value, maxLines: 1),
              ),
          },
        );
      case MmVisualStyle.glass:
        return _GlassSegmented<T>(
          segments: segments,
          selected: selected,
          onChanged: onChanged,
        );
    }
  }
}

class _GlassSegmented<T extends Object> extends StatelessWidget {
  const _GlassSegmented({
    required this.segments,
    required this.selected,
    required this.onChanged,
  });

  final Map<T, String> segments;
  final T selected;
  final ValueChanged<T>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = MyanmarCalendarScope.themeOf(context);
    final keys = segments.keys.toList();
    final index = keys.indexOf(selected);
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    return MmGlass(
      borderRadius: BorderRadius.circular(999),
      thickness: MmGlassThickness.clear,
      shadow: false,
      padding: const EdgeInsets.all(3),
      child: IntrinsicWidth(
        child: Stack(
          children: [
            if (index >= 0)
              Positioned.fill(
                child: AnimatedAlign(
                  alignment: Alignment(
                    keys.length == 1 ? 0 : -1 + 2 * index / (keys.length - 1),
                    0,
                  ),
                  duration: reduceMotion
                      ? Duration.zero
                      : const Duration(milliseconds: 260),
                  curve: Curves.easeOutBack,
                  child: FractionallySizedBox(
                    widthFactor: 1 / keys.length,
                    heightFactor: 1,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: theme.surface.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(999),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            Row(
              children: [
                for (final k in keys)
                  Expanded(
                    child: MmPressable(
                      onPressed: onChanged == null ? null : () => onChanged!(k),
                      selected: k == selected,
                      focusColor: theme.accent,
                      minSize: 34,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        child: Text(
                          segments[k]!,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: theme.ink,
                            fontWeight: k == selected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
