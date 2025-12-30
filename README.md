# Myanmar Calendar Flutter Package

A comprehensive Flutter package for Myanmar calendar system with full support for date conversions, astrological calculations, holidays, and beautiful UI widgets.

[![Flutter CI/CD](https://github.com/mixin27/flutter-mmcalendar/actions/workflows/flutter.yaml/badge.svg)](https://github.com/mixin27/flutter-mmcalendar/actions/workflows/flutter.yaml)
[![codecov](https://codecov.io/github/mixin27/flutter-mmcalendar/graph/badge.svg?token=80WY0QH374)](https://codecov.io/github/mixin27/flutter-mmcalendar)
[![pub package](https://img.shields.io/pub/v/flutter_mmcalendar.svg)](https://pub.dartlang.org/packages/flutter_mmcalendar)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Features

- 📅 **Complete Myanmar Calendar System**: Full support for Myanmar calendar with accurate date conversions
- 🌙 **Astrological Calculations**: Buddhist era, sabbath days, moon phases, yatyaza, pyathada, and more
- 🎯 **Multi-language Support**: Myanmar, English, Mon, Shan, Karen, and Zawgyi scripts
- 🎨 **Beautiful UI Components**: Pre-built calendar widgets and date pickers
- 🌐 **Holiday Support**: Myanmar public holidays, religious days, and cultural events
- ⚙️ **Highly Configurable**: Customizable themes, date formats, and display options
- 📱 **Responsive Design**: Works perfectly on mobile, tablet, and desktop
- 🔄 **Date Arithmetic**: Easy date calculations and manipulations
- 🛡️ **Type Safe**: Full null safety support with comprehensive error handling
- ♿ **Accessibility**: Screen reader support, keyboard navigation, and high contrast themes
- ⚡ **Performance Optimized**: Built-in caching, batch processing, and performance monitoring
- 🎭 **Custom Exceptions**: Detailed error messages with recovery suggestions

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_mmcalendar: latest
```

Then run:

```bash
flutter pub get
```

## Quick Start

### Basic Usage

```dart
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

void main() {
  // Configure the calendar (optional)
  MyanmarCalendar.configure(
    language: Language.myanmar,
    timezoneOffset: 6.5, // Myanmar Standard Time
  );

  // Get today's date
  final today = MyanmarCalendar.today();
  print('Today: ${today.formatComplete()}');

  // Convert Western date to Myanmar
  final myanmarDate = MyanmarCalendar.fromWestern(2024, 1, 1);
  print('Myanmar: ${myanmarDate.formatMyanmar()}');
  print('Western: ${myanmarDate.formatWestern()}');
}
```

### Using Calendar Widget

```dart
import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Myanmar Calendar')),
        body: MyanmarCalendarWidget(
          language: Language.myanmar,
          onDateSelected: (date) {
            print('Selected: ${date.formatComplete()}');
          },
          showHolidays: true,
          showAstrology: true,
        ),
      ),
    );
  }
}
```

### Date Picker Dialog

```dart
Future<void> showDatePicker(BuildContext context) async {
  final selectedDate = await showMyanmarDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2020),
    lastDate: DateTime(2030),
    language: Language.myanmar,
    showHolidays: true,
  );

  if (selectedDate != null) {
    print('Selected: ${selectedDate.formatComplete()}');
  }
}
```

## Shan Calendar Support

The package now supports the Shan calendar, which follows the Myanmar calendar structure but uses a different year calculation:

> **NOTE:** We use the traditional `Tai Long / Shan` State era calculation.

**Formula:** Shan Year = Myanmar Year + 733

### Example Usage
```dart
// Get today's Shan year
final date = MyanmarCalendar.today();
print('Shan Year: ${date.shanYear}'); // e.g., 2120

// Format as Shan date
print(date.formatShan()); // ပီ 2120 လိူၼ်ပူၼ် ဝၼ်း 15

// Complete date with Shan calendar
final complete = date.formatCompleteWithShan(
  language: Language.shan,
);
print(complete);
// Output: "ပီ 2120 လိူၼ်ပူၼ် ဝၼ်း 15 | ၁၃၈၇ ပြာသို လဆန်း ၁၅ ရက် | 2025-01-15"

