# Error Handling Guide

## Overview

The `flutter_mmcalendar` package includes comprehensive custom exception classes that provide detailed error messages and recovery suggestions, making it easier to handle errors gracefully in your application.

## Exception Hierarchy

All custom exceptions extend from `MyanmarCalendarException`:

```
MyanmarCalendarException (abstract base)
├── InvalidMyanmarDateException
├── InvalidWesternDateException
├── DateConversionException
├── DateParseException
├── InvalidConfigurationException
├── DateOutOfRangeException
├── CacheException
├── AstrologicalCalculationException
└── HolidayCalculationException
```

---

## Exception Types

### InvalidMyanmarDateException

Thrown when Myanmar date components are invalid.

```dart
try {
  final date = MyanmarCalendar.fromMyanmar(1385, 15, 1);  // Invalid month
} on InvalidMyanmarDateException catch (e) {
  print('Error: ${e.message}');
  print('Details: ${e.details}');
  print('Suggestion: ${e.details!['suggestion']}');
}
```

**Example output:**
```
Error: Invalid Myanmar date: Year 1385, Month 15, Day 1
Details: {
  year: 1385,
  month: 15,
  day: 1,
  suggestion: Myanmar month must be between 1 and 13 (or 14 in watat years)...
}
```

### InvalidWesternDateException

Thrown when Western date components are invalid.

```dart
try {
  final date = MyanmarCalendar.fromWestern(2024, 13, 1);  // Invalid month
} on InvalidWesternDateException catch (e) {
  print('Error: ${e.message}');
  print('Suggestion: ${e.details!['suggestion']}');
}
```

### DateConversionException

Thrown when date conversion fails. Includes factory methods for different conversion types.

```dart
// Myanmar to Western conversion failure
try {
  final date = MyanmarCalendar.fromMyanmar(1385, 10, 1);
} on DateConversionException catch (e) {
  print('Conversion failed: ${e.message}');
  print('Type: ${e.details!['conversionType']}');
  if (e.originalError != null) {
    print('Caused by: ${e.originalError}');
  }
}

// Factory methods available:
// - DateConversionException.myanmarToWestern(...)
// - DateConversionException.westernToMyanmar(...)
// - DateConversionException.julianDay(...)
```

### DateParseException

Thrown when parsing date strings fails.

```dart
try {
  final date = MyanmarCalendar.parseMyanmar('invalid-date');
} on DateParseException catch (e) {
  print('Parse error: ${e.message}');
  print('Input: ${e.details!['dateString']}');
  print('Expected format: ${e.details!['expectedFormat']}');
}
```

### InvalidConfigurationException

Thrown when configuration parameters are invalid.

```dart
try {
  MyanmarCalendar.configure(timezoneOffset: 25.0);  // Out of range
} on InvalidConfigurationException catch (e) {
  print('Config error: ${e.message}');
  print('Parameter: ${e.details!['parameter']}');
  print('Value: ${e.details!['value']}');
  print('Suggestion: ${e.details!['suggestion']}');
}
```

### DateOutOfRangeException

Thrown when a date falls outside supported ranges.

```dart
try {
  final date = MyanmarCalendar.fromWestern(1000, 1, 1);  // Too old
} on DateOutOfRangeException catch (e) {
  print('Out of range: ${e.message}');
  print('Min date: ${e.details!['minDate']}');
  print('Max date: ${e.details!['maxDate']}');
}
```

### CacheException

Thrown when cache operations fail.

```dart
try {
  // Cache operation
} on CacheException catch (e) {
  print('Cache error: ${e.message}');
  print('Operation: ${e.details!['operation']}');
}
```

### AstrologicalCalculationException

Thrown when astrological calculations fail.

```dart
try {
  // Astrological calculation
} on AstrologicalCalculationException catch (e) {
  print('Calculation error: ${e.message}');
  print('Calculation type: ${e.details!['calculationType']}');
}
```

### HolidayCalculationException

Thrown when holiday calculations fail.

```dart
try {
  // Holiday calculation
} on HolidayCalculationException catch (e) {
  print('Holiday error: ${e.message}');
  print('Holiday type: ${e.details!['holidayType']}');
}
```

---

## Best Practices

### 1. Catch Specific Exceptions

```dart
// ✅ Good: Catch specific exceptions
try {
  final date = MyanmarCalendar.fromMyanmar(year, month, day);
} on InvalidMyanmarDateException catch (e) {
  // Handle invalid date
  showError('Invalid date: ${e.details!['suggestion']}');
} on DateConversionException catch (e) {
  // Handle conversion error
  showError('Conversion failed: ${e.message}');
} catch (e) {
  // Handle unexpected errors
  logError('Unexpected error', e);
}

// ❌ Bad: Catch all exceptions
try {
  final date = MyanmarCalendar.fromMyanmar(year, month, day);
} catch (e) {
  print('Error: $e');  // Not helpful
}
```

### 2. Use Exception Details

```dart
// ✅ Good: Use exception details for user feedback
try {
  final date = MyanmarCalendar.fromMyanmar(year, month, day);
} on InvalidMyanmarDateException catch (e) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Invalid Date'),
      content: Text(e.details!['suggestion']),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('OK'),
        ),
      ],
    ),
  );
}

// ❌ Bad: Generic error message
try {
  final date = MyanmarCalendar.fromMyanmar(year, month, day);
} catch (e) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Error'),
      content: Text('Something went wrong'),  // Not helpful
    ),
  );
}
```

