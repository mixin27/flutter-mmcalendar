import '../models/astro_info.dart';
import '../models/complete_date.dart';
import '../models/holiday_info.dart';
import '../models/myanmar_date.dart';
import '../models/western_date.dart';

/// Cache configuration options
class CacheConfig {
  /// Maximum number of CompleteDate objects to cache
  final int maxCompleteDateCacheSize;

  /// Maximum number of MyanmarDate objects to cache
  final int maxMyanmarDateCacheSize;

  /// Maximum number of WesternDate objects to cache
  final int maxWesternDateCacheSize;

  /// Maximum number of AstroInfo objects to cache
  final int maxAstroInfoCacheSize;

  /// Maximum number of HolidayInfo objects to cache
  final int maxHolidayInfoCacheSize;

  /// Whether to enable caching
  final bool enableCaching;

  /// Cache time-to-live in seconds (0 = no expiration)
  final int cacheTTL;

  /// Create a new [CacheConfig] instance
  const CacheConfig({
    this.maxCompleteDateCacheSize = 100,
    this.maxMyanmarDateCacheSize = 200,
    this.maxWesternDateCacheSize = 200,
    this.maxAstroInfoCacheSize = 150,
    this.maxHolidayInfoCacheSize = 150,
    this.enableCaching = true,
    this.cacheTTL = 0, // No expiration by default
  });

  /// Disable all caching
  const CacheConfig.disabled()
    : maxCompleteDateCacheSize = 0,
      maxMyanmarDateCacheSize = 0,
      maxWesternDateCacheSize = 0,
      maxAstroInfoCacheSize = 0,
      maxHolidayInfoCacheSize = 0,
      enableCaching = false,
      cacheTTL = 0;

  /// Memory-efficient configuration
  const CacheConfig.memoryEfficient()
    : maxCompleteDateCacheSize = 30,
      maxMyanmarDateCacheSize = 50,
      maxWesternDateCacheSize = 50,
      maxAstroInfoCacheSize = 40,
      maxHolidayInfoCacheSize = 40,
      enableCaching = true,
      cacheTTL = 3600; // 1 hour

  /// High-performance configuration (more memory usage)
  const CacheConfig.highPerformance()
    : maxCompleteDateCacheSize = 500,
      maxMyanmarDateCacheSize = 1000,
      maxWesternDateCacheSize = 1000,
      maxAstroInfoCacheSize = 500,
      maxHolidayInfoCacheSize = 500,
      enableCaching = true,
      cacheTTL = 0;

  @override
  String toString() {
    return 'CacheConfig(maxCompleteDateCacheSize: $maxCompleteDateCacheSize, maxMyanmarDateCacheSize: $maxMyanmarDateCacheSize, maxWesternDateCacheSize: $maxWesternDateCacheSize, maxAstroInfoCacheSize: $maxAstroInfoCacheSize, maxHolidayInfoCacheSize: $maxHolidayInfoCacheSize, enableCaching: $enableCaching, cacheTTL: $cacheTTL)';
  }
}

/// Cache entry with timestamp for TTL support
class _CacheEntry<T> {
  final T value;
  final DateTime timestamp;

  _CacheEntry(this.value) : timestamp = DateTime.now();

  bool isExpired(int ttl) {
    if (ttl == 0) return false;
    return DateTime.now().difference(timestamp).inSeconds > ttl;
  }
}

/// LRU (Least Recently Used) Cache implementation
class _LRUCache<K, V> {
  final int maxSize;
  final int ttl;
  final bool enabled;
  final Map<K, _CacheEntry<V>> _cache = {};
  final List<K> _accessOrder = [];

  _LRUCache(this.maxSize, this.ttl, this.enabled);

  V? get(K key) {
    // If caching is disabled, always return null
    if (!enabled || maxSize == 0) return null;

    final entry = _cache[key];
    if (entry == null) return null;

    // Check if expired
    if (entry.isExpired(ttl)) {
      _cache.remove(key);
      _accessOrder.remove(key);
      return null;
    }

    // Update access order
    _accessOrder.remove(key);
    _accessOrder.add(key);

    return entry.value;
  }

  void put(K key, V value) {
    // If caching is disabled, don't store anything
    if (!enabled || maxSize == 0) return;

    // Remove if already exists
    if (_cache.containsKey(key)) {
      _accessOrder.remove(key);
    }

    // Add new entry
    _cache[key] = _CacheEntry(value);
    _accessOrder.add(key);

    // Evict oldest if necessary
    while (_accessOrder.length > maxSize) {
      final oldestKey = _accessOrder.removeAt(0);
      _cache.remove(oldestKey);
    }
  }

  void remove(K key) {
    _cache.remove(key);
    _accessOrder.remove(key);
  }

  void clear() {
    _cache.clear();
    _accessOrder.clear();
  }

  int get size => _cache.length;

  bool containsKey(K key) => _cache.containsKey(key);

