import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

/// Tests for performance utilities
void main() {
  group('LRUCache', () {
    test('stores and retrieves values', () {
      final cache = LRUCache<String, int>(maxSize: 3);

      cache.put('a', 1);
      cache.put('b', 2);
      cache.put('c', 3);

      expect(cache.get('a'), equals(1));
      expect(cache.get('b'), equals(2));
      expect(cache.get('c'), equals(3));
      expect(cache.size, equals(3));
    });

    test('evicts least recently used item when full', () {
      final cache = LRUCache<String, int>(maxSize: 3);

      cache.put('a', 1);
      cache.put('b', 2);
      cache.put('c', 3);
      cache.put('d', 4); // Should evict 'a'

      expect(cache.get('a'), isNull);
      expect(cache.get('b'), equals(2));
      expect(cache.get('c'), equals(3));
      expect(cache.get('d'), equals(4));
      expect(cache.size, equals(3));
    });

    test('updates LRU order on access', () {
      final cache = LRUCache<String, int>(maxSize: 3);

      cache.put('a', 1);
      cache.put('b', 2);
      cache.put('c', 3);

      // Access 'a' to make it most recently used
      cache.get('a');

      cache.put('d', 4); // Should evict 'b', not 'a'

      expect(cache.get('a'), equals(1));
      expect(cache.get('b'), isNull);
      expect(cache.get('c'), equals(3));
      expect(cache.get('d'), equals(4));
    });

    test('handles TTL expiration', () async {
      final cache = LRUCache<String, int>(maxSize: 3);

      cache.put('a', 1, ttl: const Duration(milliseconds: 100));

      expect(cache.get('a'), equals(1));

      await Future.delayed(const Duration(milliseconds: 150));

      expect(cache.get('a'), isNull);
    });

    test('tracks statistics correctly', () {
      final cache = LRUCache<String, int>(maxSize: 3);

      cache.put('a', 1);
      cache.put('b', 2);

      cache.get('a'); // Hit
      cache.get('a'); // Hit
      cache.get('c'); // Miss

      final stats = cache.getStatistics();

      expect(stats['hits'], equals(2));
      expect(stats['misses'], equals(1));
      expect(stats['totalRequests'], equals(3));
      expect(stats['hitRate'], closeTo(66.67, 0.1));
    });

    test('clears all entries', () {
      final cache = LRUCache<String, int>(maxSize: 3);

      cache.put('a', 1);
      cache.put('b', 2);
      cache.put('c', 3);

      cache.clear();

      expect(cache.size, equals(0));
      expect(cache.get('a'), isNull);
    });

    test('removes specific key', () {
      final cache = LRUCache<String, int>(maxSize: 3);

      cache.put('a', 1);
      cache.put('b', 2);

      final removed = cache.remove('a');

      expect(removed, equals(1));
      expect(cache.get('a'), isNull);
      expect(cache.size, equals(1));
    });

    test('removes expired entries', () async {
      final cache = LRUCache<String, int>(maxSize: 3);

      cache.put('a', 1, ttl: const Duration(milliseconds: 100));
      cache.put('b', 2); // No TTL

      await Future.delayed(const Duration(milliseconds: 150));

      cache.removeExpired();

      expect(cache.size, equals(1));
      expect(cache.get('b'), equals(2));
    });
  });

  group('PerformanceMonitor', () {
    setUp(() {
      PerformanceMonitor.clear();
    });

    test('measures synchronous operations', () {
      PerformanceMonitor.measure('test_op', () {
        // Simulate work
        var sum = 0;
        for (var i = 0; i < 1000; i++) {
          sum += i;
        }
        return sum;
      });

      final stats = PerformanceMonitor.getOperationStats('test_op');

      expect(stats, isNotNull);
      expect(stats!['count'], equals(1));
      expect(stats['avgMs'], greaterThan(0));
    });

    test('measures multiple operations', () {
      for (var i = 0; i < 5; i++) {
        PerformanceMonitor.measure('test_op', () => i * 2);
      }

      final stats = PerformanceMonitor.getOperationStats('test_op');

      expect(stats!['count'], equals(5));
    });

    test('tracks min, max, and average', () {
      PerformanceMonitor.measure('fast_op', () {
        // Fast operation
      });

      PerformanceMonitor.measure('slow_op', () {
        // Simulate slow operation
        var sum = 0;
        for (var i = 0; i < 10000; i++) {
          sum += i;
        }
      });

      final fastStats = PerformanceMonitor.getOperationStats('fast_op');
      final slowStats = PerformanceMonitor.getOperationStats('slow_op');

      expect(fastStats!['avgMs'], lessThan(slowStats!['avgMs']));
    });

    test('clears specific operation', () {
      PerformanceMonitor.measure('op1', () => 1);
      PerformanceMonitor.measure('op2', () => 2);

      PerformanceMonitor.clearOperation('op1');

      expect(PerformanceMonitor.getOperationStats('op1'), isNull);
      expect(PerformanceMonitor.getOperationStats('op2'), isNotNull);
    });

    test('gets all stats', () {
      PerformanceMonitor.measure('op1', () => 1);
      PerformanceMonitor.measure('op2', () => 2);

      final allStats = PerformanceMonitor.getAllStats();

      expect(allStats.length, equals(2));
      expect(allStats.containsKey('op1'), isTrue);
      expect(allStats.containsKey('op2'), isTrue);
    });
  });

  group('BatchOptimizer', () {
    test('processes items in batches', () async {
      final items = List.generate(100, (i) => i);

      final results = await BatchOptimizer.processBatch(
        items,
        (item) => item * 2,
        batchSize: 25,
        delayBetweenBatches: const Duration(milliseconds: 1),
      );

      expect(results.length, equals(100));
      expect(results[0], equals(0));
      expect(results[99], equals(198));
    });

    test('processes async items in batches', () async {
      final items = List.generate(50, (i) => i);

      final results = await BatchOptimizer.processBatchAsync(
        items,
        (item) async => item * 2,
        batchSize: 10,
        delayBetweenBatches: const Duration(milliseconds: 1),
      );

      expect(results.length, equals(50));
      expect(results[0], equals(0));
      expect(results[49], equals(98));
    });
  });

  group('Debouncer', () {
    test('debounces rapid calls', () async {
      final debouncer = Debouncer(delay: const Duration(milliseconds: 100));
      var callCount = 0;

      // Rapid calls
      for (var i = 0; i < 10; i++) {
        debouncer.run(() => callCount++);
        await Future.delayed(const Duration(milliseconds: 10));
      }

      // Wait for debounce delay
      await Future.delayed(const Duration(milliseconds: 150));

      // Should only be called once
      expect(callCount, equals(1));

      debouncer.dispose();
    });

    test('cancels pending action', () async {
      final debouncer = Debouncer(delay: const Duration(milliseconds: 100));
      var called = false;

      debouncer.run(() => called = true);
      debouncer.cancel();

      await Future.delayed(const Duration(milliseconds: 150));

      expect(called, isFalse);

      debouncer.dispose();
    });
  });

  group('Throttler', () {
    test('throttles rapid calls', () async {
      final throttler = Throttler(duration: const Duration(milliseconds: 200));
      var callCount = 0;

      // Rapid calls
      for (var i = 0; i < 10; i++) {
        throttler.run(() => callCount++);
        await Future.delayed(const Duration(milliseconds: 10));
      }

      // Should be called only once (first call)
      expect(callCount, equals(1));
    });

    test('allows call after duration', () async {
      final throttler = Throttler(duration: const Duration(milliseconds: 50));
      var callCount = 0;

      throttler.run(() => callCount++);
      expect(callCount, equals(1));

      await Future.delayed(const Duration(milliseconds: 60));

      throttler.run(() => callCount++);
      expect(callCount, equals(2));
    });

    test('resets throttler', () {
      final throttler = Throttler(duration: const Duration(milliseconds: 100));
      var callCount = 0;

      throttler.run(() => callCount++);
      throttler.reset();
      throttler.run(() => callCount++);

      expect(callCount, equals(2));
    });
  });

  group('MemoryOptimizationUtils', () {
    test('estimates cache memory usage', () {
      final memoryBytes = MemoryOptimizationUtils.estimateCacheMemoryBytes(
        100,
        200,
      );

      expect(memoryBytes, greaterThan(0));
      expect(memoryBytes, equals(100 * (200 + 64)));
    });

    test('provides platform-specific recommendations', () {
      final mobileRec = MemoryOptimizationUtils.getMemoryRecommendation(
        'mobile',
      );
      final desktopRec = MemoryOptimizationUtils.getMemoryRecommendation(
        'desktop',
      );

      expect(mobileRec, contains('memory-efficient'));
      expect(desktopRec, contains('high-performance'));
    });
  });
}
