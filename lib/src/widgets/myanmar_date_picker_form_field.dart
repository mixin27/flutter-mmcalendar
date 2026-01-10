import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../core/myanmar_calendar_theme.dart';
import 'myanmar_date_picker_widget.dart';

/// Compact Myanmar date picker widget for forms
class MyanmarDatePickerFormField extends StatefulWidget {
  /// Form field label
  final String? labelText;

  /// Hint text when no date is selected
  final String? hintText;

  /// Current selected date
  final MyanmarDateTime? value;

  /// Callback when date changes
  final void Function(MyanmarDateTime?)? onChanged;

  /// Callback to save form field value
  final void Function(MyanmarDateTime?)? onSaved;

  /// Validation function
  final String? Function(MyanmarDateTime?)? validator;

  /// Minimum selectable date
  final MyanmarDateTime? firstDate;

  /// Maximum selectable date
  final MyanmarDateTime? lastDate;

  /// Language for display
  final Language language;

  /// Whether the field is enabled
  final bool enabled;

  /// Whether to show Western dates
  final bool showWesternDates;

  /// Whether to show holidays
  final bool showHolidays;

  /// Date picker dialog title
  final String? pickerTitle;

  /// Custom input decoration
  final InputDecoration? decoration;

  /// Custom theme for date picker
  final MyanmarCalendarTheme? theme;

  /// Create a new myanmar date picker form field
  const MyanmarDatePickerFormField({
    super.key,
    this.labelText,
    this.hintText,
    this.value,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.firstDate,
    this.lastDate,
    this.language = Language.myanmar,
    this.enabled = true,
    this.showWesternDates = true,
    this.showHolidays = false,
    this.pickerTitle,
    this.decoration,
    this.theme,
  });

  @override
  State<MyanmarDatePickerFormField> createState() =>
      _MyanmarDatePickerFormFieldState();
}

class _MyanmarDatePickerFormFieldState
    extends State<MyanmarDatePickerFormField> {
  MyanmarDateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.value;
  }

  @override
  void didUpdateWidget(MyanmarDatePickerFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _selectedDate = widget.value;
    }
  }

  Future<void> _showDatePicker() async {
    if (!widget.enabled) return;

    final result = await showMyanmarDatePicker(
      context: context,
      initialDate: _selectedDate?.toDateTime(),
      firstDate: widget.firstDate?.toDateTime(),
      lastDate: widget.lastDate?.toDateTime(),
      language: widget.language,
      helpText: widget.pickerTitle,
      showWesternDates: widget.showWesternDates,
      showHolidays: widget.showHolidays,
      theme: widget.theme,
    );

    if (result != null) {
      setState(() {
        _selectedDate = MyanmarDateTime.fromMyanmarDate(result.myanmar);
      });
      widget.onChanged?.call(_selectedDate);
    }
  }

  String _getDisplayText() {
    if (_selectedDate == null) {
      return widget.hintText ?? _getLocalizedHint();
    }

    final myanmarText = _selectedDate!.formatMyanmar(null, widget.language);
    if (widget.showWesternDates) {
      final westernText = _selectedDate!.formatWestern(
        '%MMM %dd, %yyyy',
        widget.language,
      );
      return '$myanmarText ($westernText)';
    }
    return myanmarText;
  }

  String _getLocalizedHint() {
    switch (widget.language) {
      case Language.myanmar:
        return 'ရက်စွဲရွေးချယ်ပါ';
      case Language.mon:
        return 'ရုဲစုတ် တ္ၚဲ';
      case Language.karen:
        return 'နံၣ်ထဲးကလးဒ်';
      case Language.shan:
        return 'လိၵ်ႈထၢႆး ဝၼ်း';
      default:
        return 'Select date';
    }
  }

  @override
  Widget build(BuildContext context) {
    final effectiveDecoration =
        widget.decoration ??
        InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText ?? _getLocalizedHint(),
          suffixIcon: const Icon(Icons.calendar_today),
        );

    return FormField<MyanmarDateTime>(
      initialValue: _selectedDate,
      onSaved: widget.onSaved,
      validator: widget.validator,
      builder: (FormFieldState<MyanmarDateTime> field) {
        return InputDecorator(
          decoration: effectiveDecoration.copyWith(errorText: field.errorText),
          isEmpty: _selectedDate == null,
          child: InkWell(
            onTap: widget.enabled ? _showDatePicker : null,
            child: Container(
              constraints: const BoxConstraints(minHeight: 48),
              alignment: Alignment.centerLeft,
              child: Text(
                _getDisplayText(),
                style: TextStyle(
                  color: _selectedDate == null
                      ? Theme.of(context).hintColor
                      : null,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Simple Myanmar date input field
class MyanmarDateField extends StatelessWidget {
  /// Current date value
  final MyanmarDateTime? value;

  /// Callback when date changes
  final void Function(MyanmarDateTime?) onChanged;

  /// Input decoration
  final InputDecoration? decoration;

  /// Whether the field is enabled
  final bool enabled;

  /// Language for display
  final Language language;

  /// Whether to show Western dates
  final bool showWesternDates;

  /// Minimum selectable date
  final MyanmarDateTime? firstDate;

  /// Maximum selectable date
  final MyanmarDateTime? lastDate;

  /// Custom theme for date picker
  final MyanmarCalendarTheme? theme;

  /// Create a myanmar date field
  const MyanmarDateField({
    super.key,
    required this.value,
    required this.onChanged,
    this.decoration,
    this.enabled = true,
    this.language = Language.myanmar,
    this.showWesternDates = true,
    this.firstDate,
    this.lastDate,
    this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      enabled: enabled,
      decoration: (decoration ?? const InputDecoration()).copyWith(
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      controller: TextEditingController(
        text: value?.formatMyanmar(null, language) ?? '',
      ),
      onTap: enabled
          ? () async {
              final result = await showMyanmarDatePicker(
                context: context,
                initialDate: value?.toDateTime(),
                firstDate: firstDate?.toDateTime(),
                lastDate: lastDate?.toDateTime(),
                language: language,
                showWesternDates: showWesternDates,
                theme: theme,
              );
              if (result != null) {
                onChanged(MyanmarDateTime.fromMyanmarDate(result.myanmar));
              }
            }
          : null,
    );
  }
}
