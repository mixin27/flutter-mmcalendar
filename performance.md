# Performance Utilities

## Overview

The `flutter_mmcalendar` package includes a suite of performance optimization utilities to help you build fast, responsive calendar applications.

> **Note**: For caching calendar dates, use the built-in `CalendarCache` system (see [cache.md](cache.md)). The `LRUCache` utility is a general-purpose cache for other caching needs.

## LRU Cache

A generic Least Recently Used (LRU) cache implementation with optional Time-To-Live (TTL) support.

### Basic Usage

```dart
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

// Create a cache with maximum 100 entries
final cache = LRUCache<String, MyanmarDateTime>(maxSize: 100);

// Store values
cache.put('today', MyanmarCalendar.today());
cache.put('tomorrow', MyanmarCalendar.today().addDays(1));

// Retrieve values
final today = cache.get('today');  // Cache hit
final missing = cache.get('missing');  // Returns null

// Store with TTL
cache.put(
  'temp',
  MyanmarCalendar.today(),
  ttl: Duration(minutes: 30),
);
```

### Cache Statistics

```dart
final stats = cache.getStatistics();
print('Hit rate: ${stats['hitRate']}%');
print('Size: ${stats['size']}/${stats['maxSize']}');
print('Hits: ${stats['hits']}');
print('Misses: ${stats['misses']}');
```

### When to Use

- Caching API responses
- Caching computed values
- Temporary data storage
- **Not for calendar dates** - use `CalendarCache` instead

---

## Performance Monitor

Track and measure operation performance to identify bottlenecks.

### Basic Usage

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
```

### Get Statistics

```dart
// Get stats for a specific operation
final stats = PerformanceMonitor.getOperationStats('date_conversion');
print('Average: ${stats!['avgMs']}ms');
print('Min: ${stats['minMs']}ms');
print('Max: ${stats['maxMs']}ms');
print('Count: ${stats['count']}');

// Get all statistics
final allStats = PerformanceMonitor.getAllStats();

// Print formatted report
PerformanceMonitor.printReport();
```

### Clear Measurements

```dart
// Clear specific operation
PerformanceMonitor.clearOperation('date_conversion');

// Clear all measurements
PerformanceMonitor.clear();
```

---

## Batch Optimizer

Process large datasets without blocking the UI thread.

### Synchronous Batch Processing

```dart
final dates = List.generate(1000, (i) => DateTime(2024, 1, i + 1));

final myanmarDates = await BatchOptimizer.processBatch(
  dates,
  (date) => MyanmarCalendar.fromDateTime(date),
  batchSize: 50,  // Process 50 items at a time
  delayBetweenBatches: Duration(milliseconds: 10),
);
```

### Async Batch Processing

```dart
final results = await BatchOptimizer.processBatchAsync(
  items,
  (item) async => await processAsync(item),
  batchSize: 25,
  delayBetweenBatches: Duration(milliseconds: 10),
);
```

---

## Debouncer

Delay execution until calls stop coming in. Perfect for search inputs.

### Usage

```dart
final debouncer = Debouncer(delay: Duration(milliseconds: 300));

void onSearchChanged(String query) {
  debouncer.run(() {
    // This will only execute 300ms after the last call
    performSearch(query);
  });
}

// Cancel pending action
debouncer.cancel();

// Clean up
@override
void dispose() {
  debouncer.dispose();
  super.dispose();
}
```

---

## Throttler

Limit execution frequency. Perfect for scroll handlers.

### Usage

```dart
final throttler = Throttler(duration: Duration(milliseconds: 300));

void onScroll() {
  throttler.run(() {
    // This will execute at most once every 300ms
    updateVisibleDates();
  });
}

