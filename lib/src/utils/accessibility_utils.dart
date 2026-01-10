/// Accessibility utilities for Myanmar Calendar widgets
///
/// This file provides utilities and helpers for making the Myanmar Calendar
/// package accessible to all users, including those using screen readers
/// and other assistive technologies.
library;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

/// Accessibility helper for calendar widgets
class CalendarAccessibility {
  /// Generate semantic label for a calendar date
  ///
  /// Creates a descriptive label that screen readers can announce,
  /// including Myanmar date, Western date, holidays, and special days.
  static String generateDateLabel(
    CompleteDate date, {
    Language language = Language.english,
    bool includeHolidays = true,
    bool includeAstrology = true,
    bool isSelected = false,
    bool isToday = false,
  }) {
    final buffer = StringBuffer();

    // Add selection state
    if (isSelected) {
      buffer.write('Selected. ');
    }

    // Add today indicator
    if (isToday) {
      buffer.write('Today. ');
    }

    // Add Myanmar date
    buffer.write('Myanmar date: ${date.formatMyanmar()}. ');

    // Add Western date
    buffer.write('Western date: ${date.formatWestern()}. ');

    // Add weekday
    buffer.write('${date.westernWeekdayName}. ');

    // Add holidays
    if (includeHolidays && date.hasHolidays) {
      buffer.write('Holiday: ${date.allHolidays.join(", ")}. ');
    }

    // Add astrological information
    if (includeAstrology) {
      if (date.isSabbath) {
        buffer.write('Sabbath day. ');
      }
      if (date.isFullMoon) {
        buffer.write('Full moon. ');
      }
      if (date.isNewMoon) {
        buffer.write('New moon. ');
      }
    }

    return buffer.toString().trim();
  }

  /// Generate semantic label for month navigation
  static String generateMonthLabel(DateTime month, Language language) {
    final monthName = _getMonthName(month.month, language);
    return '$monthName ${month.year}';
  }

  /// Generate semantic hint for date selection
  static String getDateSelectionHint({
    bool isSelectable = true,
    bool isDisabled = false,
  }) {
    if (isDisabled) {
      return 'This date is disabled and cannot be selected';
    }
    if (isSelectable) {
      return 'Double tap to select this date';
    }
    return '';
  }

  /// Generate semantic hint for navigation buttons
  static String getNavigationHint(String direction) {
    switch (direction.toLowerCase()) {
      case 'previous':
      case 'left':
        return 'Navigate to previous month';
      case 'next':
      case 'right':
        return 'Navigate to next month';
      case 'today':
        return 'Go to today\'s date';
      default:
        return 'Navigate';
    }
  }

  /// Create semantic properties for a calendar cell
  static SemanticsProperties createCellSemantics(
    CompleteDate date, {
    required VoidCallback? onTap,
    bool isSelected = false,
    bool isToday = false,
    bool isDisabled = false,
    Language language = Language.english,
  }) {
    return SemanticsProperties(
      label: generateDateLabel(
        date,
        language: language,
        isSelected: isSelected,
        isToday: isToday,
      ),
      hint: getDateSelectionHint(
        isSelectable: onTap != null,
        isDisabled: isDisabled,
      ),
      button: true,
      enabled: !isDisabled,
      selected: isSelected,
      onTap: onTap,
    );
  }

  /// Announce a message to screen readers
  static void announce(BuildContext context, String message) {
    final view = View.of(context);
    SemanticsService.sendAnnouncement(view, message, TextDirection.ltr);
  }

  /// Announce date selection
  static void announceDateSelection(BuildContext context, CompleteDate date) {
    final message = 'Selected ${date.formatWestern()}';
    announce(context, message);
  }

  /// Announce month change
  static void announceMonthChange(BuildContext context, DateTime month) {
    final message =
        'Showing ${_getMonthName(month.month, Language.english)} ${month.year}';
    announce(context, message);
  }

  /// Get month name for the given language
  static String _getMonthName(int month, Language language) {
    // This is a simplified version - should use actual localization
    const monthNames = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return monthNames[month - 1];
  }
}

