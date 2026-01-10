/// Optimized calendar cell widget with performance enhancements
///
/// This widget demonstrates best practices for calendar cell rendering:
/// - RepaintBoundary to prevent unnecessary repaints
/// - Const constructors where possible
/// - Semantic labels for accessibility
/// - Efficient rebuild handling
library;

import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../core/myanmar_calendar_theme.dart';
import '../utils/accessibility_utils.dart';

/// An optimized calendar cell widget
///
/// This widget wraps a calendar date cell with performance optimizations
/// and accessibility features.
class OptimizedCalendarCell extends StatelessWidget {
  /// The date to display
  final CompleteDate date;

  /// Whether this date is selected
  final bool isSelected;

  /// Whether this date is start of a range
  final bool isRangeStart;

  /// Whether this date is end of a range
  final bool isRangeEnd;

  /// Whether this date is within a range
  final bool isInRange;

  /// Whether this date is part of multi-selection
  final bool isMultiSelected;

  /// Whether this date is today
  final bool isToday;

  /// Whether this date is disabled
  final bool isDisabled;

  /// Whether this date is in the current month
  final bool isInCurrentMonth;

  /// Callback when the date is tapped
  final VoidCallback? onTap;

  /// The language to use for accessibility
  final Language language;

  /// Whether to show holidays
  final bool showHolidays;

  /// Whether to show astrological information
  final bool showAstrology;

  /// Background color for the cell
  final Color? backgroundColor;

  /// Text color for the date
  final Color? textColor;

  /// Border color for the cell
  final Color? borderColor;

  /// Custom Myanmar calendar theme
  final MyanmarCalendarTheme? theme;

  /// Create a new [OptimizedCalendarCell]
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

