/// Tests for custom exception classes
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_mmcalendar/src/exceptions/calendar_exceptions.dart';

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
      expect(
        exception.details!['suggestion'],
        contains('month must be between'),
      );
    });

    test('provides helpful suggestion for invalid month', () {
      final exception = InvalidMyanmarDateException(
        year: 1385,
        month: 15,
        day: 1,
      );

      expect(
        exception.details!['suggestion'],
        contains('Myanmar month must be between 1 and 13'),
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
        contains('Myanmar day must be between 1 and 30'),
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

  group('DateConversionException', () {
    test('creates exception for Myanmar to Western conversion', () {
      final exception = DateConversionException.myanmarToWestern(
        year: 1385,
        month: 10,
        day: 1,
      );

      expect(exception.conversionType, equals('Myanmar to Western'));
      expect(exception.message, contains('Failed to convert'));
      expect(exception.details!['myanmarYear'], equals(1385));
    });

    test('creates exception for Western to Myanmar conversion', () {
      final exception = DateConversionException.westernToMyanmar(
        year: 2024,
        month: 1,
        day: 1,
      );

      expect(exception.conversionType, equals('Western to Myanmar'));
      expect(exception.message, contains('Failed to convert'));
      expect(exception.details!['westernYear'], equals(2024));
    });

    test('creates exception for Julian Day conversion', () {
      final exception = DateConversionException.julianDay(julianDay: 2460000.5);

      expect(exception.conversionType, equals('Julian Day'));
      expect(exception.message, contains('Julian Day Number'));
      expect(exception.details!['julianDay'], equals(2460000.5));
    });

    test('includes original error when provided', () {
      final originalError = Exception('Original error');
      final exception = DateConversionException.myanmarToWestern(
        year: 1385,
        month: 10,
        day: 1,
        originalError: originalError,
      );

      expect(exception.originalError, equals(originalError));
      expect(exception.toString(), contains('Caused by:'));
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

    test('provides helpful suggestion', () {
      final exception = DateParseException(
        dateString: 'invalid',
        expectedFormat: 'YYYY/MM/DD',
      );

      expect(
        exception.details!['suggestion'],
        contains('Ensure date string matches format'),
      );
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
        contains('Sasana year type must be 0, 1, or 2'),
      );
    });

    test('creates exception for language', () {
      final exception = InvalidConfigurationException(
        parameter: 'language',
        value: 'invalid',
      );

      expect(
        exception.details!['suggestion'],
        contains('Language must be one of'),
      );
    });
  });

  group('DateOutOfRangeException', () {
    test('creates exception with min and max dates', () {
      final date = DateTime(2025, 1, 1);
      final minDate = DateTime(2020, 1, 1);
      final maxDate = DateTime(2024, 12, 31);

      final exception = DateOutOfRangeException(
        date: date,
        minDate: minDate,
        maxDate: maxDate,
      );

      expect(exception.date, equals(date));
      expect(exception.minDate, equals(minDate));
      expect(exception.maxDate, equals(maxDate));
      expect(
        exception.details!['suggestion'],
        contains('Date must be between'),
      );
    });

    test('creates exception with only min date', () {
      final date = DateTime(2019, 1, 1);
      final minDate = DateTime(2020, 1, 1);

      final exception = DateOutOfRangeException(date: date, minDate: minDate);

      expect(
        exception.details!['suggestion'],
        contains('Date must be on or after'),
      );
    });

    test('creates exception with only max date', () {
      final date = DateTime(2025, 1, 1);
      final maxDate = DateTime(2024, 12, 31);

      final exception = DateOutOfRangeException(date: date, maxDate: maxDate);

      expect(
        exception.details!['suggestion'],
        contains('Date must be on or before'),
      );
    });
  });

  group('CacheException', () {
    test('creates exception with operation details', () {
      final exception = CacheException(
        operation: 'put',
        message: 'Failed to put value in cache',
      );

      expect(exception.operation, equals('put'));
      expect(exception.message, contains('Failed to put value'));
    });
  });

  group('AstrologicalCalculationException', () {
    test('creates exception with calculation type', () {
      final exception = AstrologicalCalculationException(
        calculationType: 'moon phase',
        message: 'Failed to calculate moon phase',
      );

      expect(exception.calculationType, equals('moon phase'));
      expect(exception.message, contains('Failed to calculate'));
    });
  });

  group('HolidayCalculationException', () {
    test('creates exception with year and month', () {
      final exception = HolidayCalculationException(
        year: 1385,
        month: 10,
        message: 'Failed to calculate holidays',
      );

      expect(exception.year, equals(1385));
      expect(exception.month, equals(10));
      expect(exception.message, contains('Failed to calculate'));
    });
  });
}