/// Keyboard navigation handler for calendar widgets
class CalendarKeyboardHandler {
  /// Handle keyboard navigation for calendar
  static KeyEventResult handleKeyEvent(
    FocusNode focusNode,
    KeyEvent event, {
    required VoidCallback onArrowUp,
    required VoidCallback onArrowDown,
    required VoidCallback onArrowLeft,
    required VoidCallback onArrowRight,
    required VoidCallback onEnter,
    required VoidCallback onSpace,
    VoidCallback? onEscape,
    VoidCallback? onHome,
    VoidCallback? onEnd,
  }) {
    if (event is! KeyDownEvent) {
      return KeyEventResult.ignored;
    }

    final key = event.logicalKey;

    if (key == LogicalKeyboardKey.arrowUp) {
      onArrowUp();
      return KeyEventResult.handled;
    } else if (key == LogicalKeyboardKey.arrowDown) {
      onArrowDown();
      return KeyEventResult.handled;
    } else if (key == LogicalKeyboardKey.arrowLeft) {
      onArrowLeft();
      return KeyEventResult.handled;
    } else if (key == LogicalKeyboardKey.arrowRight) {
      onArrowRight();
      return KeyEventResult.handled;
    } else if (key == LogicalKeyboardKey.enter) {
      onEnter();
      return KeyEventResult.handled;
    } else if (key == LogicalKeyboardKey.space) {
      onSpace();
      return KeyEventResult.handled;
    } else if (key == LogicalKeyboardKey.escape && onEscape != null) {
      onEscape();
      return KeyEventResult.handled;
    } else if (key == LogicalKeyboardKey.home && onHome != null) {
      onHome();
      return KeyEventResult.handled;
    } else if (key == LogicalKeyboardKey.end && onEnd != null) {
      onEnd();
      return KeyEventResult.handled;
    }

    return KeyEventResult.ignored;
  }
}

/// Focus management utilities for calendar widgets
class CalendarFocusManager {
  /// Create a focus node with accessibility labels
  static FocusNode createFocusNode({
    String? debugLabel,
    bool skipTraversal = false,
    bool canRequestFocus = true,
  }) {
    return FocusNode(
      debugLabel: debugLabel,
      skipTraversal: skipTraversal,
      canRequestFocus: canRequestFocus,
    );
  }

  /// Request focus with announcement
  static void requestFocusWithAnnouncement(
    BuildContext context,
    FocusNode focusNode,
    String announcement,
  ) {
    focusNode.requestFocus();
    CalendarAccessibility.announce(context, announcement);
  }
}

/// High contrast theme helper
class HighContrastHelper {
  /// Check if high contrast mode is enabled
  static bool isHighContrastEnabled(BuildContext context) {
    return MediaQuery.highContrastOf(context);
  }

  /// Get high contrast color
  static Color getHighContrastColor(
    BuildContext context,
    Color normalColor,
    Color highContrastColor,
  ) {
    return isHighContrastEnabled(context) ? highContrastColor : normalColor;
  }

  /// Get high contrast border
  static BoxDecoration getHighContrastBorder(
    BuildContext context, {
    Color? borderColor,
    double borderWidth = 2.0,
  }) {
    if (!isHighContrastEnabled(context)) {
      return const BoxDecoration();
    }

    return BoxDecoration(
      border: Border.all(
        color: borderColor ?? Colors.black,
        width: borderWidth,
      ),
    );
  }
}

/// Text scaling helper for accessibility
class TextScalingHelper {
  /// Get scaled font size
  static double getScaledFontSize(
    BuildContext context,
    double baseFontSize, {
    double maxScale = 2.0,
  }) {
    final textScaler = MediaQuery.textScalerOf(context);
    final scaledSize = textScaler.scale(baseFontSize);
    // Clamp the scaled size between base and base * maxScale
    return scaledSize.clamp(baseFontSize, baseFontSize * maxScale);
  }

  /// Check if large text is enabled
  static bool isLargeTextEnabled(BuildContext context, {double? fontSize}) {
    final textScaler = MediaQuery.textScalerOf(context);
    return textScaler.scale(fontSize ?? 14.0) > 1.3;
  }

  /// Get accessible text style
  static TextStyle getAccessibleTextStyle(
    BuildContext context,
    TextStyle baseStyle, {
    double? minFontSize,
    double? maxFontSize,
  }) {
    final textScaler = MediaQuery.textScalerOf(context);
    final baseFontSize = baseStyle.fontSize ?? 14.0;
    var fontSize = textScaler.scale(baseFontSize);

    if (minFontSize != null && fontSize < minFontSize) {
      fontSize = minFontSize;
    }
    if (maxFontSize != null && fontSize > maxFontSize) {
      fontSize = maxFontSize;
    }

    return baseStyle.copyWith(fontSize: fontSize);
  }
}

/// Accessibility testing helper
class AccessibilityTestHelper {
  /// Validate semantic properties
  static List<String> validateSemantics(SemanticsProperties properties) {
    final issues = <String>[];

    if (properties.label == null || properties.label!.isEmpty) {
      issues.add('Missing semantic label');
    }

    if (properties.button == true && properties.onTap == null) {
      issues.add('Button has no onTap callback');
    }

    return issues;
  }

  /// Check if widget is accessible
  static bool isAccessible(Widget widget) {
    // This is a simplified check - in real implementation,
    // you would traverse the widget tree
    return widget is Semantics || widget is MergeSemantics;
  }
}
