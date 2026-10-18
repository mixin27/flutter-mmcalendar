import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_glass.dart';
import '../adaptive/mm_pressable.dart';
import '../calendars/myanmar_day_cell.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import '../foundation/myanmar_day_data.dart';
import 'myanmar_date_picker.dart';

/// A form field for a date. Once chosen it shows the Myanmar date and the
/// Western date under it; tapping opens [showMyanmarDatePicker].
///
/// It is an `InputDecorator` in Material, a bordered row in Cupertino and a
/// glass capsule in Glass, with the validator's message under it.
class MyanmarDateFormField extends FormField<CompleteDate> {
  /// Creates a date form field.
  MyanmarDateFormField({
    super.key,
    super.initialValue,
    super.onSaved,
    super.validator,
    super.enabled,
    super.autovalidateMode,
    this.label,
    this.hint,
    this.firstDate,
    this.lastDate,
    this.inputMode = MyanmarPickerInput.calendar,
    this.onChanged,
    this.style,
  }) : super(
         builder: (state) =>
             _FieldBody(state: state as _MyanmarDateFormFieldState),
       );

  /// The field's label.
  final String? label;

  /// Shown while no date is chosen.
  final String? hint;

  /// The earliest day the picker allows.
  final DateTime? firstDate;

  /// The latest day the picker allows.
  final DateTime? lastDate;

  /// How the picker starts taking input.
  final MyanmarPickerInput inputMode;

  /// Called with each date the user picks.
  final ValueChanged<CompleteDate>? onChanged;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  @override
  FormFieldState<CompleteDate> createState() => _MyanmarDateFormFieldState();
}

class _MyanmarDateFormFieldState extends FormFieldState<CompleteDate> {
  @override
  MyanmarDateFormField get widget => super.widget as MyanmarDateFormField;

  Future<void> pick() async {
    final value = this.value;
    final picked = await showMyanmarDatePicker(
      context: context,
      initialDate: value == null
          ? null
          : DateTime(
              value.western.year,
              value.western.month,
              value.western.day,
            ),
      firstDate: widget.firstDate,
      lastDate: widget.lastDate,
      inputMode: widget.inputMode,
      title: widget.label,
      style: widget.style,
    );
    if (picked == null || !mounted) return;
    didChange(picked);
    widget.onChanged?.call(picked);
  }
}

class _FieldBody extends StatelessWidget {
  const _FieldBody({required this.state});

  final _MyanmarDateFormFieldState state;

  @override
  Widget build(BuildContext context) {
    final field = state.widget;
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final style = MyanmarCalendarScope.styleOf(context, field.style);
    final strings = MmStrings.of(scope.language);
    final language = scope.language;
    final value = state.value;
    final enabled = field.enabled;
    final error = state.errorText;

    final western = value == null
        ? null
        : DateTime(value.western.year, value.western.month, value.western.day);
    final primary = value == null
        ? (field.hint ?? '')
        : '${language.digits(value.myanmar.year)} '
              '${strings.myanmarDate(value.myanmar)}';
    final secondary = western == null ? null : strings.westernDate(western);

    final texts = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          primary,
          style: theme.textStyle(
            TextStyle(
              color: value == null ? theme.muted : theme.ink,
              fontSize: 16,
              fontWeight: value == null ? FontWeight.w400 : FontWeight.w500,
            ),
            language,
          ),
        ),
        if (secondary != null)
          Text(
            secondary,
            style: theme.textStyle(
              TextStyle(color: theme.muted, fontSize: 13),
              language,
            ),
          ),
      ],
    );
    final icon = Icon(
      Icons.calendar_today_outlined,
      color: theme.muted,
      size: 20,
    );

    final label = [
      ?field.label,
      if (value != null)
        MyanmarDayCell.semanticLabel(
          MyanmarDayData(date: value, day: western!),
          language,
        ),
    ].join(', ');

    Widget box;
    switch (style) {
      case MmVisualStyle.material:
      case MmVisualStyle.automatic:
        return Semantics(
          button: true,
          enabled: enabled,
          label: label,
          excludeSemantics: true,
          onTap: enabled ? state.pick : null,
          child: InkWell(
            onTap: enabled ? state.pick : null,
            borderRadius: BorderRadius.circular(4),
            child: InputDecorator(
              isEmpty: value == null && field.hint == null,
              decoration: InputDecoration(
                labelText: field.label,
                errorText: error,
                filled: true,
                enabled: enabled,
                suffixIcon: icon,
              ),
              child: texts,
            ),
          ),
        );
      case MmVisualStyle.cupertino:
        box = DecoratedBox(
          decoration: BoxDecoration(
            color: theme.surface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: error != null ? theme.publicHoliday : theme.outline,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            child: Row(
              children: [
                Expanded(child: texts),
                icon,
              ],
            ),
          ),
        );
      case MmVisualStyle.glass:
        box = MmGlass(
          borderRadius: BorderRadius.circular(22),
          thickness: MmGlassThickness.clear,
          shadow: false,
          tint: error != null
              ? theme.publicHoliday.withValues(alpha: 0.12)
              : null,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
          child: Row(
            children: [
              Expanded(child: texts),
              icon,
            ],
          ),
        );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (field.label != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6),
            child: ExcludeSemantics(
              child: Text(
                field.label!,
                style: TextStyle(color: theme.muted, fontSize: 13),
              ),
            ),
          ),
        MmPressable(
          onPressed: enabled ? state.pick : null,
          semanticLabel: label,
          borderRadius: BorderRadius.circular(
            style == MmVisualStyle.glass ? 22 : 10,
          ),
          focusColor: theme.accent,
          child: SizedBox(width: double.infinity, child: box),
        ),
        if (error != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 6),
            child: Text(
              error,
              style: TextStyle(color: theme.publicHoliday, fontSize: 12.5),
            ),
          ),
      ],
    );
  }
}
