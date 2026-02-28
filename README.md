# flutter_mmcalendar

A Flutter-first UI toolkit for Myanmar calendar apps, powered by
[`myanmar_calendar_dart`](https://pub.dev/packages/myanmar_calendar_dart).

[![Flutter CI/CD](https://github.com/mixin27/flutter-mmcalendar/actions/workflows/flutter.yaml/badge.svg)](https://github.com/mixin27/flutter-mmcalendar/actions/workflows/flutter.yaml)
[![pub package](https://img.shields.io/pub/v/flutter_mmcalendar.svg)](https://pub.dev/packages/flutter_mmcalendar)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Highlights

- Accurate Myanmar <-> Western date conversion via `myanmar_calendar_dart`
- Calendar UI with `single`, `range`, and `multi` selection modes
- Dialog and fullscreen date pickers with responsive action footer
- Scrollable long-range year selector in picker year mode
- Horoscope + summary widgets for rich date insights
- Reusable moon phase widgets using `CustomPainter`
- Theme and localization support (Myanmar, English, Mon, Shan, Karen, Zawgyi)
- Accessibility helpers (semantics, keyboard, focus, text scaling)
- Performance helpers and cache support from the core package

## Installation

```yaml
dependencies:
  flutter_mmcalendar: ^3.3.0
```

```bash
flutter pub get
```

## Quick Start

```dart
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

void main() {
  // Optional runtime configuration.
  MyanmarCalendar.configure(
    language: Language.myanmar,
    timezoneOffset: 6.5,
  );

  final today = MyanmarCalendar.today();
  print(today.formatMyanmar());

  final complete = MyanmarCalendar.getCompleteDate(DateTime.now());
  print(complete.allHolidays);
}
```

## Core API

You get both data APIs and Flutter widgets from the same import:

```dart
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
```

Common data operations:

```dart
final fromWestern = MyanmarCalendar.fromWestern(2026, 3, 2);
final fromMyanmar = MyanmarCalendar.fromMyanmar(1387, 12, 15);

final complete = MyanmarCalendar.getCompleteDate(DateTime.now());
final valid = MyanmarCalendar.isValidMyanmar(1387, 12, 15);
```

## Widgets

### `MyanmarCalendarWidget`

```dart
MyanmarCalendarWidget(
  initialDate: DateTime.now(),
  language: Language.myanmar,
  selectionMode: CalendarSelectionMode.range,
  showHolidays: true,
  showAstrology: true,
  onDateSelected: (date) {
    // date is CompleteDate
  },
  onRangeSelected: (start, end) {},
)
```

### `MyanmarDatePickerWidget` (inline)

```dart
MyanmarDatePickerWidget(
  initialDate: DateTime.now(),
  language: Language.english,
  showHolidays: true,
  showAstrology: true,
  onDateChanged: (date) {},
)
```

### Dialog / fullscreen picker

```dart
final selected = await showMyanmarDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(1900),
  lastDate: DateTime(2200),
  language: Language.myanmar,
);

final fullscreenSelected = await showMyanmarDatePickerFullscreen(
  context: context,
  language: Language.shan,
);
```

### Form integration

```dart
MyanmarDatePickerFormField(
  language: Language.myanmar,
  onChanged: (value) {
    // value is MyanmarDateTime?
  },
)
```

## Moon Phase Widgets (CustomPainter)

### Generic moon phase view

```dart
MoonPhaseView(
  phase: 0.25, // 0.0..1.0
  size: 44,
  animate: true,
)
```

### Daily moon phase from Myanmar date data

```dart
final complete = MyanmarCalendar.getCompleteDate(DateTime.now());

DailyMoonPhaseWidget.fromCompleteDate(
  complete,
  language: Language.myanmar,
  size: 40,
  showLabel: true,
  showIllumination: true,
)
```

### Math helpers

```dart
final phase = MoonPhaseMath.phaseFromDailyMyanmarData(
  moonPhase: complete.myanmar.moonPhase,
  fortnightDay: complete.myanmar.fortnightDay,
  monthLength: complete.myanmar.monthLength,
);

final illumination = MoonPhaseMath.illumination(phase); // 0..1
```

## Theme Customization

```dart
final theme = MyanmarCalendarTheme.fromColor(
  const Color(0xFF0F766E),
).copyWith(
  dateCellBorderRadius: 10,
  holidayIndicatorColor: const Color(0xFFDC2626),
);

MyanmarCalendarWidget(theme: theme)
```

## New Picker UX

The current picker includes:

- Responsive action footer (prevents overflow in longer localized labels)
- Scrollable long-range year selector via wheel picker
- Month availability rules based on `firstDate` / `lastDate`

## Accessibility & Performance

The core widgets include built-in semantics, keyboard/focus helpers, and
performance-oriented rendering defaults (`RepaintBoundary`, cache-backed date
lookups, and constrained rebuild surfaces).

## Example App

Run the showcase app:

```bash
cd example
flutter run
```

Showcase includes:

- Calendar screen (selection modes)
- Picker screen (inline/dialog/fullscreen + form)
- Insights screen (toolbar, summary, horoscope, moon timeline)

## Migration Notes

If you are migrating from older `flutter_mmcalendar` versions:

- Core dependency is now `myanmar_calendar_dart 2.x`
- Picker and calendar internals are fully refactored
- Moon widgets are now CustomPainter-based (`MoonPhaseView`, `DailyMoonPhaseWidget`)
- Some legacy docs/examples from older versions were removed in favor of current APIs

## Changelog

See [CHANGELOG.md](CHANGELOG.md).

## License

MIT — see [LICENSE](LICENSE).
