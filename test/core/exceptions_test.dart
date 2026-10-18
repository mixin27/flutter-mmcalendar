import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

/// Tests for custom exception classes
void main() {
  group('InvalidMyanmarDateException', () {
    test('creates exception with correct message and details', () {
      final exception = InvalidMyanmarDateException(
        year: 1385,
        month: 15,
        day: 1,
      );

      expect(exception.message, contains('Invalid Myanmar date'));
      expect(exception.year, equals(1385));
      expect(exception.month, equals(15));
      expect(exception.day, equals(1));
      expect(exception.details, isNotNull);
      expect(exception.details!['suggestion'], contains('Myanmar months are'));
    });

    test('provides helpful suggestion for invalid month', () {
      final exception = InvalidMyanmarDateException(
        year: 1385,
        month: 15,
        day: 1,
      );

      expect(
        exception.details!['suggestion'],
        contains('Myanmar months are 0 (First Waso'),
      );
    });

    test('provides helpful suggestion for invalid day', () {
      final exception = InvalidMyanmarDateException(
        year: 1385,
        month: 10,
        day: 35,
      );

      expect(
        exception.details!['suggestion'],
        contains('Myanmar days are 1 to 30'),
      );
    });

    test('toString includes all relevant information', () {
      final exception = InvalidMyanmarDateException(
        year: 1385,
        month: 15,
        day: 1,
      );

      final str = exception.toString();
      expect(str, contains('InvalidMyanmarDateException'));
      expect(str, contains('Invalid Myanmar date'));
      expect(str, contains('Details:'));
    });
  });

  group('InvalidWesternDateException', () {
    test('creates exception with correct message and details', () {
      final exception = InvalidWesternDateException(
        year: 2024,
        month: 13,
        day: 1,
      );

      expect(exception.message, contains('Invalid Western date'));
      expect(exception.year, equals(2024));
      expect(exception.month, equals(13));
      expect(exception.day, equals(1));
    });

    test('provides helpful suggestion for invalid month', () {
      final exception = InvalidWesternDateException(
        year: 2024,
        month: 13,
        day: 1,
      );

      expect(
        exception.details!['suggestion'],
        contains('Western month must be between 1 and 12'),
      );
    });
  });

  group('DateParseException', () {
    test('creates exception with date string and format', () {
      final exception = DateParseException(
        dateString: '1385-10-1',
        expectedFormat: 'YYYY/MM/DD',
      );

      expect(exception.dateString, equals('1385-10-1'));
      expect(exception.expectedFormat, equals('YYYY/MM/DD'));
      expect(exception.message, contains('Failed to parse'));
    });

    test('records the input and expected format', () {
      final exception = DateParseException(
        dateString: 'invalid',
        expectedFormat: 'YYYY/MM/DD',
      );

      expect(exception.details!['dateString'], 'invalid');
      expect(exception.details!['expectedFormat'], 'YYYY/MM/DD');
      // Also a FormatException, so existing catch blocks still work.
      expect(exception, isA<FormatException>());
    });
  });

  group('InvalidConfigurationException', () {
    test('creates exception for timezone offset', () {
      final exception = InvalidConfigurationException(
        parameter: 'timezoneOffset',
        value: 20.0,
      );

      expect(exception.parameter, equals('timezoneOffset'));
      expect(exception.value, equals(20.0));
      expect(
        exception.details!['suggestion'],
        contains('Timezone offset must be between'),
      );
    });

    test('creates exception for sasana year type', () {
      final exception = InvalidConfigurationException(
        parameter: 'sasanaYearType',
        value: 5,
      );

      expect(
        exception.details!['suggestion'],
        contains('Sasana year type must be 0, 1 or 2'),
      );
    });

    test('falls back to a generic suggestion', () {
      final exception = InvalidConfigurationException(
        parameter: 'language',
        value: 'invalid',
      );

      expect(
        exception.details!['suggestion'],
        contains('check the documentation'),
      );
    });
  });
}
