import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_pressable.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import '../pickers/myanmar_date_picker.dart';

/// A tappable well showing a label, a main line and a detail line, which
/// opens a date picker. Shared by the converter and difference card.
class PickableDateRow extends StatelessWidget {
  /// Creates a row.
  const PickableDateRow({
    required this.label,
    required this.main,
    required this.date,
    required this.onPicked,
    super.key,
    this.detail,
    this.inputMode = MyanmarPickerInput.calendar,
    this.style,
  });

  /// What the row holds, e.g. "Western".
  final String label;

  /// The date as text.
  final String main;

  /// A second line, e.g. the weekday.
  final String? detail;

  /// The day the picker opens on.
  final DateTime date;

  /// How the picker takes input.
  final MyanmarPickerInput inputMode;

  /// Called with the picked day.
  final ValueChanged<CompleteDate> onPicked;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final resolved = MyanmarCalendarScope.styleOf(context, style);
    final language = scope.language;
    final radius = BorderRadius.circular(
      resolved == MmVisualStyle.glass ? 18 : 12,
    );
    TextStyle ts(double size, Color c, [FontWeight? w]) => theme.textStyle(
      TextStyle(fontSize: size, color: c, fontWeight: w),
      language,
    );

    return MmPressable(
      semanticLabel: '$label: $main',
      borderRadius: radius,
      focusColor: theme.accent,
      onPressed: () async {
        final picked = await showMyanmarDatePicker(
          context: context,
          initialDate: date,
          inputMode: inputMode,
          style: style,
        );
        if (picked != null) onPicked(picked);
      },
      child: SizedBox(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: resolved == MmVisualStyle.glass
                ? theme.surface.withValues(alpha: 0.35)
                : theme.surfaceVariant,
            borderRadius: radius,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 10, 10),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(label, style: ts(12, theme.muted)),
                      Text(main, style: ts(17, theme.ink, FontWeight.w600)),
                      if (detail != null)
                        Text(detail!, style: ts(12.5, theme.muted)),
                    ],
                  ),
                ),
                Icon(
                  Icons.edit_calendar_outlined,
                  color: theme.muted,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