  /// Get cache statistics
  Map<String, dynamic> getStats() {
    return {
      'size': _cache.length,
      'maxSize': maxSize,
      'utilizationPercent': maxSize > 0
          ? (_cache.length / maxSize * 100).toStringAsFixed(2)
          : '0',
      'ttl': ttl,
      'enabled': enabled,
    };
  }
}

/// Centralized cache manager for Myanmar Calendar
///
/// This class manages caching for all calendar operations.
/// It can work in two modes:
/// 1. Global shared mode - All services share one cache instance
/// 2. Independent mode - Each service has its own cache
class CalendarCache {
  // ============================================================================
  // GLOBAL SHARED CACHE
  // ============================================================================

  /// Global shared cache instance
  static CalendarCache? _globalCache;

  /// Get or create global shared cache
  static CalendarCache global() {
    _globalCache ??= CalendarCache._internal(const CacheConfig());
    return _globalCache!;
  }

  /// Configure global cache with new settings
  static void configureGlobal(CacheConfig config) {
    _globalCache = CalendarCache._internal(config);
  }

  /// Check if global cache exists
  static bool get hasGlobal => _globalCache != null;

  /// Clear global cache instance (mainly for testing)
  static void resetGlobal() {
    _globalCache?.clearAll();
    _globalCache = null;
  }

  // ============================================================================
  // INSTANCE PROPERTIES
  // ============================================================================

  late CacheConfig _config;

  // Individual caches
  late _LRUCache<String, CompleteDate> _completeDateCache;
  late _LRUCache<String, MyanmarDate> _myanmarDateCache;
  late _LRUCache<String, WesternDate> _westernDateCache;
  late _LRUCache<String, AstroInfo> _astroInfoCache;
  late _LRUCache<String, HolidayInfo> _holidayInfoCache;

  // Statistics
  int _hits = 0;
  int _misses = 0;

  // ============================================================================
  // CONSTRUCTORS
  // ============================================================================

  /// Private constructor for creating cache instances
  CalendarCache._internal(CacheConfig config) {
    _config = config;
    _initializeCaches();
  }

  /// Create a new independent cache instance
  /// Use this for testing or when you need isolated caching
  factory CalendarCache.independent({CacheConfig? config}) {
    return CalendarCache._internal(config ?? const CacheConfig());
  }

  void _initializeCaches() {
    _completeDateCache = _LRUCache(
      _config.maxCompleteDateCacheSize,
      _config.cacheTTL,
      _config.enableCaching,
    );
    _myanmarDateCache = _LRUCache(
      _config.maxMyanmarDateCacheSize,
      _config.cacheTTL,
      _config.enableCaching,
    );
    _westernDateCache = _LRUCache(
      _config.maxWesternDateCacheSize,
      _config.cacheTTL,
      _config.enableCaching,
    );
    _astroInfoCache = _LRUCache(
      _config.maxAstroInfoCacheSize,
      _config.cacheTTL,
      _config.enableCaching,
    );
    _holidayInfoCache = _LRUCache(
      _config.maxHolidayInfoCacheSize,
      _config.cacheTTL,
      _config.enableCaching,
    );
  }

  // ============================================================================
  // CACHE OPERATIONS
  // ============================================================================

  /// Get cached CompleteDate
  CompleteDate? getCompleteDate(DateTime dateTime) {
    if (!_config.enableCaching) {
      _misses++;
      return null;
    }

    final key = '${dateTime.year}-${dateTime.month}-${dateTime.day}';
    final cached = _completeDateCache.get(key);

    if (cached != null) {
      _hits++;
      return cached;
    }

    _misses++;
    return null;
  }

  /// Cache CompleteDate
  void putCompleteDate(DateTime dateTime, CompleteDate completeDate) {
    if (!_config.enableCaching) return;
    final key = '${dateTime.year}-${dateTime.month}-${dateTime.day}';
    _completeDateCache.put(key, completeDate);
  }

  /// Get cached MyanmarDate
  MyanmarDate? getMyanmarDate(double julianDayNumber) {
    if (!_config.enableCaching) {
      _misses++;
      return null;
    }

    final key = julianDayNumber.toStringAsFixed(6);
    final cached = _myanmarDateCache.get(key);

    if (cached != null) {
      _hits++;
      return cached;
    }

    _misses++;
    return null;
  }

  /// Cache MyanmarDate
  void putMyanmarDate(double julianDayNumber, MyanmarDate myanmarDate) {
    if (!_config.enableCaching) return;
    final key = julianDayNumber.toStringAsFixed(6);
    _myanmarDateCache.put(key, myanmarDate);
  }

  /// Get cached WesternDate
  WesternDate? getWesternDate(double julianDayNumber) {
    if (!_config.enableCaching) {
      _misses++;
      return null;
    }

    final key = julianDayNumber.toStringAsFixed(6);
    final cached = _westernDateCache.get(key);

    if (cached != null) {
      _hits++;
      return cached;
    }

    _misses++;
    return null;
  }