// Convert between Shan and Myanmar years
final shanYear = MyanmarCalendar.getShanYear(1387); // 2120
final myanmarYear = MyanmarCalendar.getMyanmarYearFromShan(2120); // 1387
```

### Shan Calendar Widget

When using Shan language, the calendar widget automatically displays Shan years:
```dart
MyanmarCalendarWidget(
  language: Language.shan,
  showHolidays: true,
  onDateSelected: (date) {
    print('Selected Shan Year: ${date.shanYear}');
  },
)
```

## Core Classes

### MyanmarCalendar

The main entry point for all Myanmar calendar operations.

```dart
// Configuration
MyanmarCalendar.configure(
  language: Language.myanmar,
  timezoneOffset: 6.5,
  sasanaYearType: 0, // 0, 1, or 2
);

// Factory methods
final today = MyanmarCalendar.today();
final fromWestern = MyanmarCalendar.fromWestern(2024, 1, 1);
final fromMyanmar = MyanmarCalendar.fromMyanmar(1385, 10, 1);
final fromDateTime = MyanmarCalendar.fromDateTime(DateTime.now());

// Parsing
final parsed = MyanmarCalendar.parseMyanmar('1385/10/1');

// Information
final complete = MyanmarCalendar.getCompleteDate(DateTime.now());
final astro = MyanmarCalendar.getAstroInfo(date);
final holidays = MyanmarCalendar.getHolidayInfo(date);

// Validation
final isValid = MyanmarCalendar.isValidMyanmar(1385, 10, 1);
final validation = MyanmarCalendar.validateMyanmar(1385, 10, 1);

// Utilities
final daysBetween = MyanmarCalendar.daysBetween(date1, date2);
final added = MyanmarCalendar.addDays(date, 10);
final sabbathDays = MyanmarCalendar.findSabbathDays(1385, 10);
```

### MyanmarDateTime

Represents a specific moment in time with both Myanmar and Western calendar information.

```dart
final mdt = MyanmarDateTime.now();

// Properties
print('Myanmar Year: ${mdt.myanmarYear}');
print('Myanmar Month: ${mdt.myanmarMonth}');
print('Myanmar Day: ${mdt.myanmarDay}');
print('Western Year: ${mdt.westernYear}');
print('Moon Phase: ${mdt.moonPhase}');
print('Is Sabbath: ${mdt.isSabbath}');
print('Holidays: ${mdt.allHolidays}');

// Date arithmetic
final tomorrow = mdt.addDays(1);
final nextWeek = mdt.addDays(7);
final duration = mdt.difference(other);

// Formatting
final myanmarFormat = mdt.formatMyanmar('&y &M &P &ff');
final westernFormat = mdt.formatWestern('%d-%m-%Y');
final complete = mdt.formatComplete();