### 3. Log Original Errors

```dart
// ✅ Good: Log original error for debugging
try {
  final date = MyanmarCalendar.fromMyanmar(year, month, day);
} on DateConversionException catch (e, stackTrace) {
  logger.error(
    'Date conversion failed',
    error: e,
    stackTrace: stackTrace,
    details: {
      'originalError': e.originalError,
      'conversionType': e.details!['conversionType'],
    },
  );
  showError('Unable to convert date');
}

// ❌ Bad: Lose error context
try {
  final date = MyanmarCalendar.fromMyanmar(year, month, day);
} catch (e) {
  print('Error: $e');  // Lost stack trace and details
}
```

### 4. Provide Recovery Options

```dart
// ✅ Good: Provide recovery options
try {
  final date = MyanmarCalendar.fromMyanmar(year, month, day);
} on InvalidMyanmarDateException catch (e) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Invalid Date'),
      content: Text(e.details!['suggestion']),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            // Reset to today
            setState(() => selectedDate = DateTime.now());
          },
          child: Text('Use Today'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
      ],
    ),
  );
}
```

---

## Common Scenarios

### Validating User Input

```dart
Future<void> createDate(int year, int month, int day) async {
  try {
    final date = MyanmarCalendar.fromMyanmar(year, month, day);
    // Use date
  } on InvalidMyanmarDateException catch (e) {
    // Show validation error to user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.details!['suggestion']),
        backgroundColor: Colors.red,
      ),
    );
  } on DateConversionException catch (e) {
    // Log conversion error
    logger.error('Date conversion failed', error: e);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Unable to create date')),
    );
  }
}
```

### Parsing Date Strings

```dart
MyanmarDateTime? parseDateSafely(String dateString) {
  try {
    return MyanmarCalendar.parseMyanmar(dateString);
  } on DateParseException catch (e) {
    logger.warning(
      'Failed to parse date',
      details: {
        'input': e.details!['dateString'],
        'expectedFormat': e.details!['expectedFormat'],
      },
    );
    return null;
  }
}
```

### Configuration Validation

```dart
void configureCalendar(double timezoneOffset) {
  try {
    MyanmarCalendar.configure(timezoneOffset: timezoneOffset);
  } on InvalidConfigurationException catch (e) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Invalid Configuration'),
        content: Text(
          '${e.message}\n\n${e.details!['suggestion']}',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Use default
              MyanmarCalendar.configure(timezoneOffset: 6.5);
            },
            child: Text('Use Default'),
          ),
        ],
      ),
    );
  }
}
```

---

## Exception Properties

All exceptions have these properties:

```dart
class MyanmarCalendarException {
  final String message;              // Human-readable error message
  final Map<String, dynamic>? details;  // Additional error details
  final dynamic originalError;       // Original error (if any)
  final StackTrace? stackTrace;      // Stack trace (if any)
}
```

### Accessing Exception Details

```dart
try {
  // Some operation
} on InvalidMyanmarDateException catch (e) {
  print('Message: ${e.message}');
  print('Year: ${e.details!['year']}');
  print('Month: ${e.details!['month']}');
  print('Day: ${e.details!['day']}');
  print('Suggestion: ${e.details!['suggestion']}');
}
```

---

## Testing Error Handling

```dart
testWidgets('shows error for invalid date', (tester) async {
  await tester.pumpWidget(MyApp());

  // Enter invalid date
  await tester.enterText(find.byKey(Key('year')), '1385');
  await tester.enterText(find.byKey(Key('month')), '15');  // Invalid
  await tester.enterText(find.byKey(Key('day')), '1');

  await tester.tap(find.byKey(Key('submit')));
  await tester.pump();

  // Verify error message is shown
  expect(
    find.text('Myanmar month must be between 1 and 13'),
    findsOneWidget,
  );
});
```

---

## Migration from Generic Exceptions

If you're upgrading from a previous version:

### Before (Generic Exceptions)

```dart
try {
  final date = MyanmarCalendar.fromMyanmar(year, month, day);
} catch (e) {
  print('Error: $e');  // Generic error
}
```

### After (Custom Exceptions)

```dart
try {
  final date = MyanmarCalendar.fromMyanmar(year, month, day);
} on InvalidMyanmarDateException catch (e) {
  print('Error: ${e.message}');
  print('Suggestion: ${e.details!['suggestion']}');
} on DateConversionException catch (e) {
  print('Conversion failed: ${e.message}');
}
```

---

## API Reference

### MyanmarCalendarException (Base Class)

```dart
abstract class MyanmarCalendarException implements Exception {
  final String message;
  final Map<String, dynamic>? details;
  final dynamic originalError;
  final StackTrace? stackTrace;
}
```

### All Exception Classes

- `InvalidMyanmarDateException(year, month, day)`
- `InvalidWesternDateException(year, month, day)`
- `DateConversionException(message, {details, originalError})`
  - `DateConversionException.myanmarToWestern(...)`
  - `DateConversionException.westernToMyanmar(...)`
  - `DateConversionException.julianDay(...)`
- `DateParseException(dateString, expectedFormat, {originalError})`
- `InvalidConfigurationException(parameter, value, {suggestion})`
- `DateOutOfRangeException(date, {minDate, maxDate})`
- `CacheException(message, operation, {originalError})`
- `AstrologicalCalculationException(message, calculationType, {originalError})`
- `HolidayCalculationException(message, holidayType, {originalError})`
