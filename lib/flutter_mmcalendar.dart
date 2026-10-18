/// Flutter-first Myanmar calendar UI toolkit built on top of
/// `myanmar_calendar_dart`.
///
/// This package re-exports the core calculation API and adds composable Flutter
/// widgets such as:
///
/// - [MyanmarCalendarWidget] for month views
/// - [MyanmarDatePickerWidget] and modal pickers
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
export 'src/core/myanmar_calendar_theme.dart';
// 4.0 foundation: scope, theme, style, selection, controller.
export 'src/foundation/calendar_selection.dart';
export 'src/foundation/language_locale.dart';
export 'src/foundation/mm_calendar_theme_data.dart';
export 'src/foundation/mm_visual_style.dart';
export 'src/foundation/myanmar_calendar_controller.dart';
export 'src/foundation/myanmar_calendar_scope.dart';
export 'src/foundation/myanmar_day_data.dart';
export 'src/foundation/today_builder.dart';
// 3.x widgets and their theme (above), replaced step by step by 4.0 widgets.
export 'src/widgets/calendar_selection_mode.dart';
export 'src/widgets/horoscope_widget.dart';
export 'src/widgets/moon/daily_moon_phase_widget.dart';
export 'src/widgets/moon/moon_phase_painter.dart';
export 'src/widgets/moon/moon_phase_view.dart';
export 'src/widgets/myanmar_calendar_toolbar.dart';
export 'src/widgets/myanmar_calendar_widget.dart';
export 'src/widgets/myanmar_date_picker_form_field.dart';
export 'src/widgets/myanmar_date_picker_widget.dart';
export 'src/widgets/myanmar_date_summary_card.dart';