// Comparisons
final isBefore = mdt.isBefore(other);
final isAfter = mdt.isAfter(other);
final isSameDay = mdt.isSameDay(other);
```

## Widgets

### MyanmarCalendarWidget

A full-featured calendar widget with Myanmar date support.

```dart
MyanmarCalendarWidget(
  initialDate: DateTime.now(),
  language: Language.myanmar,

  // Callbacks
  onDateSelected: (CompleteDate date) {
    print('Selected: ${date.formatComplete()}');
  },
  onMonthChanged: (DateTime month) {
    print('Month changed to: $month');
  },

  // Display options
  showHolidays: true,
  showAstrology: true,
  showWesternDates: true,
  showMyanmarDates: true,
  showWeekdayHeaders: true,
  showNavigation: true,

  // Customization
  theme: MyanmarCalendarTheme.defaultTheme(),
  firstDayOfWeek: 1, // Sunday
  highlightToday: true,
  highlightWeekends: true,

  // Constraints
  minDate: DateTime(2020),
  maxDate: DateTime(2030),

  // Custom builders
  cellBuilder: (context, date) => CustomDateCell(date),
  headerBuilder: (context, month) => CustomHeader(month),
)
```

### MyanmarDatePickerWidget

An interactive date picker with multiple view modes.

```dart
MyanmarDatePickerWidget(
  initialDate: DateTime.now(),
  language: Language.myanmar,

  // Callbacks
  onDateChanged: (CompleteDate date) {
    print('Date changed: ${date.formatComplete()}');
  },
  onConfirm: (CompleteDate date) {
    print('Date confirmed: ${date.formatComplete()}');
  },

  // Date constraints
  firstDate: DateTime(2020),
  lastDate: DateTime(2030),

  // UI options
  showTodayButton: true,
  showClearButton: true,
  showActionButtons: true,
  helpText: 'Select a date',

  // Theme
  theme: MyanmarCalendarTheme.darkTheme(),
)
```

### HoroscopeWidget

A specialized widget for displaying detailed traditional Burmese astrological information.

```dart
HoroscopeWidget(
  date: MyanmarCalendar.getCompleteDate(DateTime.now()),
  language: Language.english,
)
```

This widget includes:
- **Nakhat & Year Details**: Detailed descriptions of the Nakhat type.
- **Mahabote & Characteristics**: Localized personality and destiny insights.
- **Astrological Days**: Comprehensive list of auspicious and inauspicious indicators.
- **AI Prompt Integration**: Built-in specialized prompt generation for AI analysis.

## Languages

The package supports multiple languages:

```dart
enum Language {
  myanmar,    // မြန်မာ
  english,    // English
  zawgyi,     // Zawgyi Myanmar
  mon,        // Mon
  shan,       // Shan
  karen,      // Karen
}

// Usage
MyanmarCalendar.setLanguage(Language.myanmar);
final currentLang = MyanmarCalendar.currentLanguage;
```

## Themes

### Predefined Themes

```dart
// Light theme (default)
final lightTheme = MyanmarCalendarTheme.defaultTheme();

// Dark theme
final darkTheme = MyanmarCalendarTheme.darkTheme();

// Color-based theme
final customTheme = MyanmarCalendarTheme.fromColor(
  Colors.blue,
  isDark: false,
);
```

### Custom Theme

```dart
final customTheme = MyanmarCalendarTheme(
  backgroundColor: Colors.white,
  headerBackgroundColor: Colors.blue,
  headerTextColor: Colors.white,
  selectedDateBackgroundColor: Colors.blue,
  todayBackgroundColor: Colors.orange.withOpacity(0.3),
  sabbathBackgroundColor: Colors.purple.withOpacity(0.2),
  // ... more properties
);
```

## Date Formatting

### Myanmar Date Patterns

```dart
final date = MyanmarCalendar.today();

// Available patterns
'&y'     // Myanmar year (e.g., ၁၃၈၅)
'&M'     // Myanmar month name (e.g., တပေါင်း)
'&P'     // Moon phase (e.g., လဆုတ်)
'&ff'    // Fortnight day (e.g., ၁၀)
'&d'     // Day number
'&w'     // Weekday name
'&Sy'     // Sasana Year (e.g., ၂၅၆၉)

// Example usage
final formatted = date.formatMyanmar('&y ခုနှစ် &M &P &ff');
// Output: ၁၃၈၅ ခုနှစ် တပေါင်း လဆုတ် ၁၀
```

### Western Date Patterns

```dart
// Available patterns
'%Y'     // Year (e.g., 2024)
'%M'     // Month name (e.g., January)
'%d'     // Day (e.g., 01)
'%w'     // Weekday name (e.g., Monday)

// Example usage
final formatted = date.formatWestern('%d %M %Y');
// Output: 01 January 2024
```

## Astrological Information

```dart
final date = MyanmarCalendar.today();

// Moon phases
print('Moon Phase: ${date.moonPhase}'); // 0-3
print('Is Full Moon: ${date.isFullMoon}');
print('Is New Moon: ${date.isNewMoon}');

// Buddhist calendar
print('Sasana Year: ${date.sasanaYear}');
print('Is Sabbath: ${date.isSabbath}');
print('Is Sabbath Eve: ${date.isSabbathEve}');

