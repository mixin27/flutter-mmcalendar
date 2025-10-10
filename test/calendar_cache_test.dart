// ignore_for_file: avoid_redundant_argument_values, prefer_final_locals, avoid_print

import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Basic Cache Tests', () {
    setUp(() {
      // Reset before each test
      MyanmarCalendar.configureCache(const CacheConfig(enableCaching: true));
      MyanmarCalendar.clearCache();
      MyanmarCalendar.resetCacheStatistics();
    });

    test('Cache is enabled by default', () {
      final cache = CalendarCache.independent();
      expect(cache.isEnabled, true);
    });

    test('Cache can be disabled', () {
      final cache = CalendarCache.independent(
        config: const CacheConfig.disabled(),
      );
      expect(cache.isEnabled, false);
    });

    test('Cache stores CompleteDate', () {
      final service = MyanmarCalendarService.withIndependentCache(
        config: const CalendarConfig(),
        cacheConfig: CacheConfig(enableCaching: true),
      );

      final dateTime = DateTime(2024, 1, 1);

      // First call
      final completeDate1 = service.getCompleteDate(dateTime);

      // Second call - same date
      final completeDate2 = service.getCompleteDate(dateTime);

      // Should return same values
      expect(completeDate1.western.year, completeDate2.western.year);
      expect(completeDate1.myanmar.year, completeDate2.myanmar.year);
    });

    // test('Cache clears successfully', () {
    //   MyanmarCalendar.configureCache(const CacheConfig(enableCaching: true));

    //   // Add some data
    //   for (var i = 0; i < 5; i++) {
    //     MyanmarCalendar.fromWestern(2024, 1, i + 1);
    //   }

    //   var stats = MyanmarCalendar.getCacheStatistics();
    //   var entriesBefore = stats['total_memory_entries'] as int;
    //   expect(entriesBefore, greaterThan(0));

    //   // Clear cache
    //   MyanmarCalendar.clearCache();

    //   stats = MyanmarCalendar.getCacheStatistics();
    //   var entriesAfter = stats['total_memory_entries'] as int;
    //   expect(entriesAfter, 0);
    // });

    // test('Statistics track requests', () {
    //   MyanmarCalendar.resetCacheStatistics();
    //   MyanmarCalendar.configureCache(const CacheConfig(enableCaching: true));

    //   // Make some requests
    //   MyanmarCalendar.fromWestern(2024, 1, 1);
    //   MyanmarCalendar.fromWestern(2024, 1, 2);
    //   MyanmarCalendar.fromWestern(2024, 1, 3);

    //   final stats = MyanmarCalendar.getCacheStatistics();
    //   final totalRequests = stats['total_requests'] as int;
    //   final hits = stats['hits'] as int;
    //   final misses = stats['misses'] as int;

    //   expect(totalRequests, greaterThan(0));
    //   expect(totalRequests, equals(hits + misses));
    // });

    test('Warm up cache loads data', () {
      MyanmarCalendar.warmUpCache(
        startDate: DateTime(2024, 1, 1),
        endDate: DateTime(2024, 1, 10),
      );

      final stats = MyanmarCalendar.getCacheStatistics();
      final totalEntries = stats['total_memory_entries'] as int;

      expect(totalEntries, greaterThan(0));
    });

    test('Different cache configs have different sizes', () {
      final highPerf = CalendarCache.independent(
        config: const CacheConfig.highPerformance(),
      );

      final memEfficient = CalendarCache.independent(
        config: const CacheConfig.memoryEfficient(),
      );

      final highPerfStats = highPerf.getStatistics();
      final memEfficientStats = memEfficient.getStatistics();

      final highPerfMax =
          (highPerfStats['caches'] as Map)['complete_date']['maxSize'] as int;
      final memEfficientMax =
          (memEfficientStats['caches'] as Map)['complete_date']['maxSize']
              as int;

      expect(highPerfMax, greaterThan(memEfficientMax));
    });

    test('Disabled cache does not store data', () {
      final service = MyanmarCalendarService.withIndependentCache(
        config: const CalendarConfig(),
        cacheConfig: CacheConfig.disabled(),
      );

      // Add dates
      for (var i = 0; i < 5; i++) {
        service.getCompleteDate(DateTime(2024, 1, i + 1));
      }

      final stats = service.getCacheStatistics();
      final enabled = stats['enabled'] as bool;
      final totalEntries = stats['total_memory_entries'] as int;

      expect(enabled, false);
      expect(totalEntries, 0);
    });

    test('Cache survives multiple accesses', () {
      final date = DateTime(2024, 1, 1);

      // Access same date multiple times
      for (var i = 0; i < 10; i++) {
        final result = MyanmarCalendar.fromDateTime(date);
        expect(result.westernYear, 2024);
      }

      final stats = MyanmarCalendar.getCacheStatistics();
      final totalEntries = stats['total_memory_entries'] as int;

      expect(totalEntries, greaterThan(0));
    });

    // test('Reset statistics clears counters', () {
    //   // Make some requests
    //   MyanmarCalendar.fromWestern(2024, 1, 1);
    //   MyanmarCalendar.fromWestern(2024, 1, 2);

    //   var stats = MyanmarCalendar.getCacheStatistics();
    //   var totalBefore = stats['total_requests'] as int;
    //   expect(totalBefore, greaterThan(0));

    //   // Reset
    //   MyanmarCalendar.resetCacheStatistics();

    //   stats = MyanmarCalendar.getCacheStatistics();
    //   var totalAfter = stats['total_requests'] as int;
    //   expect(totalAfter, 0);
    // });

    test('Cache works with today() method', () {
      // Call today multiple times
      final today1 = MyanmarCalendar.today();
      final today2 = MyanmarCalendar.today();

      // Should return same day
      expect(today1.westernYear, today2.westernYear);
      expect(today1.westernMonth, today2.westernMonth);
      expect(today1.westernDay, today2.westernDay);
    });

    test('Cache handles date range', () {
      // Create a range of dates
      for (var i = 1; i <= 10; i++) {
        final date = MyanmarCalendar.fromWestern(2024, 1, i);
        expect(date.westernDay, i);
      }

      final stats = MyanmarCalendar.getCacheStatistics();
      final totalEntries = stats['total_memory_entries'] as int;

      expect(totalEntries, greaterThan(0));
    });

    test('Reconfigure creates new cache', () {
      // Use default config
      MyanmarCalendar.configureCache(const CacheConfig());
      MyanmarCalendar.fromWestern(2024, 1, 1);

      var stats = MyanmarCalendar.getCacheStatistics();
      var defaultMax =
          (stats['caches'] as Map)['complete_date']['maxSize'] as int;

      // Reconfigure to high performance
      MyanmarCalendar.configureCache(const CacheConfig.highPerformance());

      stats = MyanmarCalendar.getCacheStatistics();
      var highPerfMax =
          (stats['caches'] as Map)['complete_date']['maxSize'] as int;

      // Should have different max sizes
      expect(highPerfMax, greaterThan(defaultMax));
    });

    test('Multiple services can coexist', () {
      final service1 = MyanmarCalendarService.withIndependentCache(
        config: const CalendarConfig(),
        cacheConfig: CacheConfig(enableCaching: true),
      );

      final service2 = MyanmarCalendarService.withIndependentCache(
        config: const CalendarConfig(),
        cacheConfig: CacheConfig.memoryEfficient(),
      );

      // Both should work independently
      final date1 = service1.getCompleteDate(DateTime(2024, 1, 1));
      final date2 = service2.getCompleteDate(DateTime(2024, 1, 1));

      expect(date1.western.year, date2.western.year);
    });

    test('Cache statistics have correct structure', () {
      final stats = MyanmarCalendar.getCacheStatistics();

      // Check required fields exist
      expect(stats.containsKey('enabled'), true);
      expect(stats.containsKey('hits'), true);
      expect(stats.containsKey('misses'), true);
      expect(stats.containsKey('total_requests'), true);
      expect(stats.containsKey('hit_rate_percent'), true);
      expect(stats.containsKey('caches'), true);
      expect(stats.containsKey('total_memory_entries'), true);

      // Check types
      expect(stats['enabled'], isA<bool>());
      expect(stats['hits'], isA<int>());
      expect(stats['misses'], isA<int>());
      expect(stats['total_requests'], isA<int>());
      expect(stats['hit_rate_percent'], isA<String>());
      expect(stats['caches'], isA<Map>());
      expect(stats['total_memory_entries'], isA<int>());
    });

    test('Cache handles edge case dates', () {
      // Test leap year
      final leapDate = MyanmarCalendar.fromWestern(2024, 2, 29);
      expect(leapDate.westernDay, 29);

      // Test year boundary
      final endOfYear = MyanmarCalendar.fromWestern(2024, 12, 31);
      expect(endOfYear.westernMonth, 12);
      expect(endOfYear.westernDay, 31);

      // Test start of year
      final startOfYear = MyanmarCalendar.fromWestern(2024, 1, 1);
      expect(startOfYear.westernMonth, 1);
      expect(startOfYear.westernDay, 1);
    });
  });

  group('Cache Integration Tests', () {
    setUp(() {
      MyanmarCalendar.configureCache(const CacheConfig(enableCaching: true));
      MyanmarCalendar.clearCache();
      MyanmarCalendar.resetCacheStatistics();
    });

    test('Cache works with addDays', () {
      final today = MyanmarCalendar.today();

      // Add days
      for (var i = 1; i <= 5; i++) {
        final futureDate = today.addDays(i);
        expect(futureDate.westernDay, greaterThan(today.westernDay - 1));
      }

      final stats = MyanmarCalendar.getCacheStatistics();
      expect(stats['total_memory_entries'], greaterThan(0));
    });

    test('Cache works with date conversion', () {
      final westernDate = DateTime(2024, 1, 15);
      final myanmarDate = MyanmarCalendar.fromDateTime(westernDate);

      // Convert back
      final backToWestern = myanmarDate.toDateTime();

      expect(backToWestern.year, westernDate.year);
      expect(backToWestern.month, westernDate.month);
      expect(backToWestern.day, westernDate.day);
    });

    // test('Cache performance with repeated access', () {
    //   final date = DateTime(2024, 1, 1);

    //   // First access
    //   final stopwatch1 = Stopwatch()..start();
    //   MyanmarCalendar.fromDateTime(date);
    //   stopwatch1.stop();

    //   // Reset stats to measure hits
    //   MyanmarCalendar.resetCacheStatistics();

    //   // Repeated accesses
    //   final stopwatch2 = Stopwatch()..start();
    //   for (var i = 0; i < 100; i++) {
    //     MyanmarCalendar.fromDateTime(date);
    //   }
    //   stopwatch2.stop();

    //   // Verify it completed
    //   expect(stopwatch1.elapsedMicroseconds, greaterThan(0));
    //   expect(stopwatch2.elapsedMicroseconds, greaterThan(0));

    //   // Check cache was used
    //   final stats = MyanmarCalendar.getCacheStatistics();
    //   final hits = stats['hits'] as int;
    //   print("hits: $hits");
    //   expect(hits, greaterThan(50)); // Most should be hits
    // });
  });
}
