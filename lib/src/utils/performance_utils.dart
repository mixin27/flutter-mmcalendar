/// Performance utilities for Myanmar Calendar package
///
/// This file contains utilities for optimizing performance including
/// cache management, widget optimization, and performance monitoring.
library;

import 'dart:async';
import 'dart:collection';

import 'package:flutter/foundation.dart';

/// LRU (Least Recently Used) Cache implementation
///
/// This cache automatically evicts the least recently used items when
/// the maximum size is reached, providing better memory management.
class LRUCache<K, V> {
  /// Maximum number of entries in the cache
  final int maxSize;

  /// Internal storage using LinkedHashMap for LRU ordering
  final LinkedHashMap<K, _CacheEntry<V>> _cache;

  /// Statistics tracking
  int _hits = 0;
  int _misses = 0;
  int _evictions = 0;

  /// Create an LRU cache with the specified maximum size
  LRUCache({required this.maxSize})
    : _cache = LinkedHashMap<K, _CacheEntry<V>>();

  /// Get a value from the cache
  ///
  /// Returns null if the key is not found or if the entry has expired.
  V? get(K key) {
    final entry = _cache.remove(key);
    if (entry == null) {
      _misses++;
      return null;
    }

    // Check if entry has expired
    if (entry.isExpired) {
      _misses++;
      return null;
    }

    // Move to end (most recently used)
    _cache[key] = entry;
    _hits++;
    return entry.value;
  }

  /// Put a value in the cache
  ///
  /// If the cache is full, the least recently used item will be evicted.
  void put(K key, V value, {Duration? ttl}) {
    // Remove existing entry if present
    _cache.remove(key);

    // Add new entry at the end (most recently used)
    _cache[key] = _CacheEntry(
      value,
      expiresAt: ttl != null ? DateTime.now().add(ttl) : null,
    );

    // Evict least recently used if over capacity
    if (_cache.length > maxSize) {
      _cache.remove(_cache.keys.first);
      _evictions++;
    }
  }

  /// Check if a key exists in the cache
  bool containsKey(K key) {
    final entry = _cache[key];
    if (entry == null) return false;
    if (entry.isExpired) {
      _cache.remove(key);
      return false;
    }
    return true;
  }

  /// Remove a specific key from the cache
  V? remove(K key) {
    return _cache.remove(key)?.value;
  }

  /// Clear all entries from the cache
  void clear() {
    _cache.clear();
  }

  /// Get the current size of the cache
  int get size => _cache.length;

  /// Get cache statistics
  Map<String, dynamic> getStatistics() {
    final totalRequests = _hits + _misses;
    final hitRate = totalRequests > 0 ? (_hits / totalRequests) * 100 : 0.0;

    return {
      'size': size,
      'maxSize': maxSize,
      'hits': _hits,
      'misses': _misses,
      'evictions': _evictions,
      'totalRequests': totalRequests,
      'hitRate': hitRate,
      'utilizationPercent': (size / maxSize) * 100,
    };
  }

  /// Reset statistics
  void resetStatistics() {
    _hits = 0;
    _misses = 0;
    _evictions = 0;
  }

  /// Remove expired entries
  void removeExpired() {
    final keysToRemove = <K>[];
    for (final entry in _cache.entries) {
      if (entry.value.isExpired) {
        keysToRemove.add(entry.key);
      }
    }
    for (final key in keysToRemove) {
      _cache.remove(key);
    }
  }
}

/// Internal cache entry with optional expiration
class _CacheEntry<V> {
  final V value;
  final DateTime? expiresAt;

  _CacheEntry(this.value, {this.expiresAt});

  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }
}

/// Performance monitoring utility
class PerformanceMonitor {
  static final Map<String, List<Duration>> _measurements = {};
  static final Map<String, int> _counts = {};

  /// Start measuring an operation
  static DateTime startMeasurement(String operationName) {
    return DateTime.now();
  }

  /// End measurement and record the duration
  static void endMeasurement(String operationName, DateTime startTime) {
    final duration = DateTime.now().difference(startTime);
    _measurements.putIfAbsent(operationName, () => []).add(duration);
    _counts[operationName] = (_counts[operationName] ?? 0) + 1;
  }

  /// Measure a synchronous operation
  static T measure<T>(String operationName, T Function() operation) {
    final startTime = startMeasurement(operationName);
    try {
      return operation();
    } finally {
      endMeasurement(operationName, startTime);
    }
  }

  /// Measure an asynchronous operation
  static Future<T> measureAsync<T>(
    String operationName,
    Future<T> Function() operation,
  ) async {
    final startTime = startMeasurement(operationName);
    try {
      return await operation();
    } finally {
      endMeasurement(operationName, startTime);
    }
  }

  /// Get statistics for a specific operation
  static Map<String, dynamic>? getOperationStats(String operationName) {
    final measurements = _measurements[operationName];
    if (measurements == null || measurements.isEmpty) return null;

    final totalMicroseconds = measurements.fold<int>(
      0,
      (sum, d) => sum + d.inMicroseconds,
    );
    final avgMicroseconds = totalMicroseconds / measurements.length;
    final minMicroseconds = measurements
        .map((d) => d.inMicroseconds)
        .reduce((a, b) => a < b ? a : b);
    final maxMicroseconds = measurements
        .map((d) => d.inMicroseconds)
        .reduce((a, b) => a > b ? a : b);

    return {
      'operationName': operationName,
      'count': _counts[operationName],
      'avgMs': avgMicroseconds / 1000,
      'minMs': minMicroseconds / 1000,
      'maxMs': maxMicroseconds / 1000,
      'totalMs': totalMicroseconds / 1000,
    };
  }

