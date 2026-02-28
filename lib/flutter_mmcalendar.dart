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

// Re-export upstream package.
export 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

// Compatibility re-exports for APIs no longer exported at top-level in
// myanmar_calendar_dart 2.x.
export 'package:myanmar_calendar_dart/src/services/date_converter.dart';
export 'package:myanmar_calendar_dart/src/services/myanmar_calendar_service.dart';
export 'package:myanmar_calendar_dart/src/utils/astro_details.dart';

// ============================================================================
// CORE EXPORTS
// ============================================================================

// Configuration
export 'src/core/myanmar_calendar_theme.dart';
// Utils
export 'src/utils/accessibility_utils.dart';
export 'src/utils/package_constants.dart';
// Performance and Accessibility
export 'src/utils/performance_utils.dart';
// Widgets
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
export 'src/widgets/optimized_calendar_cell.dart';
