import 'package:flutter/material.dart';

/// Theme for the Myanmar calendar
class MyanmarCalendarTheme {
  /// Background color
  final Color backgroundColor;

  /// Border color
  final Color borderColor;

  /// Border width
  final double borderWidth;

  /// Border radius
  final double borderRadius;

  /// Elevation
  final double elevation;

  // Header styling

  /// Header background color
  final Color headerBackgroundColor;

  /// Header text color
  final Color headerTextColor;

  /// Header text style
  final TextStyle headerTextStyle;

  /// Header subtitle style
  final TextStyle? headerSubtitleStyle;

  /// Header padding
  final EdgeInsets headerPadding;

  /// Header icon size
  final double headerIconSize;

  // Weekday header styling

  /// Weekday header background color
  final Color weekdayHeaderBackgroundColor;

  /// Weekday header text color
  final Color weekdayHeaderTextColor;

  /// Weekday header text style
  final TextStyle weekdayHeaderTextStyle;

  /// Weekday header padding
  final EdgeInsets weekdayHeaderPadding;

  // Calendar grid styling

  /// Calendar padding
  final EdgeInsets calendarPadding;

  /// Date cell margin
  final EdgeInsets dateCellMargin;

  /// Date cell border radius
  final double dateCellBorderRadius;

  // Date cell styling

  /// Date cell background color
  final Color dateCellBackgroundColor;

  /// Date cell text color
  final Color dateCellTextColor;

  /// Date cell text style
  final TextStyle dateCellTextStyle;

  /// Date cell secondary text style
  final TextStyle? dateCellSecondaryTextStyle;

  // Today styling

  /// Today background color
  final Color todayBackgroundColor;

  /// Today text color
  final Color todayTextColor;

  /// Today border color
  final Color? todayBorderColor;

  // Selected date styling

  /// Selected date background color
  final Color selectedDateBackgroundColor;

  /// Selected date text color
  final Color selectedDateTextColor;

  /// Selected date border color
  final Color? selectedDateBorderColor;

  // Disabled date styling

  /// Disabled date background color
  final Color disabledDateBackgroundColor;

  /// Disabled date text color
  final Color disabledDateTextColor;

  // Special day styling

  /// Sabbath background color
  final Color sabbathBackgroundColor;

  /// Sabbath text color
  final Color sabbathTextColor;

  /// Full moon background color
  final Color fullMoonBackgroundColor;

  /// Full moon text color
  final Color fullMoonTextColor;

  /// New moon background color
  final Color newMoonBackgroundColor;

  /// New moon text color
  final Color newMoonTextColor;

  // Indicator colors

  /// Holiday indicator color
  final Color holidayIndicatorColor;

  /// Astro indicator color
  final Color astroIndicatorColor;