// Astrological days
print('Yatyaza: ${date.yatyaza}');
print('Pyathada: ${date.pyathada}');
print('Nagahle: ${date.nagahle}');
print('Mahabote: ${date.mahabote}');

// Year information
print('Year Type: ${date.yearType}'); // 0=common, 1=little watat, 2=big watat
print('Is Watat Year: ${date.isWatatYear}');
```

## Holiday Information

```dart
final date = MyanmarCalendar.today();

// All holidays
print('Has Holidays: ${date.hasHolidays}');
print('All Holidays: ${date.allHolidays}');

// By category
print('Public Holidays: ${date.publicHolidays}');
print('Religious Holidays: ${date.religiousHolidays}');
print('Cultural Holidays: ${date.culturalHolidays}');

// Get holiday info directly
final holidayInfo = MyanmarCalendar.getHolidayInfo(date.myanmarDate);
```

## AI Prompt Generation

The package provides a specialized service to generate structured prompts for AI platforms (Gemini, ChatGPT, Claude) based on traditional Burmese astrological knowledge.

### Generating Prompts

```dart
// Generate a horoscope prompt
final prompt = MyanmarCalendar.generateAIPrompt(
  completeDate,
  language: Language.english,
  type: AIPromptType.horoscope,
);

// Copy to clipboard or send to AI
print(prompt);
```

### Prompt Types
- `AIPromptType.horoscope`: General reading and character analysis.
- `AIPromptType.fortuneTelling`: Focus on future trends, wealth, and success.
- `AIPromptType.divination`: Spiritual guidance, inner growth, and overcoming obstacles.

### Sample Prompts

**Horoscope**

```markdown
Please provide a detailed horoscope reading based on the following Myanmar astrological details:

Western Date: Mon 1998-07-27 00:00:00
Myanmar Date: 1360 Wagaung Waxing 04

Nakhat: Elf
Description: Elf Nakhat (De-wa-Nakhat) is associated with grace, beauty, and celestial harmony. It is ideal for peaceful and creative pursuits.

Mahabote: Binga
Characteristics: Binga (The Restless) indicates a character that is energetic, versatile, but may struggle with focus or stability.

Astrological Days:
- Thamanyo: Thamanyo (The Restrainer) is an inauspicious day for starting new ventures or travel.
- Warameittugyi: Warameittugyi (Major Bad Friend) is an inauspicious day particularly for social or collaborative work.
- Yatpote: Yatpote (Rotten Day) is considered poor for activities involving food, agriculture, or durable goods.
- Nagapor: Nagapor (Dragon Burden) is inauspicious for construction or ground-breaking activities.

Naga Head: North

Please analyze these details based on traditional Myanmar astrology and provide insights into personality, career, and health for the near future.
```

**Fortune Telling**

```markdown
Please provide a professional fortune-telling reading based on these Burmese astrological details:

Western Date: Mon 1998-07-27 00:00:00
Myanmar Date: 1360 Wagaung Waxing 04

Nakhat: Elf
Description: Elf Nakhat (De-wa-Nakhat) is associated with grace, beauty, and celestial harmony. It is ideal for peaceful and creative pursuits.

Mahabote: Binga
Characteristics: Binga (The Restless) indicates a character that is energetic, versatile, but may struggle with focus or stability.

Astrological Days:
- Thamanyo: Thamanyo (The Restrainer) is an inauspicious day for starting new ventures or travel.
- Warameittugyi: Warameittugyi (Major Bad Friend) is an inauspicious day particularly for social or collaborative work.
- Yatpote: Yatpote (Rotten Day) is considered poor for activities involving food, agriculture, or durable goods.
- Nagapor: Nagapor (Dragon Burden) is inauspicious for construction or ground-breaking activities.

Naga Head: North

Focus on predicting future trends in wealth, relationships, and success. Provide specific guidance and remedies if applicable according to Burmese tradition.
```

**Divination**

```markdown
Use these astrological indicators for a divination session to provide spiritual guidance:

