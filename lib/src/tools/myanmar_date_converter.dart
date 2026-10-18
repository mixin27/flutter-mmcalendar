import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_surface.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import '../pickers/myanmar_date_picker.dart';
import 'pickable_date_row.dart';

/// Converts between the Western and Myanmar calendars. Each side opens the
/// picker that suits it (the calendar for Western, the wheels for Myanmar);
/// the swap button puts the other calendar on top.
class MyanmarDateConverter extends StatefulWidget {
  /// Creates a converter starting on [initialDate] (default: today).
  const MyanmarDateConverter({
    super.key,
    this.initialDate,
    this.myanmarFirst = false,
    this.onChanged,
    this.title,
    this.style,
  });

  /// The day to start on.
  final DateTime? initialDate;

  /// Whether the Myanmar side starts on top.
  final bool myanmarFirst;

  /// Called with each day picked on either side.
  final ValueChanged<CompleteDate>? onChanged;

  /// A title over the card.
  final String? title;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  @override
  State<MyanmarDateConverter> createState() => _MyanmarDateConverterState();
}

class _MyanmarDateConverterState extends State<MyanmarDateConverter> {
  late DateTime _day = DateUtils.dateOnly(widget.initialDate ?? DateTime.now());
  late bool _myanmarFirst = widget.myanmarFirst;

  void _swap() => setState(() => _myanmarFirst = !_myanmarFirst);

  void _picked(CompleteDate d) {
    setState(
      () => _day = DateTime(d.western.year, d.western.month, d.western.day),
    );
    widget.onChanged?.call(d);
  }

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final strings = MmStrings.of(scope.language);
    final language = scope.language;
    final day = scope.day(_day);
    final m = day.myanmar;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    final western = PickableDateRow(
      key: const ValueKey('western'),
      label: strings.western,
      main: strings.westernDate(_day),
      detail: strings.weekdayName(_day.weekday),
      date: _day,
      onPicked: _picked,
      style: widget.style,
    );
    final myanmar = PickableDateRow(
      key: const ValueKey('myanmar'),
      label: strings.myanmar,
      main: '${language.digits(m.year)} ${strings.myanmarDate(m)}',
      detail:
          '${strings.sasanaYear} ${language.digits(m.sasanaYear)} · '
          '${strings.shanYear} ${language.digits(day.shan.year)}',
      date: _day,
      inputMode: MyanmarPickerInput.wheels,
      onPicked: _picked,
      style: widget.style,
    );
    final rows = _myanmarFirst ? [myanmar, western] : [western, myanmar];

    return MmSurface(
      style: widget.style,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.title != null) ...[
            Text(
              widget.title!,
              style: theme.textStyle(
                TextStyle(
                  color: theme.ink,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                language,
              ),
            ),
            const SizedBox(height: 10),
          ],
          AnimatedSwitcher(
            duration: reduceMotion
                ? Duration.zero
                : const Duration(milliseconds: 220),
            child: Column(
              key: ValueKey(_myanmarFirst),
              children: [
                rows[0],
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Center(
                    child: Tooltip(
                      message: strings.swap,
                      child: Semantics(
                        button: true,
                        label: strings.swap,
                        excludeSemantics: true,
                        onTap: _swap,
                        child: GestureDetector(
                          onTap: _swap,
                          child: AnimatedRotation(
                            turns: _myanmarFirst ? 0.5 : 0,
                            duration: reduceMotion
                                ? Duration.zero
                                : const Duration(milliseconds: 250),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: theme.accent,
                                shape: BoxShape.circle,
                              ),
                              child: SizedBox.square(
                                dimension: 36,
                                child: Icon(
                                  Icons.swap_vert,
                                  size: 20,
                                  color: theme.onAccent,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                rows[1],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