  /// Get all performance statistics
  static Map<String, Map<String, dynamic>> getAllStats() {
    final stats = <String, Map<String, dynamic>>{};
    for (final operationName in _measurements.keys) {
      final operationStats = getOperationStats(operationName);
      if (operationStats != null) {
        stats[operationName] = operationStats;
      }
    }
    return stats;
  }

  /// Clear all measurements
  static void clear() {
    _measurements.clear();
    _counts.clear();
  }

  /// Clear measurements for a specific operation
  static void clearOperation(String operationName) {
    _measurements.remove(operationName);
    _counts.remove(operationName);
  }

  /// Print performance report
  static void printReport() {
    debugPrint('\n=== Performance Report ===');
    final stats = getAllStats();
    if (stats.isEmpty) {
      debugPrint('No measurements recorded.');
      return;
    }

    for (final entry in stats.entries) {
      final s = entry.value;
      debugPrint('\n${entry.key}:');
      debugPrint('  Count: ${s['count']}');
      debugPrint('  Average: ${s['avgMs'].toStringAsFixed(2)}ms');
      debugPrint('  Min: ${s['minMs'].toStringAsFixed(2)}ms');
      debugPrint('  Max: ${s['maxMs'].toStringAsFixed(2)}ms');
      debugPrint('  Total: ${s['totalMs'].toStringAsFixed(2)}ms');
    }
    debugPrint('\n========================\n');
  }
}

/// Widget performance utilities
class WidgetPerformanceUtils {
  /// Check if a widget should use const constructor
  static bool shouldUseConst(dynamic widget) {
    // This is a helper for developers to check if their widgets
    // can be made const
    // Note: This is a simplified check for demonstration
    return widget.runtimeType.toString().contains('Stateless');
  }

  /// Estimate widget rebuild cost (for debugging)
  static String estimateRebuildCost(int childCount, int depth) {
    if (childCount < 10 && depth < 3) {
      return 'Low';
    } else if (childCount < 50 && depth < 5) {
      return 'Medium';
    } else {
      return 'High';
    }
  }
}

/// Memory optimization utilities
class MemoryOptimizationUtils {
  /// Calculate approximate memory usage of a cache
  static int estimateCacheMemoryBytes(int entryCount, int avgEntrySize) {
    // Rough estimation: entry count * average entry size + overhead
    const overheadPerEntry = 64; // bytes for LinkedHashMap overhead
    return entryCount * (avgEntrySize + overheadPerEntry);
  }

  /// Get memory usage recommendation based on platform
  static String getMemoryRecommendation(String platform) {
    switch (platform.toLowerCase()) {
      case 'web':
        return 'Use moderate cache sizes (100-300 entries). Browser memory is limited.';
      case 'mobile':
      case 'android':
      case 'ios':
        return 'Use memory-efficient cache (30-100 entries). Mobile devices have limited RAM.';
      case 'desktop':
      case 'windows':
      case 'macos':
      case 'linux':
        return 'Use high-performance cache (500-1000 entries). Desktop has more memory available.';
      default:
        return 'Use default cache configuration (100-200 entries).';
    }
  }
}

/// Batch operation optimizer
class BatchOptimizer {
  /// Process items in batches to avoid blocking the UI
  static Future<List<T>> processBatch<S, T>(
    List<S> items,
    T Function(S) processor, {
    int batchSize = 50,
    Duration delayBetweenBatches = const Duration(milliseconds: 10),
  }) async {
    final results = <T>[];

    for (var i = 0; i < items.length; i += batchSize) {
      final end = (i + batchSize < items.length) ? i + batchSize : items.length;
      final batch = items.sublist(i, end);

      // Process batch
      results.addAll(batch.map(processor));

      // Delay between batches to keep UI responsive
      if (end < items.length) {
        await Future.delayed(delayBetweenBatches);
      }
    }

    return results;
  }

  /// Process items in batches asynchronously
  static Future<List<T>> processBatchAsync<S, T>(
    List<S> items,
    Future<T> Function(S) processor, {
    int batchSize = 50,
    Duration delayBetweenBatches = const Duration(milliseconds: 10),
  }) async {
    final results = <T>[];

    for (var i = 0; i < items.length; i += batchSize) {
      final end = (i + batchSize < items.length) ? i + batchSize : items.length;
      final batch = items.sublist(i, end);

      // Process batch asynchronously
      final batchResults = await Future.wait(batch.map(processor));
      results.addAll(batchResults);

      // Delay between batches to keep UI responsive
      if (end < items.length) {
        await Future.delayed(delayBetweenBatches);
      }
    }

    return results;
  }
}

/// Debouncer for reducing unnecessary operations
class Debouncer {
  /// The delay between actions
  final Duration delay;

  Timer? _timer;

  /// Create a new [Debouncer]
  Debouncer({this.delay = const Duration(milliseconds: 300)});

  /// Run the action after the delay, cancelling any pending action
  void run(void Function() action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// Cancel any pending action
  void cancel() {
    _timer?.cancel();
  }

  /// Dispose the debouncer
  void dispose() {
    _timer?.cancel();
  }
}

/// Throttler for limiting operation frequency
class Throttler {
  /// The duration between actions
  final Duration duration;

  DateTime? _lastRun;

  /// Create a new [Throttler]
  Throttler({this.duration = const Duration(milliseconds: 300)});

  /// Run the action only if enough time has passed since the last run
  void run(void Function() action) {
    final now = DateTime.now();
    if (_lastRun == null || now.difference(_lastRun!) >= duration) {
      _lastRun = now;
      action();
    }
  }

  /// Reset the throttler
  void reset() {
    _lastRun = null;
  }
}