Western Date: Mon 1998-07-27 00:00:00
Myanmar Date: 1360 Wagaung Waxing 04

Nakhat: Elf
Description: Elf Nakhat (De-wa-Nakhat) is associated with grace, beauty, and celestial harmony. It is ideal for peaceful and creative pursuits.

Mahabote: Binga
Characteristics: Binga (The Restless) indicates a character that is energetic, versatile, but may struggle with focus or stability.

Astrological Days:
- Thamanyo: Thamanyo (The Restrainer) is an inauspicious day for starting new ventures or travel.
- Warameittugyi: Warameittugyi (Major Bad Friend) is an inauspicious day particularly for social or collaborative work.
- Yatpote: Yatpote (Rotten Day) is considered poor for activities involving food, agriculture, or durable goods.
- Nagapor: Nagapor (Dragon Burden) is inauspicious for construction or ground-breaking activities.

Naga Head: North

Provide a deep, intuitive reading focused on the spiritual path, inner growth, and overcoming obstacles.
```

## Date Arithmetic and Utilities

### Basic Operations

```dart
final date = MyanmarCalendar.today();

// Add/subtract days
final tomorrow = date.addDays(1);
final yesterday = date.subtractDays(1);
final nextWeek = date.addDays(7);

// Add time units
final laterToday = date.addHours(3);
final soon = date.addMinutes(30);

// Duration operations
final duration = const Duration(days: 5, hours: 3);
final future = date.add(duration);
```

### Advanced Utilities

```dart
// Find special days
final sabbathDays = MyanmarCalendar.findSabbathDays(1385, 10);
final nextFullMoon = MyanmarCalendar.findNextMoonPhase(date, 1);

// Month information
final monthDates = MyanmarCalendar.getMyanmarMonth(1385, 10);
final westernDates = MyanmarCalendar.getWesternDatesForMyanmarMonth(1385, 10);

// Year information
final isWatat = MyanmarCalendar.isWatatYear(1385);
final yearType = MyanmarCalendar.getYearType(1385);

// Date calculations
final daysBetween = MyanmarCalendar.daysBetween(date1, date2);
final addedMonths = MyanmarCalendar.addMonths(date, 3);
```

## Configuration Options

```dart
MyanmarCalendar.configure(
  language: Language.myanmar,           // Default language
  timezoneOffset: 6.5,                 // Myanmar Standard Time
  sasanaYearType: 0,                   // Sasana year calculation method
  calendarType: 1,                     // Calendar system (0=British, 1=Gregorian)
  gregorianStart: 2361222,             // Julian Day of Gregorian start
);

// Get current configuration
final config = MyanmarCalendar.config;
final diagnostics = MyanmarCalendar.getDiagnostics();
```

## Error Handling and Validation

```dart
// Validate Myanmar dates
final result = MyanmarCalendar.validateMyanmar(1385, 15, 1);
if (!result.isValid) {
  print('Error: ${result.error}');
}

// Quick validation
final isValid = MyanmarCalendar.isValidMyanmar(1385, 10, 1);

// Safe parsing
final parsed = MyanmarCalendar.parseMyanmar('1385/10/1');
if (parsed != null) {
  print('Parsed successfully: ${parsed.formatMyanmar()}');
} else {
  print('Failed to parse date string');
}
```

## Advanced Examples

### Custom Calendar Cell

```dart
Widget customCellBuilder(BuildContext context, CompleteDate date) {
  return Container(
    decoration: BoxDecoration(
      color: date.hasHolidays ? Colors.red.withOpacity(0.1) : null,
      border: date.isToday
        ? Border.all(color: Colors.blue, width: 2)
        : null,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('${date.westernDay}'),
        if (date.isFullMoon) Icon(Icons.brightness_1, size: 12),
        if (date.hasHolidays) Text('H', style: TextStyle(fontSize: 8)),
      ],
    ),
  );
}
```

### Batch Date Processing

```dart
// Convert multiple dates
final westernDates = [
  DateTime(2024, 1, 1),
  DateTime(2024, 2, 1),
  DateTime(2024, 3, 1),
];

