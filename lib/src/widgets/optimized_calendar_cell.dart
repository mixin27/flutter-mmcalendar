// ignore_for_file: public_member_api_docs

/// Optimized calendar cell widget used by calendar and picker views.
library;

import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../core/myanmar_calendar_theme.dart';
import '../utils/accessibility_utils.dart';

/// High-performance day cell for calendar grids.
///
/// Uses [RepaintBoundary] + semantic labels and supports range/multi states.
class OptimizedCalendarCell extends StatelessWidget {
  const OptimizedCalendarCell({
    super.key,
    required this.date,
    this.isSelected = false,
    this.isRangeStart = false,
    this.isRangeEnd = false,
    this.isInRange = false,
    this.isMultiSelected = false,
    this.isToday = false,
    this.isDisabled = false,
    this.isInCurrentMonth = true,
    this.onTap,
    this.language = Language.english,
    this.showHolidays = true,
    this.showAstrology = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.theme,
  });

  final CompleteDate date;
  final bool isSelected;
  final bool isRangeStart;
  final bool isRangeEnd;
  final bool isInRange;
  final bool isMultiSelected;
  final bool isToday;
  final bool isDisabled;
  final bool isInCurrentMonth;
  final VoidCallback? onTap;
  final Language language;
  final bool showHolidays;
  final bool showAstrology;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final MyanmarCalendarTheme? theme;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Semantics(
        label: CalendarAccessibility.generateDateLabel(
          date,
          language: language,
          includeHolidays: showHolidays,
          includeAstrology: showAstrology,
          isSelected: isSelected,
          isToday: isToday,
        ),
        button: true,
        enabled: !isDisabled,
        selected: isSelected,
        child: InkWell(
          onTap: isDisabled ? null : onTap,
          borderRadius: BorderRadius.circular(theme?.dateCellBorderRadius ?? 8),
          child: Container(
            margin: theme?.dateCellMargin ?? const EdgeInsets.all(2),
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
            decoration: BoxDecoration(
              color: _resolveBackground(context),
              borderRadius: BorderRadius.circular(
                theme?.dateCellBorderRadius ?? 8,
              ),
              border: _resolveBorder(context),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  '${date.westernDay}',
                  style:
                      (theme?.dateCellTextStyle ??
                              Theme.of(context).textTheme.bodyMedium ??
                              const TextStyle())
                          .copyWith(
                            color: _resolveTextColor(context),
                            fontWeight: isToday || isSelected
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                ),
                if (showHolidays && date.hasHolidays)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: theme?.holidayIndicatorColor ?? Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                if (showAstrology && (date.isSabbath || date.isFullMoon))
                  Icon(
                    date.isFullMoon ? Icons.brightness_2 : Icons.circle,
                    size: 8,
                    color: theme?.astroIndicatorColor ?? Colors.orange,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _resolveBackground(BuildContext context) {
    if (backgroundColor != null) {
      return backgroundColor!;
    }

    final fallbackTheme = theme ?? MyanmarCalendarTheme.defaultTheme();

    if (isDisabled || !isInCurrentMonth) {
      return fallbackTheme.disabledDateBackgroundColor;
    }
    if (isRangeStart) {
      return fallbackTheme.rangeStartBackgroundColor;
    }
    if (isRangeEnd) {
      return fallbackTheme.rangeEndBackgroundColor;
    }
    if (isInRange) {
      return fallbackTheme.rangeBackgroundColor;
    }
    if (isMultiSelected) {
      return fallbackTheme.multiSelectedBackgroundColor;
    }
    if (isSelected) {
      return fallbackTheme.selectedDateBackgroundColor;
    }
    if (isToday) {
      return fallbackTheme.todayBackgroundColor;
    }
    if (date.isFullMoon) {
      return fallbackTheme.fullMoonBackgroundColor;
    }
    if (date.isNewMoon) {
      return fallbackTheme.newMoonBackgroundColor;
    }

    return fallbackTheme.dateCellBackgroundColor;
  }

  Color _resolveTextColor(BuildContext context) {
    if (textColor != null) {
      return textColor!;
    }

    final fallbackTheme = theme ?? MyanmarCalendarTheme.defaultTheme();

    if (isRangeStart) {
      return fallbackTheme.rangeStartTextColor;
    }
    if (isRangeEnd) {
      return fallbackTheme.rangeEndTextColor;
    }
    if (isInRange) {
      return fallbackTheme.rangeTextColor;
    }
    if (isMultiSelected || isSelected) {
      return fallbackTheme.selectedDateTextColor;
    }
    if (isDisabled || !isInCurrentMonth) {
      return fallbackTheme.disabledDateTextColor;
    }
    if (isToday) {
      return fallbackTheme.todayTextColor;
    }

    return fallbackTheme.dateCellTextColor;
  }

  Border? _resolveBorder(BuildContext context) {
    if (isToday && !isSelected && !isInRange && !isRangeStart && !isRangeEnd) {
      final color =
          borderColor ??
          theme?.todayBorderColor ??
          Theme.of(context).colorScheme.primary;
      return Border.all(color: color, width: 1.6);
    }

    if (isSelected || isRangeStart || isRangeEnd || isMultiSelected) {
      final color =
          borderColor ??
          theme?.selectedDateBorderColor ??
          Theme.of(context).colorScheme.primary;
      return Border.all(color: color, width: 1.4);
    }

    return null;
  }
}

class OptimizedCalendarCellBuilder {
  /// Convenience builder for simple integrations.
  static Widget build({
    required BuildContext context,
    required CompleteDate date,
    bool isSelected = false,
    bool isToday = false,
    bool isDisabled = false,
    bool isInCurrentMonth = true,
    VoidCallback? onTap,
    Language language = Language.english,
    bool showHolidays = true,
    bool showAstrology = true,
  }) {
    return OptimizedCalendarCell(
      date: date,
      isSelected: isSelected,
      isToday: isToday,
      isDisabled: isDisabled,
      isInCurrentMonth: isInCurrentMonth,
      onTap: onTap,
      language: language,
      showHolidays: showHolidays,
      showAstrology: showAstrology,
    );
  }
}