  @override
  Widget build(BuildContext context) {
    // Wrap in RepaintBoundary to prevent unnecessary repaints
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
        hint: CalendarAccessibility.getDateSelectionHint(
          isSelectable: onTap != null && !isDisabled,
          isDisabled: isDisabled,
        ),
        button: true,
        enabled: !isDisabled,
        selected: isSelected,
        child: _buildCell(context),
      ),
    );
  }

  Widget _buildCell(BuildContext context) {
    final isHighContrast = HighContrastHelper.isHighContrastEnabled(context);

    return Material(
      color: _getCellBackgroundColor(context),
      child: InkWell(
        onTap: isDisabled ? null : onTap,
        child: Container(
          margin: theme?.dateCellMargin,
          decoration: _getDefaultDecoration(context, isHighContrast),
          child: Center(child: _buildCellContent(context)),
        ),
      ),
    );
  }

  Widget _buildCellContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Western date number
        Text('${date.westernDay}', style: _getTextStyle(context)),
        // Optional indicators
        if (showHolidays && date.hasHolidays) ...[
          const SizedBox(height: 2),
          _buildHolidayIndicator(context),
        ],
        if (showAstrology && (date.isFullMoon || date.isSabbath)) ...[
          const SizedBox(height: 2),
          _buildAstroIndicator(context),
        ],
      ],
    );
  }

  Widget _buildHolidayIndicator(BuildContext context) {
    final indicatorColor = theme?.holidayIndicatorColor ?? Colors.red;
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(color: indicatorColor, shape: BoxShape.circle),
    );
  }

  Widget _buildAstroIndicator(BuildContext context) {
    final indicatorColor = theme?.astroIndicatorColor ?? Colors.orange;
    return Icon(
      date.isFullMoon ? Icons.brightness_1 : Icons.brightness_2,
      size: 8,
      color: indicatorColor,
    );
  }

  Color _getCellBackgroundColor(BuildContext context) {
    // Use custom backgroundColor if provided
    if (backgroundColor != null) return backgroundColor!;

    // Use theme colors if available
    if (theme != null) {
      if (isDisabled) return theme!.disabledDateBackgroundColor;
      if (isSelected || isRangeStart || isRangeEnd || isMultiSelected) {
        if (isRangeStart) return theme!.rangeStartBackgroundColor;
        if (isRangeEnd) return theme!.rangeEndBackgroundColor;
        if (isMultiSelected) return theme!.multiSelectedBackgroundColor;
        return theme!.selectedDateBackgroundColor;
      }
      if (isInRange) return theme!.rangeBackgroundColor;
      if (isToday) return theme!.todayBackgroundColor;
      if (date.isFullMoon) return theme!.fullMoonBackgroundColor;
      if (date.isNewMoon) return theme!.newMoonBackgroundColor;
      if (!isInCurrentMonth) return theme!.disabledDateBackgroundColor;
      return theme!.dateCellBackgroundColor;
    }

    // Fallback to Material theme
    final materialTheme = Theme.of(context);
    if (isSelected) return materialTheme.colorScheme.primary;
    if (isToday) {
      return materialTheme.colorScheme.primary.withValues(alpha: 0.1);
    }
    if (!isInCurrentMonth) {
      return materialTheme.colorScheme.surface.withValues(alpha: 0.5);
    }
    return materialTheme.colorScheme.surface;
  }

  BoxDecoration _getDefaultDecoration(
    BuildContext context,
    bool isHighContrast,
  ) {
    final materialTheme = Theme.of(context);
    final effectiveBorderColor =
        borderColor ??
        theme?.selectedDateBorderColor ??
        materialTheme.colorScheme.onSurface;

    if (isHighContrast) {
      return BoxDecoration(
        border: Border.all(
          color: effectiveBorderColor,
          width: (isSelected || isRangeStart || isRangeEnd || isMultiSelected)
              ? 3
              : 1,
        ),
        borderRadius: BorderRadius.circular(theme?.dateCellBorderRadius ?? 4),
      );
    }

    // Range selection connected look
    if (isInRange || isRangeStart || isRangeEnd) {
      final radius = theme?.dateCellBorderRadius ?? 4;
      return BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular((isRangeStart || !isInRange) ? radius : 0),
          bottomLeft: Radius.circular(
            (isRangeStart || !isInRange) ? radius : 0,
          ),
          topRight: Radius.circular((isRangeEnd || !isInRange) ? radius : 0),
          bottomRight: Radius.circular((isRangeEnd || !isInRange) ? radius : 0),
        ),
      );
    }

    if (isToday && !isSelected) {
      final todayBorderColor =
          theme?.todayBorderColor ?? materialTheme.colorScheme.primary;
      return BoxDecoration(
        border: Border.all(color: todayBorderColor, width: 2),
        borderRadius: BorderRadius.circular(theme?.dateCellBorderRadius ?? 4),
      );
    }

    if (isSelected && theme?.selectedDateBorderColor != null) {
      return BoxDecoration(
        border: Border.all(
          color: theme!.selectedDateBorderColor ?? Colors.transparent,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(theme?.dateCellBorderRadius ?? 4),
      );
    }

    return BoxDecoration(
      borderRadius: BorderRadius.circular(theme?.dateCellBorderRadius ?? 4),
    );
  }

  TextStyle _getTextStyle(BuildContext context) {
    final materialTheme = Theme.of(context);
    final baseStyle =
        theme?.dateCellTextStyle ??
        materialTheme.textTheme.bodyMedium ??
        const TextStyle();

    // Use accessibility helper for text scaling
    final accessibleStyle = TextScalingHelper.getAccessibleTextStyle(
      context,
      baseStyle,
      minFontSize: 12,
      maxFontSize: 24,
    );

    return accessibleStyle.copyWith(
      color: _getTextColor(context),
      fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
    );
  }

  Color _getTextColor(BuildContext context) {
    // Use custom textColor if provided
    if (textColor != null) return textColor!;

    // Use theme colors if available
    if (theme != null) {
      if (isSelected || isRangeStart || isRangeEnd || isMultiSelected) {
        if (isRangeStart) return theme!.rangeStartTextColor;
        if (isRangeEnd) return theme!.rangeEndTextColor;
        if (isMultiSelected) return theme!.multiSelectedTextColor;
        return theme!.selectedDateTextColor;
      }
      if (isInRange) return theme!.rangeTextColor;
      if (isDisabled) return theme!.disabledDateTextColor;
      if (isToday) return theme!.todayTextColor;
      if (date.isFullMoon) return theme!.fullMoonTextColor;
      if (date.isNewMoon) return theme!.newMoonTextColor;
      if (!isInCurrentMonth) {
        final baseColor = theme!.dateCellTextColor;
        return Color.fromARGB(
          ((baseColor.a * 255.0).round().clamp(0, 255) * 0.6).round(),
          (baseColor.r * 255.0).round().clamp(0, 255),
          (baseColor.g * 255.0).round().clamp(0, 255),
          (baseColor.b * 255.0).round().clamp(0, 255),
        );
      }
      return theme!.dateCellTextColor;
    }

    // Fallback to Material theme
    final materialTheme = Theme.of(context);
    if (isSelected) return materialTheme.colorScheme.onPrimary;
    if (isDisabled) {
      return materialTheme.colorScheme.onSurface.withValues(alpha: 0.38);
    }
    if (!isInCurrentMonth) {
      return materialTheme.colorScheme.onSurface.withValues(alpha: 0.6);
    }
    return materialTheme.colorScheme.onSurface;
  }
}

/// A calendar cell builder that creates optimized cells
class OptimizedCalendarCellBuilder {
  /// Build an optimized calendar cell
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