final myanmarDates = MyanmarCalendar.convertWesternDates(westernDates);
final completeDates = MyanmarCalendar.getCompleteDates(westernDates);

// Process Myanmar date data
final dateMaps = [
  {'year': 1385, 'month': 10, 'day': 1},
  {'year': 1385, 'month': 10, 'day': 15},
];
final converted = MyanmarCalendar.convertMyanmarDates(dateMaps);
```

### Using with State Management

```dart
class CalendarController extends ChangeNotifier {
  MyanmarDateTime _selectedDate = MyanmarCalendar.today();
  Language _language = Language.english;

  MyanmarDateTime get selectedDate => _selectedDate;
  Language get language => _language;

  void selectDate(MyanmarDateTime date) {
    _selectedDate = date;
    notifyListeners();
  }

  void changeLanguage(Language language) {
    _language = language;
    MyanmarCalendar.setLanguage(language);
    notifyListeners();
  }
}
```

## Error Handling

The package includes comprehensive custom exception classes with detailed error messages and recovery suggestions.

### Exception Types

```dart
try {
  final date = MyanmarCalendar.fromMyanmar(1385, 15, 1);  // Invalid month
} on InvalidMyanmarDateException catch (e) {
  print('Error: ${e.message}');
  print('Suggestion: ${e.details!['suggestion']}');
  // Output: Myanmar month must be between 1 and 13...
} on DateConversionException catch (e) {
  print('Conversion failed: ${e.message}');
} catch (e) {
  print('Unexpected error: $e');
}
```

### Available Exceptions

- `InvalidMyanmarDateException` - Invalid Myanmar date components
- `InvalidWesternDateException` - Invalid Western date components
- `DateConversionException` - Date conversion failures
- `DateParseException` - Date string parsing failures
- `InvalidConfigurationException` - Invalid configuration parameters
- `DateOutOfRangeException` - Dates outside supported ranges
- `CacheException` - Caching system issues
- `AstrologicalCalculationException` - Astrological calculation failures
- `HolidayCalculationException` - Holiday calculation failures

For detailed error handling guide, see [error_handling.md](error_handling.md).

## Performance Utilities

### LRU Cache

General-purpose cache with automatic eviction (Note: Use built-in `CalendarCache` for calendar dates).

```dart
final cache = LRUCache<String, dynamic>(maxSize: 100);

// Store with optional TTL
cache.put('key', value, ttl: Duration(minutes: 30));

// Retrieve
final value = cache.get('key');

// Statistics
final stats = cache.getStatistics();
print('Hit rate: ${stats['hitRate']}%');
```

### Performance Monitoring

Track operation performance to identify bottlenecks.

```dart
// Measure synchronous operations
final result = PerformanceMonitor.measure('date_conversion', () {
  return MyanmarCalendar.fromWestern(2024, 1, 1);
});

// Measure async operations
final asyncResult = await PerformanceMonitor.measureAsync(
  'fetch_data',
  () async => await fetchData(),
);

// Get statistics
final stats = PerformanceMonitor.getOperationStats('date_conversion');
print('Average: ${stats!['avgMs']}ms');

// Print report
PerformanceMonitor.printReport();
```

### Batch Processing

Process large datasets without blocking the UI.

```dart
final dates = List.generate(1000, (i) => DateTime(2024, 1, i + 1));

final myanmarDates = await BatchOptimizer.processBatch(
  dates,
  (date) => MyanmarCalendar.fromDateTime(date),
  batchSize: 50,
  delayBetweenBatches: Duration(milliseconds: 10),
);
```

### Debouncer & Throttler

Control operation frequency for better performance.

```dart
// Debouncer - delay until calls stop
final debouncer = Debouncer(delay: Duration(milliseconds: 300));
TextField(
  onChanged: (query) => debouncer.run(() => search(query)),
)

