/// Myanmar calendar widgets for Flutter, built on `myanmar_calendar_dart`.
///
/// Every widget renders as Material 3, Cupertino or Liquid Glass
/// ([MmVisualStyle]) and reads its client, language and theme from a
/// [MyanmarCalendarScope]:
///
/// - calendars: [MyanmarMonthCalendar], [MyanmarWeekStrip],
///   [MyanmarYearCalendar], [MyanmarLunarMonthCalendar], [MyanmarAgenda]
/// - pickers: [showMyanmarDatePicker], [showMyanmarDateRangePicker],
///   [MyanmarDateWheelPicker], [MyanmarDateFormField]
/// - day information: [MyanmarTodayCard], [MyanmarDayDetails],
///   [HolidayList], [AstrologyCard], [MoonGlyph], [NextMoonCountdown]
/// - tools: [MyanmarDateConverter], [DateDifferenceCard], [AIPromptAction],
///   [ChronicleCard]
///
/// The core library is re-exported, so one import gives both.
library;

// The core library, and its AI prompt library (a separate import in
// myanmar_calendar_dart 3).
export 'package:myanmar_calendar_dart/ai.dart';
export 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

// Adaptive primitives: Material, Cupertino and Glass.
export 'src/adaptive/mm_buttons.dart';
export 'src/adaptive/mm_chip.dart';
export 'src/adaptive/mm_glass.dart';
export 'src/adaptive/mm_list.dart';
export 'src/adaptive/mm_overlays.dart';
export 'src/adaptive/mm_pressable.dart';
export 'src/adaptive/mm_segmented.dart';
export 'src/adaptive/mm_surface.dart';
// Calendars.
export 'src/calendars/calendar_layout.dart' show CalendarLayout;
export 'src/calendars/myanmar_agenda.dart';
export 'src/calendars/myanmar_calendar_header.dart';
export 'src/calendars/myanmar_day_cell.dart';
export 'src/calendars/myanmar_lunar_month_calendar.dart';
export 'src/calendars/myanmar_mini_month.dart';
export 'src/calendars/myanmar_month_calendar.dart';
export 'src/calendars/myanmar_week_strip.dart';
export 'src/calendars/myanmar_year_calendar.dart';
// Day information.
export 'src/day/astrology_card.dart';
export 'src/day/day_badges.dart';
export 'src/day/holiday_list.dart';
export 'src/day/myanmar_date_text.dart';
export 'src/day/myanmar_day_details.dart';
export 'src/day/myanmar_today_card.dart';
// Foundation: scope, theme, style, selection, controller.
export 'src/foundation/calendar_selection.dart';
export 'src/foundation/language_locale.dart';
export 'src/foundation/mm_calendar_theme_data.dart';
export 'src/foundation/mm_strings.dart';
export 'src/foundation/mm_visual_style.dart';
export 'src/foundation/myanmar_calendar_controller.dart';
export 'src/foundation/myanmar_calendar_scope.dart';
export 'src/foundation/myanmar_day_data.dart';
export 'src/foundation/today_builder.dart';
// Moon.
export 'src/moon/moon_glyph.dart';
export 'src/moon/moon_phase_strip.dart';
export 'src/moon/next_moon_countdown.dart';
// Pickers.
export 'src/pickers/myanmar_date_form_field.dart';
export 'src/pickers/myanmar_date_picker.dart';
export 'src/pickers/myanmar_date_wheel_picker.dart';
export 'src/pickers/myanmar_month_year_picker.dart';
// Tools.
export 'src/tools/ai_prompt_action.dart';
export 'src/tools/chronicle_card.dart';
export 'src/tools/date_difference_card.dart';
export 'src/tools/myanmar_date_converter.dart';
