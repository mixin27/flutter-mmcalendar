/// Flutter-first Myanmar calendar UI toolkit built on top of
/// `myanmar_calendar_dart`.
///
/// This package re-exports the core calculation API and adds composable Flutter
/// widgets such as:
///
/// - [MyanmarCalendarWidget] for month views
/// - [MyanmarDatePicker], [showMyanmarDatePicker] and the range picker
/// - [HoroscopeWidget] and summary cards
/// - CustomPainter-based moon phase widgets
///
/// The package targets responsive mobile/desktop layouts, accessibility, and
/// production-ready customization via [MyanmarCalendarTheme].
library;

// The core library, and its AI prompt library (a separate import in
// myanmar_calendar_dart 3).
export 'package:myanmar_calendar_dart/ai.dart';
export 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

// 4.0 adaptive primitives: Material, Cupertino and Glass.
export 'src/adaptive/mm_buttons.dart';
export 'src/adaptive/mm_chip.dart';
export 'src/adaptive/mm_glass.dart';
export 'src/adaptive/mm_list.dart';
export 'src/adaptive/mm_overlays.dart';
export 'src/adaptive/mm_pressable.dart';
export 'src/adaptive/mm_segmented.dart';
export 'src/adaptive/mm_surface.dart';
// 4.0 calendars.
export 'src/calendars/calendar_layout.dart' show CalendarLayout;
export 'src/calendars/myanmar_agenda.dart';
export 'src/calendars/myanmar_calendar_header.dart';
export 'src/calendars/myanmar_day_cell.dart';
export 'src/calendars/myanmar_lunar_month_calendar.dart';
export 'src/calendars/myanmar_mini_month.dart';
export 'src/calendars/myanmar_month_calendar.dart';
export 'src/calendars/myanmar_week_strip.dart';
export 'src/calendars/myanmar_year_calendar.dart';
export 'src/core/myanmar_calendar_theme.dart';
// 4.0 foundation: scope, theme, style, selection, controller.
// 4.0 day information.
export 'src/day/astrology_card.dart';
export 'src/day/day_badges.dart';
export 'src/day/holiday_list.dart';
export 'src/day/myanmar_date_text.dart';
export 'src/day/myanmar_day_details.dart';
export 'src/day/myanmar_today_card.dart';
export 'src/foundation/calendar_selection.dart';
export 'src/foundation/language_locale.dart';
export 'src/foundation/mm_calendar_theme_data.dart';
export 'src/foundation/mm_strings.dart';
export 'src/foundation/mm_visual_style.dart';
export 'src/foundation/myanmar_calendar_controller.dart';
export 'src/foundation/myanmar_calendar_scope.dart';
export 'src/foundation/myanmar_day_data.dart';
export 'src/foundation/today_builder.dart';
// 3.x widgets and their theme (above), replaced step by step by 4.0 widgets.
export 'src/moon/moon_glyph.dart';
export 'src/moon/moon_phase_strip.dart';
export 'src/moon/next_moon_countdown.dart';
// 4.0 pickers.
export 'src/pickers/myanmar_date_form_field.dart';
export 'src/pickers/myanmar_date_picker.dart';
export 'src/pickers/myanmar_date_wheel_picker.dart';
export 'src/pickers/myanmar_month_year_picker.dart';
export 'src/widgets/calendar_selection_mode.dart';
export 'src/widgets/horoscope_widget.dart';
export 'src/widgets/moon/daily_moon_phase_widget.dart';
export 'src/widgets/moon/moon_phase_painter.dart';
export 'src/widgets/moon/moon_phase_view.dart';
export 'src/widgets/myanmar_calendar_toolbar.dart';
export 'src/widgets/myanmar_calendar_widget.dart';
export 'src/widgets/myanmar_date_summary_card.dart';
