// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../core/myanmar_calendar_theme.dart';
import 'internal/calendar_localization_utils.dart';
import 'myanmar_date_picker_widget.dart';

class MyanmarDatePickerFormField extends StatefulWidget {
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

  final String? labelText;
  final String? hintText;
  final MyanmarDateTime? value;
  final void Function(MyanmarDateTime?)? onChanged;
  final void Function(MyanmarDateTime?)? onSaved;
  final String? Function(MyanmarDateTime?)? validator;
  final MyanmarDateTime? firstDate;
  final MyanmarDateTime? lastDate;
  final Language language;
  final bool enabled;
  final bool showWesternDates;
  final bool showHolidays;
  final String? pickerTitle;
  final InputDecoration? decoration;
  final MyanmarCalendarTheme? theme;

  @override
  State<MyanmarDatePickerFormField> createState() =>
      _MyanmarDatePickerFormFieldState();
}

class _MyanmarDatePickerFormFieldState
    extends State<MyanmarDatePickerFormField> {
  MyanmarDateTime? _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.value;
  }

  @override
  void didUpdateWidget(covariant MyanmarDatePickerFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      _selected = widget.value;
    }
  }

  Future<void> _openPicker(FormFieldState<MyanmarDateTime> field) async {
    if (!widget.enabled) {
      return;
    }

    final selected = await showMyanmarDatePicker(
      context: context,
      initialDate: _selected?.toDateTime(),
      firstDate: widget.firstDate?.toDateTime(),
      lastDate: widget.lastDate?.toDateTime(),
      language: widget.language,
      helpText: widget.pickerTitle,
      showWesternDates: widget.showWesternDates,
      showHolidays: widget.showHolidays,
      theme: widget.theme,
    );

    if (!mounted || selected == null) {
      return;
    }

    final value = MyanmarDateTime.fromMyanmarDate(selected.myanmar);
    setState(() {
      _selected = value;
    });
    field.didChange(value);
    widget.onChanged?.call(value);
  }

  String _displayText() {
    if (_selected == null) {
      return widget.hintText ??
          CalendarLocalizationUtils.selectDate(widget.language);
    }

    final mm = _selected!.formatMyanmar(null, widget.language);
    if (!widget.showWesternDates) {
      return mm;
    }

    final western = _selected!.formatWestern(
      '%MMM %dd, %yyyy',
      widget.language,
    );
    return '$mm  ·  $western';
  }

  @override
  Widget build(BuildContext context) {
    final decoration =
        widget.decoration ??
        InputDecoration(
          labelText: widget.labelText,
          hintText: widget.hintText,
          suffixIcon: const Icon(Icons.calendar_month),
        );

    return FormField<MyanmarDateTime>(
      initialValue: _selected,
      validator: widget.validator,
      onSaved: widget.onSaved,
      builder: (FormFieldState<MyanmarDateTime> field) {
        return InputDecorator(
          decoration: decoration.copyWith(errorText: field.errorText),
          isEmpty: _selected == null,
          child: InkWell(
            onTap: () => _openPicker(field),
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                _displayText(),
                style: TextStyle(
                  color: _selected == null
                      ? Theme.of(context).hintColor
                      : Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MyanmarDateField extends StatelessWidget {
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

  final MyanmarDateTime? value;
  final void Function(MyanmarDateTime?) onChanged;
  final InputDecoration? decoration;
  final bool enabled;
  final Language language;
  final bool showWesternDates;
  final MyanmarDateTime? firstDate;
  final MyanmarDateTime? lastDate;
  final MyanmarCalendarTheme? theme;

  @override
  Widget build(BuildContext context) {
    final text = value == null
        ? ''
        : value!.formatComplete(
            myanmarPattern: '&y &M &P &ff',
            westernPattern: '%MMM %dd, %yyyy',
            language: language,
          );

    return TextFormField(
      readOnly: true,
      enabled: enabled,
      controller: TextEditingController(text: text),
      decoration: (decoration ?? const InputDecoration()).copyWith(
        suffixIcon: const Icon(Icons.calendar_month),
      ),
      onTap: !enabled
          ? null
          : () async {
              final selected = await showMyanmarDatePicker(
                context: context,
                initialDate: value?.toDateTime(),
                firstDate: firstDate?.toDateTime(),
                lastDate: lastDate?.toDateTime(),
                language: language,
                showWesternDates: showWesternDates,
                theme: theme,
              );

              if (selected != null) {
                onChanged(MyanmarDateTime.fromMyanmarDate(selected.myanmar));
              }
            },
    );
  }
}
