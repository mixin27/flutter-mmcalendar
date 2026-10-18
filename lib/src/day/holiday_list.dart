import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../adaptive/mm_list.dart';
import '../calendars/calendar_layout.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import '../foundation/today_builder.dart';

/// One holiday on one day, as listed by [HolidayList].
@immutable
class HolidayOccurrence {
  /// Creates an occurrence.
  const HolidayOccurrence({required this.day, required this.holiday});

  /// The day it falls on, with its Myanmar date.
  final CompleteDate day;

  /// The holiday.
  final Holiday holiday;

  /// The Western day, date-only.
  DateTime get date =>
      DateTime(day.western.year, day.western.month, day.western.day);
}

/// The holidays coming up from a day, each with its date, its Myanmar date
/// and how many days away it is.
class HolidayList extends StatelessWidget {
  /// Lists holidays in the [days] days from [from] (default: today).
  const HolidayList.upcoming({
    super.key,
    this.from,
    this.days = 60,
    this.limit,
    this.types = const {
      HolidayType.public,
      HolidayType.religious,
      HolidayType.cultural,
    },
    this.includeCustom = true,
    this.header,
    this.onHolidayTapped,
    this.style,
    this.clock,
  });

  /// The first day to look at; today when null.
  final DateTime? from;

  /// How many days ahead to look.
  final int days;

  /// The most holidays to list.
  final int? limit;

  /// Which holiday types to list.
  final Set<HolidayType> types;

  /// Whether to list custom holidays whatever their type.
  final bool includeCustom;

  /// The list's title; "Upcoming holidays" when null, none when empty.
  final String? header;

  /// Called with a tapped holiday.
  final ValueChanged<HolidayOccurrence>? onHolidayTapped;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  /// The current time, for tests.
  final DateTime Function()? clock;

  /// The holidays [HolidayList.upcoming] would list.
  static List<HolidayOccurrence> find(
    MyanmarCalendarScopeData scope, {
    required DateTime from,
    required int days,
    required Set<HolidayType> types,
    bool includeCustom = true,
    int? limit,
  }) {
    final out = <HolidayOccurrence>[];
    var d = DateUtils.dateOnly(from);
    for (var i = 0; i < days; i++, d = CalendarLayout.addDays(d, 1)) {
      final day = scope.day(d);
      for (final h in day.holidays.entries) {
        if (types.contains(h.type) || (includeCustom && h.isCustom)) {
          out.add(HolidayOccurrence(day: day, holiday: h));
          if (limit != null && out.length >= limit) return out;
        }
      }
    }
    return out;
  }

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final strings = MmStrings.of(scope.language);
    final language = scope.language;
    TextStyle ts(double size, Color c, [FontWeight? w]) => theme
        .textStyle(TextStyle(fontSize: size, color: c, fontWeight: w), language)
        .copyWith(height: theme.lineHeight(language, 1.15));

    return TodayBuilder(
      clock: clock,
      builder: (context, today) {
        final start = from ?? today;
        final items = find(
          scope,
          from: start,
          days: days,
          types: types,
          includeCustom: includeCustom,
          limit: limit,
        );
        final title = header ?? strings.upcomingHolidays;
        return MmListGroup(
          header: title.isEmpty ? null : title,
          style: style,
          children: [
            if (items.isEmpty)
              MmListRow(
                title: Text(
                  strings.noHolidays,
                  style: TextStyle(color: theme.muted),
                ),
                style: style,
              ),
            for (final item in items)
              () {
                final away =
                    DateTime.utc(item.date.year, item.date.month, item.date.day)
                        .difference(
                          DateTime.utc(start.year, start.month, start.day),
                        )
                        .inDays;
                return MmListRow(
                  leading: SizedBox(
                    width: 40,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            language.digits(item.date.day),
                            style: ts(
                              19,
                              item.holiday.isCustom
                                  ? theme.accent
                                  : theme.holidayColor(item.holiday.type),
                              FontWeight.w700,
                            ),
                          ),
                          Text(
                            TranslationService.getShortWesternMonthName(
                              item.date.month,
                              language,
                            ),
                            maxLines: 1,
                            style: ts(11, theme.muted),
                          ),
                        ],
                      ),
                    ),
                  ),
                  title: Text(item.holiday.name),
                  subtitle: Text(strings.myanmarDate(item.day.myanmar)),
                  trailing: Text(
                    strings.daysUntil(away),
                    style: ts(12.5, theme.muted, FontWeight.w500),
                  ),
                  onTap: onHolidayTapped == null
                      ? null
                      : () => onHolidayTapped!(item),
                  style: style,
                );
              }(),
          ],
        );
      },
    );
  }
}
