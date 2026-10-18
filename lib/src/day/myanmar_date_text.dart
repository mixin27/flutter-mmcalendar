import 'package:flutter/material.dart';

import '../foundation/myanmar_calendar_scope.dart';
import 'day_builder.dart';

/// A date as text, formatted with the core library's patterns in the
/// scope's language.
///
/// ```dart
/// MyanmarDateText(day, pattern: '&y &M &P &ff')   // 1388 Thadingyut Waxing 07
/// MyanmarDateText.today(westernPattern: '%d %MMM') // updates at midnight
/// ```
///
/// [pattern] uses the Myanmar placeholders (`&y`, `&M`, `&P`, `&ff`, ...)
/// and [westernPattern] the Western ones (`%yyyy`, `%MMM`, `%d`, ...). With
/// both, they are joined with [separator]; with neither, the Myanmar
/// default is used.
class MyanmarDateText extends StatelessWidget {
  /// Formats [date].
  const MyanmarDateText(
    DateTime this.date, {
    super.key,
    this.pattern,
    this.westernPattern,
    this.separator = ' · ',
    this.style,
    this.textAlign,
    this.maxLines,
    this.clock,
  });

  /// Formats today and updates at midnight.
  const MyanmarDateText.today({
    super.key,
    this.pattern,
    this.westernPattern,
    this.separator = ' · ',
    this.style,
    this.textAlign,
    this.maxLines,
    this.clock,
  }) : date = null;

  /// The day; today when null.
  final DateTime? date;

  /// The Myanmar pattern.
  final String? pattern;

  /// The Western pattern.
  final String? westernPattern;

  /// Joins the two when both patterns are given.
  final String separator;

  /// The text style; the Myanmar font fallback is added.
  final TextStyle? style;

  /// How to align the text.
  final TextAlign? textAlign;

  /// The most lines to use.
  final int? maxLines;

  /// The current time, for tests.
  final DateTime Function()? clock;

  /// The text this widget shows for [day], for use outside a widget.
  static String format(
    MyanmarCalendarScopeData scope,
    DateTime day, {
    String? pattern,
    String? westernPattern,
    String separator = ' · ',
  }) {
    final complete = scope.day(day);
    final client = scope.client;
    final parts = [
      if (pattern != null || westernPattern == null)
        client.formatMyanmar(
          complete.myanmar,
          pattern: pattern,
          language: scope.language,
        ),
      if (westernPattern != null)
        client.formatWestern(
          complete.western,
          pattern: westernPattern,
          language: scope.language,
        ),
    ];
    return parts.join(separator);
  }

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    return DayBuilder(
      date: date,
      clock: clock,
      builder: (context, day, _) => Text(
        format(
          scope,
          westernDay(day),
          pattern: pattern,
          westernPattern: westernPattern,
          separator: separator,
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        style: theme.textStyle(
          DefaultTextStyle.of(context).style.merge(style),
          scope.language,
        ),
      ),
    );
  }
}
