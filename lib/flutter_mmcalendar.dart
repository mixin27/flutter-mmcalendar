/// Myanmar Calendar Package
///
/// A comprehensive Flutter package for Myanmar calendar with date conversions,
/// astrological calculations, holiday information, and multi-language support.
///
/// Author: Kyaw Zayar Tun
/// Website: https://www.kyawzayartun.com
/// GitHub:  https://github.com/mixin27/flutter-mmcalendar
/// License: MIT
///
/// ## Features
///
/// - **Date Conversions**: Bidirectional conversion between Myanmar and Western calendars
/// - **Astrological Information**: Complete astrological calculations including watat years, moon phases
/// - **Holiday Calculations**: Myanmar holidays, religious days, cultural celebrations
/// - **Multi-language Support**: Myanmar (Unicode), Myanmar (Zawgyi), Mon, Shan, Karen, English
/// - **Formatting Services**: Flexible date formatting with localization
/// - **UI Widgets**: Ready-to-use calendar widgets and date pickers
/// - **Validation**: Comprehensive date validation with detailed error messages
/// - **Utilities**: Helper functions for date calculations and manipulations
///
/// ## Quick Start
///
/// ```dart
/// import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
///
/// // Get today's Myanmar date
/// final today = MyanmarCalendar.today();
/// print('Today: ${today.formatMyanmar()}');
///
/// // Convert dates
/// final myanmarDate = MyanmarCalendar.fromWestern(2024, 1, 1);
/// final westernDate = MyanmarCalendar.fromMyanmar(1385, 10, 1);
///
/// // Get complete date information
/// final completeDate = MyanmarCalendar.getCompleteDate(DateTime.now());
/// print('Holidays: ${completeDate.allHolidays}');
/// print('Astrological days: ${completeDate.astrologicalDays}');
/// ```
///
/// ## Widgets
///
/// ```dart
/// // Myanmar Calendar Widget
/// MyanmarCalendarWidget(
///   onDateSelected: (date) => print('Selected: $date'),
///   initialDate: DateTime.now(),
///   language: Language.myanmar,
/// )
///
/// // Myanmar Date Picker
/// final date = await showMyanmarDatePicker(
///   context: context,
///   initialDate: DateTime.now(),
///   language: Language.english,
/// );
/// ```
///
/// For detailed documentation and examples, visit: https://pub.dev/packages/flutter_mmcalendar
library;

// Re-export myanmar_calendar_dart
export 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart'
    hide PackageConstants;

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
export 'src/widgets/moon/daily_moon_phase.dart';
export 'src/widgets/moon/moon_phase_indicator.dart';
export 'src/widgets/moon/optimized_moon_phase.dart';
export 'src/widgets/myanmar_calendar_widget.dart';
export 'src/widgets/myanmar_date_picker_widget.dart';
export 'src/widgets/optimized_calendar_cell.dart';