// Reset throttler
throttler.reset();
```

---

## Memory Optimization Utils

Utilities for estimating and optimizing memory usage.

### Estimate Cache Memory

```dart
final memoryBytes = MemoryOptimizationUtils.estimateCacheMemoryBytes(
  100,  // entry count
  200,  // average entry size in bytes
);
print('Estimated memory: ${memoryBytes / 1024} KB');
```

### Platform Recommendations

```dart
final recommendation = MemoryOptimizationUtils.getMemoryRecommendation('mobile');
print(recommendation);
// Output: "Use memory-efficient cache (30-100 entries). Mobile devices have limited RAM."
```

---

## Best Practices

### 1. Use the Right Cache

```dart
// ✅ Good: Use CalendarCache for calendar dates
MyanmarCalendar.configureCache(CacheConfig.highPerformance());
final date = MyanmarCalendar.today();  // Uses built-in cache

// ✅ Good: Use LRUCache for other data
final apiCache = LRUCache<String, dynamic>(maxSize: 50);
apiCache.put('user_data', userData);

// ❌ Bad: Don't use LRUCache for calendar dates
// The built-in CalendarCache is optimized for this
```

### 2. Monitor Performance in Development

```dart
// In development, monitor critical operations
if (kDebugMode) {
  PerformanceMonitor.measure('calendar_render', () {
    // Render calendar
  });

  PerformanceMonitor.printReport();
}
```

### 3. Batch Process Large Datasets

```dart
// ✅ Good: Use batch processing for large datasets
final results = await BatchOptimizer.processBatch(
  largeList,
  processor,
  batchSize: 50,
);

// ❌ Bad: Process all at once (blocks UI)
final results = largeList.map(processor).toList();
```

### 4. Debounce User Input

```dart
// ✅ Good: Debounce search input
final debouncer = Debouncer(delay: Duration(milliseconds: 300));
TextField(
  onChanged: (query) => debouncer.run(() => search(query)),
)

// ❌ Bad: Search on every keystroke
TextField(
  onChanged: (query) => search(query),  // Too many calls
)
```

### 5. Throttle Scroll Events

```dart
// ✅ Good: Throttle scroll updates
final throttler = Throttler(duration: Duration(milliseconds: 100));
NotificationListener<ScrollNotification>(
  onNotification: (notification) {
    throttler.run(() => updateVisibleDates());
    return false;
  },
)
```

---

## Performance Tips

1. **Use RepaintBoundary** - Wrap calendar cells in `RepaintBoundary` (done automatically in `OptimizedCalendarCell`)
2. **Use const constructors** - Where possible to avoid unnecessary rebuilds
3. **Monitor cache hit rates** - Aim for >80% hit rate for frequently accessed data
4. **Batch process** - For operations on >100 items
5. **Profile in release mode** - Debug mode is slower; always profile in release mode

---

## API Reference

### LRUCache<K, V>

- `LRUCache(int maxSize)` - Create cache with max size
- `V? get(K key)` - Get value from cache
- `void put(K key, V value, {Duration? ttl})` - Put value in cache
- `bool containsKey(K key)` - Check if key exists
- `V? remove(K key)` - Remove specific key
- `void clear()` - Clear all entries
- `int get size` - Current cache size
- `Map<String, dynamic> getStatistics()` - Get cache statistics
- `void resetStatistics()` - Reset statistics
- `void removeExpired()` - Remove expired entries

### PerformanceMonitor

- `static T measure<T>(String name, T Function() operation)` - Measure sync operation
- `static Future<T> measureAsync<T>(String name, Future<T> Function() operation)` - Measure async operation
- `static Map<String, dynamic>? getOperationStats(String name)` - Get operation stats
- `static Map<String, Map<String, dynamic>> getAllStats()` - Get all stats
- `static void printReport()` - Print formatted report
- `static void clear()` - Clear all measurements
- `static void clearOperation(String name)` - Clear specific operation

### BatchOptimizer

- `static Future<List<T>> processBatch<S, T>(...)` - Process items in batches
- `static Future<List<T>> processBatchAsync<S, T>(...)` - Process items async in batches

### Debouncer

- `Debouncer({Duration delay})` - Create debouncer
- `void run(void Function() action)` - Run debounced action
- `void cancel()` - Cancel pending action
- `void dispose()` - Dispose debouncer

### Throttler

- `Throttler({Duration duration})` - Create throttler
- `void run(void Function() action)` - Run throttled action
- `void reset()` - Reset throttler
