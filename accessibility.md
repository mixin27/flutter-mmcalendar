# Accessibility Guide

## Overview

The `flutter_mmcalendar` package includes comprehensive accessibility features to ensure your calendar applications are usable by everyone, including users with disabilities who rely on screen readers, keyboard navigation, and other assistive technologies.

## Features

- ✅ **Screen Reader Support** - Full semantic labels for all calendar elements
- ✅ **Keyboard Navigation** - Complete keyboard support for date selection
- ✅ **High Contrast Mode** - Automatic high contrast theme adaptation
- ✅ **Text Scaling** - Respects system text scaling settings
- ✅ **WCAG Compliance** - Follows Web Content Accessibility Guidelines

---

## Automatic Accessibility

The `OptimizedCalendarCell` widget includes accessibility features by default:

```dart
MyanmarCalendarWidget(
  initialDate: DateTime.now(),
  language: Language.myanmar,
  onDateSelected: (date) => print('Selected: $date'),
  // Accessibility is automatic!
)
```

**What you get automatically:**
- Semantic labels for each date
- Holiday and astrological information in labels
- "Today" and "Selected" state announcements
- High contrast support
- Text scaling support

---

## Screen Reader Support

### Semantic Labels

Each calendar cell has a comprehensive semantic label:

```dart
// Example label for a date:
"Today. Myanmar date: ၁၃၈၇ တပေါင်း လဆန်း ၁၅ ရက်. Western date: 2025-01-15. Wednesday. Holiday: တန်ခူးလဆန်း."
```

### Generate Custom Labels

```dart
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

final label = CalendarAccessibility.generateDateLabel(
  completeDate,
  language: Language.myanmar,
  includeHolidays: true,
  includeAstrology: true,
  isSelected: false,
  isToday: true,
);
```

### Announce to Screen Reader

```dart
// Announce a message
CalendarAccessibility.announce(
  context,
  'Selected January 15, 2025',
);

// Announce date selection
CalendarAccessibility.announceDateSelection(
  context,
  completeDate,
  language: Language.myanmar,
);

// Announce month change
CalendarAccessibility.announceMonthChange(
  context,
  'January 2025',
);
```

---

## Keyboard Navigation

### Built-in Handler

Use `CalendarKeyboardHandler` for complete keyboard support:

```dart
class MyCalendarWidget extends StatefulWidget {
  @override
  _MyCalendarWidgetState createState() => _MyCalendarWidgetState();
}

class _MyCalendarWidgetState extends State<MyCalendarWidget> {
  final _focusNode = FocusNode();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: (node, event) {
        return CalendarKeyboardHandler.handleKeyEvent(
          node,
          event,
          onArrowUp: () => _moveSelection(-7),      // Previous week
          onArrowDown: () => _moveSelection(7),     // Next week
          onArrowLeft: () => _moveSelection(-1),    // Previous day
          onArrowRight: () => _moveSelection(1),    // Next day
          onEnter: () => _selectDate(),
          onSpace: () => _selectDate(),
          onEscape: () => Navigator.pop(context),
          onHome: () => _goToToday(),
          onEnd: () => _goToMonthEnd(),
        );
      },
      child: MyanmarCalendarWidget(
        initialDate: _selectedDate,
        onDateSelected: (date) => setState(() {
          _selectedDate = date.western.toDateTime();
        }),
      ),
    );
  }

  void _moveSelection(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
    CalendarAccessibility.announce(
      context,
      'Selected ${_selectedDate.toString()}',
    );
  }

  void _selectDate() {
    // Handle selection
    CalendarAccessibility.announceDateSelection(
      context,
      MyanmarCalendar.fromDateTime(_selectedDate).toCompleteDate(),
    );
  }

  void _goToToday() {
    setState(() => _selectedDate = DateTime.now());
  }

  void _goToMonthEnd() {
    final lastDay = DateTime(_selectedDate.year, _selectedDate.month + 1, 0);
    setState(() => _selectedDate = lastDay);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
```

### Keyboard Shortcuts

| Key | Action |
|-----|--------|
| **Arrow Up** | Move to previous week (same day) |
| **Arrow Down** | Move to next week (same day) |
| **Arrow Left** | Move to previous day |
| **Arrow Right** | Move to next day |
| **Enter** | Select current date |
| **Space** | Select current date |
| **Home** | Go to first day of month |
| **End** | Go to last day of month |
| **Escape** | Close calendar/dialog |

---

## High Contrast Support

### Automatic Detection

The `OptimizedCalendarCell` automatically detects and adapts to high contrast mode:

```dart
// Automatic in OptimizedCalendarCell
final isHighContrast = HighContrastHelper.isHighContrastEnabled(context);
```

### Custom High Contrast Colors

```dart
// Get high contrast color
final color = HighContrastHelper.getHighContrastColor(
  context,
  normalColor: Colors.blue,
  highContrastColor: Colors.black,
);

// Get high contrast border
final decoration = HighContrastHelper.getHighContrastBorder(
  context,
  borderColor: Colors.black,
  borderWidth: 2.0,
);
```

### Apply to Custom Widgets

```dart
Widget build(BuildContext context) {
  final isHighContrast = HighContrastHelper.isHighContrastEnabled(context);

  return Container(
    decoration: isHighContrast
        ? HighContrastHelper.getHighContrastBorder(context)
        : BoxDecoration(border: Border.all(color: Colors.grey)),
    child: Text('Calendar'),
  );
}
```

---

## Text Scaling