  /// Create a new theme
  const MyanmarCalendarTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.elevation,
    required this.headerBackgroundColor,
    required this.headerTextColor,
    required this.headerTextStyle,
    this.headerSubtitleStyle,
    required this.headerPadding,
    required this.headerIconSize,
    required this.weekdayHeaderBackgroundColor,
    required this.weekdayHeaderTextColor,
    required this.weekdayHeaderTextStyle,
    required this.weekdayHeaderPadding,
    required this.calendarPadding,
    required this.dateCellMargin,
    required this.dateCellBorderRadius,
    required this.dateCellBackgroundColor,
    required this.dateCellTextColor,
    required this.dateCellTextStyle,
    this.dateCellSecondaryTextStyle,
    required this.todayBackgroundColor,
    required this.todayTextColor,
    this.todayBorderColor,
    required this.selectedDateBackgroundColor,
    required this.selectedDateTextColor,
    this.selectedDateBorderColor,
    required this.disabledDateBackgroundColor,
    required this.disabledDateTextColor,
    required this.sabbathBackgroundColor,
    required this.sabbathTextColor,
    required this.fullMoonBackgroundColor,
    required this.fullMoonTextColor,
    required this.newMoonBackgroundColor,
    required this.newMoonTextColor,
    required this.holidayIndicatorColor,
    required this.astroIndicatorColor,
  });

  /// Default light theme
  factory MyanmarCalendarTheme.defaultTheme() {
    return MyanmarCalendarTheme(
      backgroundColor: Colors.white,
      borderColor: Colors.grey.shade300,
      borderWidth: 1.0,
      borderRadius: 8.0,
      elevation: 2.0,
      headerBackgroundColor: Colors.blue.shade600,
      headerTextColor: Colors.white,
      headerTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      headerSubtitleStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      headerPadding: const EdgeInsets.all(12.0),
      headerIconSize: 24.0,
      weekdayHeaderBackgroundColor: Colors.grey.shade100,
      weekdayHeaderTextColor: Colors.grey.shade700,
      weekdayHeaderTextStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      weekdayHeaderPadding: const EdgeInsets.symmetric(vertical: 8.0),
      calendarPadding: const EdgeInsets.all(8.0),
      dateCellMargin: const EdgeInsets.all(2.0),
      dateCellBorderRadius: 4.0,
      dateCellBackgroundColor: Colors.transparent,
      dateCellTextColor: Colors.black87,
      dateCellTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      dateCellSecondaryTextStyle: const TextStyle(fontSize: 10),
      todayBackgroundColor: Colors.blue.shade100,
      todayTextColor: Colors.blue.shade800,
      todayBorderColor: Colors.blue.shade400,
      selectedDateBackgroundColor: Colors.blue.shade600,
      selectedDateTextColor: Colors.white,
      selectedDateBorderColor: Colors.blue.shade800,
      disabledDateBackgroundColor: Colors.grey.shade100,
      disabledDateTextColor: Colors.grey.shade400,
      sabbathBackgroundColor: Colors.orange.shade100,
      sabbathTextColor: Colors.orange.shade800,
      fullMoonBackgroundColor: Colors.amber.shade100,
      fullMoonTextColor: Colors.amber.shade800,
      newMoonBackgroundColor: Colors.indigo.shade100,
      newMoonTextColor: Colors.indigo.shade800,
      holidayIndicatorColor: Colors.red.shade500,
      astroIndicatorColor: Colors.purple.shade500,
    );
  }

  /// Dark theme variant
  factory MyanmarCalendarTheme.darkTheme() {
    return MyanmarCalendarTheme(
      backgroundColor: Colors.grey.shade900,
      borderColor: Colors.grey.shade700,
      borderWidth: 1.0,
      borderRadius: 8.0,
      elevation: 4.0,
      headerBackgroundColor: Colors.blue.shade800,
      headerTextColor: Colors.white,
      headerTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      headerSubtitleStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      headerPadding: const EdgeInsets.all(12.0),
      headerIconSize: 24.0,
      weekdayHeaderBackgroundColor: Colors.grey.shade800,
      weekdayHeaderTextColor: Colors.grey.shade300,
      weekdayHeaderTextStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      weekdayHeaderPadding: const EdgeInsets.symmetric(vertical: 8.0),
      calendarPadding: const EdgeInsets.all(8.0),
      dateCellMargin: const EdgeInsets.all(2.0),
      dateCellBorderRadius: 4.0,
      dateCellBackgroundColor: Colors.transparent,
      dateCellTextColor: Colors.white70,
      dateCellTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      dateCellSecondaryTextStyle: const TextStyle(fontSize: 10),
      todayBackgroundColor: Colors.blue.shade700,
      todayTextColor: Colors.white,
      todayBorderColor: Colors.blue.shade400,
      selectedDateBackgroundColor: Colors.blue.shade600,
      selectedDateTextColor: Colors.white,
      selectedDateBorderColor: Colors.blue.shade400,
      disabledDateBackgroundColor: Colors.grey.shade800,
      disabledDateTextColor: Colors.grey.shade600,
      sabbathBackgroundColor: Colors.orange.shade800,
      sabbathTextColor: Colors.orange.shade100,
      fullMoonBackgroundColor: Colors.amber.shade800,
      fullMoonTextColor: Colors.amber.shade100,
      newMoonBackgroundColor: Colors.indigo.shade800,
      newMoonTextColor: Colors.indigo.shade100,
      holidayIndicatorColor: Colors.red.shade400,
      astroIndicatorColor: Colors.purple.shade400,
    );
  }

  /// Create a custom theme based on primary color
  factory MyanmarCalendarTheme.fromColor(
    Color primaryColor, {
    bool isDark = false,
  }) {
    final base = isDark
        ? MyanmarCalendarTheme.darkTheme()
        : MyanmarCalendarTheme.defaultTheme();

    return base.copyWith(
      headerBackgroundColor: primaryColor,
      todayBackgroundColor: primaryColor.withValues(alpha: 0.2),
      todayBorderColor: primaryColor,
      selectedDateBackgroundColor: primaryColor,
      selectedDateBorderColor: primaryColor.withValues(alpha: 0.8),
    );
  }

  /// Copy theme with modifications
  MyanmarCalendarTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    double? elevation,
    Color? headerBackgroundColor,
    Color? headerTextColor,
    TextStyle? headerTextStyle,
    TextStyle? headerSubtitleStyle,
    EdgeInsets? headerPadding,
    double? headerIconSize,
    Color? weekdayHeaderBackgroundColor,
    Color? weekdayHeaderTextColor,
    TextStyle? weekdayHeaderTextStyle,
    EdgeInsets? weekdayHeaderPadding,
    EdgeInsets? calendarPadding,
    EdgeInsets? dateCellMargin,
    double? dateCellBorderRadius,
    Color? dateCellBackgroundColor,
    Color? dateCellTextColor,
    TextStyle? dateCellTextStyle,
    TextStyle? dateCellSecondaryTextStyle,
    Color? todayBackgroundColor,
    Color? todayTextColor,
    Color? todayBorderColor,
    Color? selectedDateBackgroundColor,
    Color? selectedDateTextColor,
    Color? selectedDateBorderColor,
    Color? disabledDateBackgroundColor,
    Color? disabledDateTextColor,
    Color? sabbathBackgroundColor,
    Color? sabbathTextColor,
    Color? fullMoonBackgroundColor,
    Color? fullMoonTextColor,
    Color? newMoonBackgroundColor,
    Color? newMoonTextColor,
    Color? holidayIndicatorColor,
    Color? astroIndicatorColor,
  }) {
    return MyanmarCalendarTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      headerBackgroundColor:
          headerBackgroundColor ?? this.headerBackgroundColor,
      headerTextColor: headerTextColor ?? this.headerTextColor,
      headerTextStyle: headerTextStyle ?? this.headerTextStyle,
      headerSubtitleStyle: headerSubtitleStyle ?? this.headerSubtitleStyle,
      headerPadding: headerPadding ?? this.headerPadding,
      headerIconSize: headerIconSize ?? this.headerIconSize,
      weekdayHeaderBackgroundColor:
          weekdayHeaderBackgroundColor ?? this.weekdayHeaderBackgroundColor,
      weekdayHeaderTextColor:
          weekdayHeaderTextColor ?? this.weekdayHeaderTextColor,
      weekdayHeaderTextStyle:
          weekdayHeaderTextStyle ?? this.weekdayHeaderTextStyle,
      weekdayHeaderPadding: weekdayHeaderPadding ?? this.weekdayHeaderPadding,
      calendarPadding: calendarPadding ?? this.calendarPadding,
      dateCellMargin: dateCellMargin ?? this.dateCellMargin,
      dateCellBorderRadius: dateCellBorderRadius ?? this.dateCellBorderRadius,
      dateCellBackgroundColor:
          dateCellBackgroundColor ?? this.dateCellBackgroundColor,
      dateCellTextColor: dateCellTextColor ?? this.dateCellTextColor,
      dateCellTextStyle: dateCellTextStyle ?? this.dateCellTextStyle,
      dateCellSecondaryTextStyle:
          dateCellSecondaryTextStyle ?? this.dateCellSecondaryTextStyle,
      todayBackgroundColor: todayBackgroundColor ?? this.todayBackgroundColor,
      todayTextColor: todayTextColor ?? this.todayTextColor,
      todayBorderColor: todayBorderColor ?? this.todayBorderColor,
      selectedDateBackgroundColor:
          selectedDateBackgroundColor ?? this.selectedDateBackgroundColor,
      selectedDateTextColor:
          selectedDateTextColor ?? this.selectedDateTextColor,
      selectedDateBorderColor:
          selectedDateBorderColor ?? this.selectedDateBorderColor,
      disabledDateBackgroundColor:
          disabledDateBackgroundColor ?? this.disabledDateBackgroundColor,
      disabledDateTextColor:
          disabledDateTextColor ?? this.disabledDateTextColor,
      sabbathBackgroundColor:
          sabbathBackgroundColor ?? this.sabbathBackgroundColor,
      sabbathTextColor: sabbathTextColor ?? this.sabbathTextColor,
      fullMoonBackgroundColor:
          fullMoonBackgroundColor ?? this.fullMoonBackgroundColor,
      fullMoonTextColor: fullMoonTextColor ?? this.fullMoonTextColor,
      newMoonBackgroundColor:
          newMoonBackgroundColor ?? this.newMoonBackgroundColor,
      newMoonTextColor: newMoonTextColor ?? this.newMoonTextColor,
      holidayIndicatorColor:
          holidayIndicatorColor ?? this.holidayIndicatorColor,
      astroIndicatorColor: astroIndicatorColor ?? this.astroIndicatorColor,
    );
  }
}
