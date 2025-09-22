# Flutter Myanmar Calendar

A comprehensive Flutter package for Myanmar calendar operations, providing date conversions, astrological calculations, holiday information, and customizable date picker widgets.

[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![pub package](https://img.shields.io/pub/v/flutter_mmcalendar.svg)](https://pub.dev/packages/flutter_mmcalendar)
[![build status](https://github.com/mixin27/flutter-mmcalendar/workflows/build/badge.svg)](https://github.com/mixin27/flutter-mmcalendar/actions)
[![coverage](https://codecov.io/gh/mixin27/flutter-mmcalendar/branch/main/graph/badge.svg)](https://codecov.io/gh/mixin27/flutter-mmcalendar)

## Features

- ✨ Complete Myanmar calendar system
- 🗓️ Date conversion between Myanmar and Western calendars
- 🎋 Holiday calculations and information
- ⭐ Astrological calculations
- 🌏 Multi-language support
- 🎨 Customizable calendar and date picker widgets
- ✅ Extensive date validation
- 🚀 High performance and accuracy

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_mmcalendar: any
```

Import in your Dart code:

```dart
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
```

## Usage

### Basic Date Operations

```dart
// Get today's Myanmar date
final today = MyanmarCalendar.today();
print('Today: ${today.formatMyanmar()}');

// Convert Western to Myanmar date
final myanmarDate = MyanmarCalendar.fromWestern(2024, 1, 1);

// Convert Myanmar to Western date
final westernDate = MyanmarCalendar.fromMyanmar(1385, 10, 1);

// Get complete date info
final completeDate = MyanmarCalendar.getCompleteDate(DateTime.now());
print('Holidays: ${completeDate.holidays.allHolidays}');
print('Astrological days: ${completeDate.astro.astrologicalDays}');
```

### Available Widgets

#### Myanmar Calendar Widget

```dart
MyanmarCalendarWidget(
  onDateSelected: (date) => print('Selected: $date'),
  initialDate: DateTime.now(),
  language: Language.myanmar,
  showHolidays: true,
  showAstrology: true,
  theme: MyanmarCalendarTheme.traditional(),
)
```

#### Myanmar Date Picker (Modal)

```dart
final selectedDate = await showMyanmarDatePicker(
  context: context,
  initialDate: DateTime.now(),
  firstDate: DateTime(2020),
  lastDate: DateTime(2030),
  language: Language.english,
);
if (selectedDate != null) {
  print('Selected: ${selectedDate.formatComplete()}');
}
```

#### Myanmar Date Picker (Fullscreen)

```dart
final selectedDate = await showMyanmarDatePickerFullscreen(
  context: context,
  initialDate: DateTime.now(),
  language: Language.myanmar,
  title: 'ရက်စွဲရွေးချယ်ရန်',
);
```

## Customization

- **Themes**: Use built-in themes (`MyanmarDatePickerTheme.traditional()`, `MyanmarDatePickerTheme.dark()`) or customize your own.
- **Localization**: Set the language via the `language` parameter or globally with `MyanmarCalendar.setLanguage(Language.myanmar)`.

## Validation

```dart
final isValid = MyanmarCalendar.isValidMyanmar(1385, 10, 1);
if (!isValid) {
  print('Invalid Myanmar date!');
}
```

## Batch Operations

```dart
final dates = [
  DateTime(2024, 1, 1),
  DateTime(2024, 1, 2),
];
final completeDates = MyanmarCalendar.getCompleteDates(dates);
```

## Supported Languages

- Myanmar (Unicode)
- Myanmar (Zawgyi)
- English
- Mon
- Shan
- Karen

## Classes Reference

### Core

- `MyanmarDateTime` - Core date handling
- `CalendarConfig` - Global configuration
- `CompleteDate` - Combined date information

### Models

- `MyanmarDate` - Myanmar date representation
- `WesternDate` - Western date representation
- `HolidayInfo` - Holiday information
- `AstroInfo` - Astrological information

### Services

- `DateConverter` - Date conversion utilities
- `TranslationService` - Language support
- `HolidayCalculator` - Holiday calculations
- `AstroCalculator` - Astrological calculations

### Widgets

- `MyanmarCalendarWidget` - Calendar view
- `MyanmarDatePickerWidget` - Date picker

## Documentation

- [API Reference](https://pub.dev/documentation/flutter_mmcalendar/latest/)
- [Example App](example/lib/main.dart)

## Contributing

Contributions are welcome! Please open issues or pull requests on [GitHub](https://github.com/mixin27/flutter-mmcalendar).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
