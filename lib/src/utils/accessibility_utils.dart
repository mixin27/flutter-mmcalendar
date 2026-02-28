// ignore_for_file: public_member_api_docs

/// Accessibility helpers for Myanmar calendar widgets.
library;

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

/// Semantic label and announcement helpers for calendar widgets.
class CalendarAccessibility {
  static String generateDateLabel(
    CompleteDate date, {
    Language language = Language.english,
    bool includeHolidays = true,
    bool includeAstrology = true,
    bool isSelected = false,
    bool isToday = false,
  }) {
    final parts = <String>[];

    if (isSelected) {
      parts.add('Selected');
    }
    if (isToday) {
      parts.add('Today');
    }

    final myanmar = MyanmarCalendar.formatMyanmar(
      date.myanmar,
      pattern: '&y &M &P &ff',
      language: language,
    );
    final western = MyanmarCalendar.formatWestern(
      date.western,
      pattern: '%yyyy-%mm-%dd',
      language: language,
    );

    parts.add('Myanmar date: $myanmar');
    parts.add('Western date: $western');
    parts.add(TranslationService.getWeekdayName(date.weekday, language));

    if (includeHolidays && date.hasHolidays) {
      parts.add('Holiday: ${date.allHolidays.join(', ')}');
    }

    if (includeAstrology) {
      if (date.isSabbath) {
        parts.add('Sabbath');
      }
      if (date.isFullMoon) {
        parts.add('Full moon');
      }
      if (date.isNewMoon) {
        parts.add('New moon');
      }
    }

    return '${parts.join('. ')}.';
  }

  static String generateMonthLabel(DateTime month, Language language) {
    final name = TranslationService.getWesternMonthName(month.month, language);
    return '$name ${month.year}';
  }

  static String getDateSelectionHint({
    bool isSelectable = true,
    bool isDisabled = false,
  }) {
    if (isDisabled) {
      return 'This date is disabled';
    }
    if (isSelectable) {
      return 'Double tap to select';
    }
    return '';
  }

  static String getNavigationHint(String direction) {
    switch (direction.toLowerCase()) {
      case 'previous':
      case 'left':
        return 'Go to previous month';
      case 'next':
      case 'right':
        return 'Go to next month';
      case 'today':
        return 'Jump to today';
      default:
        return 'Navigate';
    }
  }

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

  static void announce(BuildContext context, String message) {
    final view = View.of(context);
    SemanticsService.sendAnnouncement(view, message, TextDirection.ltr);
  }

  static void announceDateSelection(BuildContext context, CompleteDate date) {
    final text = MyanmarCalendar.formatWestern(
      date.western,
      pattern: '%yyyy-%mm-%dd',
      language: Language.english,
    );
    announce(context, 'Selected $text');
  }

  static void announceMonthChange(BuildContext context, DateTime month) {
    announce(context, 'Showing ${generateMonthLabel(month, Language.english)}');
  }
}

class CalendarKeyboardHandler {
  /// Handles keyboard navigation semantics for calendar-like grids.
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
    }
    if (key == LogicalKeyboardKey.arrowDown) {
      onArrowDown();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowLeft) {
      onArrowLeft();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.arrowRight) {
      onArrowRight();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.enter) {
      onEnter();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.space) {
      onSpace();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.escape && onEscape != null) {
      onEscape();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.home && onHome != null) {
      onHome();
      return KeyEventResult.handled;
    }
    if (key == LogicalKeyboardKey.end && onEnd != null) {
      onEnd();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}

class CalendarFocusManager {
  /// Creates focus nodes with consistent defaults for calendar controls.
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

  static void requestFocusWithAnnouncement(
    BuildContext context,
    FocusNode focusNode,
    String announcement,
  ) {
    focusNode.requestFocus();
    CalendarAccessibility.announce(context, announcement);
  }
}

class HighContrastHelper {
  /// Returns true when high-contrast mode is enabled.
  static bool isHighContrastEnabled(BuildContext context) {
    return MediaQuery.highContrastOf(context);
  }

  static Color getHighContrastColor(
    BuildContext context,
    Color normalColor,
    Color highContrastColor,
  ) {
    return isHighContrastEnabled(context) ? highContrastColor : normalColor;
  }

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

class TextScalingHelper {
  /// Calculates scaled font size with an upper cap.
  static double getScaledFontSize(
    BuildContext context,
    double baseFontSize, {
    double maxScale = 2.0,
  }) {
    final scaled = MediaQuery.textScalerOf(context).scale(baseFontSize);
    return scaled.clamp(baseFontSize, baseFontSize * maxScale);
  }

  static bool isLargeTextEnabled(BuildContext context, {double? fontSize}) {
    return MediaQuery.textScalerOf(context).scale(fontSize ?? 14) > 1.3;
  }

  static TextStyle getAccessibleTextStyle(
    BuildContext context,
    TextStyle baseStyle, {
    double? minFontSize,
    double? maxFontSize,
  }) {
    final base = baseStyle.fontSize ?? 14;
    var size = MediaQuery.textScalerOf(context).scale(base);

    if (minFontSize != null && size < minFontSize) {
      size = minFontSize;
    }
    if (maxFontSize != null && size > maxFontSize) {
      size = maxFontSize;
    }

    return baseStyle.copyWith(fontSize: size);
  }
}

class AccessibilityTestHelper {
  /// Basic semantic assertions used by widget tests.
  static List<String> validateSemantics(SemanticsProperties properties) {
    final issues = <String>[];

    if ((properties.label ?? '').isEmpty) {
      issues.add('Missing semantic label');
    }
    if (properties.button == true && properties.onTap == null) {
      issues.add('Button has no onTap callback');
    }

    return issues;
  }

  static bool isAccessible(Widget widget) {
    return widget is Semantics || widget is MergeSemantics;
  }
}