// Throttler - limit frequency
final throttler = Throttler(duration: Duration(milliseconds: 100));
NotificationListener<ScrollNotification>(
  onNotification: (notification) {
    throttler.run(() => updateVisibleDates());
    return false;
  },
)
```

For complete performance guide, see [performance.md](performance.md).

## Accessibility

The package includes comprehensive accessibility features for users with disabilities.

### Automatic Accessibility

The `OptimizedCalendarCell` and calendar widgets include accessibility by default:

- ✅ Screen reader support with semantic labels
- ✅ Keyboard navigation ready
- ✅ High contrast mode support
- ✅ Text scaling support

### Keyboard Navigation

```dart
Focus(
  onKeyEvent: (node, event) {
    return CalendarKeyboardHandler.handleKeyEvent(
      node,
      event,
      onArrowUp: () => moveSelection(-7),      // Previous week
      onArrowDown: () => moveSelection(7),     // Next week
      onArrowLeft: () => moveSelection(-1),    // Previous day
      onArrowRight: () => moveSelection(1),    // Next day
      onEnter: () => selectDate(),
      onSpace: () => selectDate(),
      onHome: () => goToToday(),
      onEnd: () => goToMonthEnd(),
      onEscape: () => Navigator.pop(context),
    );
  },
  child: MyanmarCalendarWidget(...),
)
```

### Screen Reader Announcements

```dart
// Announce to screen reader
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
```

### High Contrast Support

```dart
// Check high contrast mode
final isHighContrast = HighContrastHelper.isHighContrastEnabled(context);

// Get high contrast color
final color = HighContrastHelper.getHighContrastColor(
  context,
  normalColor: Colors.blue,
  highContrastColor: Colors.black,
);
```

### Text Scaling

```dart
// Get scaled font size
final fontSize = TextScalingHelper.getScaledFontSize(
  context,
  14.0,
  maxScale: 2.0,
);

// Get accessible text style
final textStyle = TextScalingHelper.getAccessibleTextStyle(
  context,
  TextStyle(fontSize: 14),
  minFontSize: 12,
  maxFontSize: 24,
);
```

For complete accessibility guide, see [accessibility.md](accessibility.md).

## Performance Tips

1. **Caching**: The package automatically caches calculated dates and astrological information. See [Caching System Docs](cache.md).

2. **Batch Operations**: Use batch methods for processing multiple dates:

   ```dart
   final dates = MyanmarCalendar.convertWesternDates(westernDates);
   ```

## Troubleshooting

### Common Issues

1. **Date Validation Errors**

   ```dart
   // Check if date is valid before using
   if (MyanmarCalendar.isValidMyanmar(year, month, day)) {
     final date = MyanmarCalendar.fromMyanmar(year, month, day);
   }
   ```

2. **Language Display Issues**

   ```dart
   // Ensure proper font support for Myanmar text
   MaterialApp(
     theme: ThemeData(
       fontFamily: 'Pyidaungsu', // Use Myanmar-compatible font
     ),
   )
   ```

3. **Timezone Issues**

   ```dart
   // Configure timezone for accurate calculations
   MyanmarCalendar.configure(timezoneOffset: 6.5); // Myanmar time
   ```

### Debugging

```dart
// Get diagnostic information
final diagnostics = MyanmarCalendar.getDiagnostics();
print('Package Info: ${diagnostics['packageInfo']}');
print('Configuration: ${diagnostics['configuration']}');
print('Supported Languages: ${diagnostics['supportedLanguages']}');

// Reset configuration if needed
MyanmarCalendar.reset();
```

## Acknowledgements

The calculation algorithms are based on the original work by
[Dr Yan Naing Aye](https://github.com/yan9a/mmcal) in Javascript and C++.
I converted and adapted the implementation for Dart/Flutter.

## API Reference

For complete API documentation, visit [pub.dev documentation](https://pub.dev/documentation/flutter_mmcalendar/latest/).

## Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for version history and updates.

## Support

- 📧 Email: [kyawzayartun.contact@gmail.com](mailto:kyawzayartun.contact@gmail.com)
- 🐛 Issues: [GitHub Issues](https://github.com/mixin27/flutter-mmcalendar/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/mixin27/flutter-mmcalendar/discussions)