  /// Cache WesternDate
  void putWesternDate(double julianDayNumber, WesternDate westernDate) {
    if (!_config.enableCaching) return;
    final key = julianDayNumber.toStringAsFixed(6);
    _westernDateCache.put(key, westernDate);
  }

  /// Get cached AstroInfo
  AstroInfo? getAstroInfo(dynamic myanmarDate) {
    if (!_config.enableCaching) {
      _misses++;
      return null;
    }

    final key = _generateMyanmarDateKey(myanmarDate);
    final cached = _astroInfoCache.get(key);

    if (cached != null) {
      _hits++;
      return cached;
    }

    _misses++;
    return null;
  }

  /// Cache AstroInfo
  void putAstroInfo(dynamic myanmarDate, AstroInfo astroInfo) {
    if (!_config.enableCaching) return;
    final key = _generateMyanmarDateKey(myanmarDate);
    _astroInfoCache.put(key, astroInfo);
  }

  /// Get cached HolidayInfo
  HolidayInfo? getHolidayInfo(dynamic myanmarDate) {
    if (!_config.enableCaching) {
      _misses++;
      return null;
    }

    final key = _generateMyanmarDateKey(myanmarDate);
    final cached = _holidayInfoCache.get(key);

    if (cached != null) {
      _hits++;
      return cached;
    }

    _misses++;
    return null;
  }

  /// Cache HolidayInfo
  void putHolidayInfo(dynamic myanmarDate, HolidayInfo holidayInfo) {
    if (!_config.enableCaching) return;
    final key = _generateMyanmarDateKey(myanmarDate);
    _holidayInfoCache.put(key, holidayInfo);
  }

  String _generateMyanmarDateKey(dynamic myanmarDate) {
    if (myanmarDate is Map) {
      return '${myanmarDate['year']}-${myanmarDate['month']}-${myanmarDate['day']}';
    }
    return '${myanmarDate.year}-${myanmarDate.month}-${myanmarDate.day}';
  }

  // ============================================================================
  // CACHE MANAGEMENT
  // ============================================================================

  /// Clear all caches
  void clearAll() {
    _completeDateCache.clear();
    _myanmarDateCache.clear();
    _westernDateCache.clear();
    _astroInfoCache.clear();
    _holidayInfoCache.clear();
    _hits = 0;
    _misses = 0;
  }

  /// Clear CompleteDate cache only
  void clearCompleteDateCache() => _completeDateCache.clear();

  /// Clear MyanmarDate cache only
  void clearMyanmarDateCache() => _myanmarDateCache.clear();

  /// Clear WesternDate cache only
  void clearWesternDateCache() => _westernDateCache.clear();

  /// Clear AstroInfo cache only
  void clearAstroInfoCache() => _astroInfoCache.clear();

  /// Clear HolidayInfo cache only
  void clearHolidayInfoCache() => _holidayInfoCache.clear();

  /// Warm up cache with common dates
  void warmUp({
    DateTime? startDate,
    DateTime? endDate,
    required dynamic service,
  }) {
    if (!_config.enableCaching) return;

    final start =
        startDate ?? DateTime.now().subtract(const Duration(days: 30));
    final end = endDate ?? DateTime.now().add(const Duration(days: 60));

    var currentDate = start;
    while (currentDate.isBefore(end) || currentDate.isAtSameMomentAs(end)) {
      service.getCompleteDate(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }
  }

  // ============================================================================
  // STATISTICS
  // ============================================================================

  /// Get hit rate.
  double get hitRate {
    final total = _hits + _misses;
    if (total == 0) return 0;
    return _hits / total;
  }

  /// Get statistics as map
  Map<String, dynamic> getStatistics() {
    final total = _hits + _misses;
    return {
      'enabled': _config.enableCaching,
      'hits': _hits,
      'misses': _misses,
      'total_requests': total,
      'hit_rate_percent': total > 0
          ? (hitRate * 100).toStringAsFixed(2)
          : '0.00',
      'caches': {
        'complete_date': _completeDateCache.getStats(),
        'myanmar_date': _myanmarDateCache.getStats(),
        'western_date': _westernDateCache.getStats(),
        'astro_info': _astroInfoCache.getStats(),
        'holiday_info': _holidayInfoCache.getStats(),
      },
      'total_memory_entries':
          _completeDateCache.size +
          _myanmarDateCache.size +
          _westernDateCache.size +
          _astroInfoCache.size +
          _holidayInfoCache.size,
    };
  }

  /// Reset statistics
  void resetStatistics() {
    _hits = 0;
    _misses = 0;
  }

  /// Get [CacheConfig] instance
  CacheConfig get config => _config;

  /// Check whether cache is enabled or not.
  bool get isEnabled => _config.enableCaching;
}