### Automatic Scaling

The `OptimizedCalendarCell` automatically respects system text scaling:

```dart
// Automatic in OptimizedCalendarCell
final fontSize = TextScalingHelper.getScaledFontSize(
  context,
  14.0,
  maxScale: 2.0,
);
```

### Custom Text Scaling

```dart
// Get scaled font size
final fontSize = TextScalingHelper.getScaledFontSize(
  context,
  14.0,
  maxScale: 2.0,
);

// Check if large text is enabled
final isLargeText = TextScalingHelper.isLargeTextEnabled(
  context,
  fontSize: 14.0,
);

// Get accessible text style
final textStyle = TextScalingHelper.getAccessibleTextStyle(
  context,
  TextStyle(fontSize: 14),
  minFontSize: 12,
  maxFontSize: 24,
);
```

---

## Focus Management

### Create and Manage Focus

```dart
// Create focus node with announcement
final focusNode = CalendarFocusManager.createFocusNode(
  debugLabel: 'calendar_cell',
);

// Request focus with announcement
CalendarFocusManager.requestFocusWithAnnouncement(
  context,
  focusNode,
  'Calendar cell focused',
);

// Dispose focus node
CalendarFocusManager.disposeFocusNode(focusNode);
```

---

## Testing Accessibility

### Validate Semantics

```dart
testWidgets('calendar cell has semantic label', (tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: OptimizedCalendarCell(
          date: testDate,
          onTap: () {},
        ),
      ),
    ),
  );

  expect(
    find.bySemanticsLabel(RegExp('Myanmar date')),
    findsOneWidget,
  );
});
```

### Test with Screen Readers

**Android (TalkBack):**
1. Enable TalkBack in Settings > Accessibility
2. Navigate calendar with swipe gestures
3. Verify all dates are announced correctly
4. Test date selection with double-tap

**iOS (VoiceOver):**
1. Enable VoiceOver in Settings > Accessibility
2. Navigate calendar with swipe gestures
3. Verify all dates are announced correctly
4. Test date selection with double-tap

---

## Best Practices

### 1. Always Provide Semantic Labels

```dart
// ✅ Good: Semantic label provided
Semantics(
  label: CalendarAccessibility.generateDateLabel(date),
  hint: 'Double tap to select',
  button: true,
  onTap: onTap,
  child: DateCell(date: date),
)

// ❌ Bad: No semantic label
GestureDetector(
  onTap: onTap,
  child: Text('${date.day}'),
)
```

### 2. Support Keyboard Navigation

```dart
// ✅ Good: Keyboard navigation supported
Focus(
  onKeyEvent: (node, event) => CalendarKeyboardHandler.handleKeyEvent(...),
  child: Calendar(),
)

// ❌ Bad: Mouse/touch only
GestureDetector(
  onTap: onTap,
  child: Calendar(),
)
```

### 3. Test with Assistive Technologies

- Test with TalkBack (Android) and VoiceOver (iOS)
- Test with keyboard navigation only
- Test with high contrast mode enabled
- Test with large text sizes (200%+)

### 4. Respect System Settings

```dart
// ✅ Good: Respect system settings
final fontSize = TextScalingHelper.getScaledFontSize(context, 14.0);
final isHighContrast = HighContrastHelper.isHighContrastEnabled(context);

// ❌ Bad: Hardcoded values
final fontSize = 14.0;  // Ignores user preferences
```

### 5. Provide Helpful Hints

```dart
// ✅ Good: Helpful hint
Semantics(
  label: 'January 15, 2025',
  hint: 'Double tap to select this date',
  button: true,
)

// ❌ Bad: No hint
Semantics(
  label: 'January 15, 2025',
  button: true,
)
```

---

## WCAG Compliance

The accessibility features help you meet WCAG 2.1 Level AA requirements:

- ✅ **1.3.1 Info and Relationships** - Semantic labels convey information
- ✅ **1.4.3 Contrast** - High contrast mode support
- ✅ **1.4.4 Resize Text** - Text scaling support
- ✅ **2.1.1 Keyboard** - Full keyboard navigation
- ✅ **2.4.3 Focus Order** - Logical focus order
- ✅ **2.4.7 Focus Visible** - Clear focus indicators
- ✅ **4.1.2 Name, Role, Value** - Proper semantic roles

---

## API Reference

### CalendarAccessibility

- `static String generateDateLabel(...)` - Generate semantic label for date
- `static String getDateSelectionHint(...)` - Get selection hint
- `static void announce(BuildContext, String)` - Announce to screen reader
- `static void announceDateSelection(...)` - Announce date selection
- `static void announceMonthChange(...)` - Announce month change

### CalendarKeyboardHandler

- `static KeyEventResult handleKeyEvent(...)` - Handle keyboard events

### HighContrastHelper

- `static bool isHighContrastEnabled(BuildContext)` - Check high contrast mode
- `static Color getHighContrastColor(...)` - Get high contrast color
- `static BoxDecoration getHighContrastBorder(...)` - Get high contrast border

### TextScalingHelper

- `static double getScaledFontSize(...)` - Get scaled font size
- `static bool isLargeTextEnabled(...)` - Check if large text enabled
- `static TextStyle getAccessibleTextStyle(...)` - Get accessible text style

### CalendarFocusManager

- `static FocusNode createFocusNode(...)` - Create focus node
- `static void requestFocusWithAnnouncement(...)` - Request focus with announcement
- `static void disposeFocusNode(FocusNode)` - Dispose focus node
