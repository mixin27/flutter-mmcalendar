import '../models/astro_info.dart';
import '../models/complete_date.dart';
import '../models/holiday_info.dart';
import '../models/myanmar_date.dart';
import '../models/western_date.dart';
import '../services/myanmar_calendar_service.dart';

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
  final Map<K, _CacheEntry<V>> _cache = {};
  final List<K> _accessOrder = [];

  _LRUCache(this.maxSize, this.ttl);

  V? get(K key) {
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
    if (maxSize == 0) return; // Caching disabled

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
    };
  }
}

/// Centralized cache manager for Myanmar Calendar
class CalendarCache {
  static CalendarCache? _instance;
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

  CalendarCache._internal(CacheConfig config) {
    _config = config;
    _initializeCaches();
  }

  /// Get singleton instance
  factory CalendarCache({CacheConfig? config}) {
    _instance ??= CalendarCache._internal(config ?? const CacheConfig());
    return _instance!;
  }

  /// Initialize all caches
  void _initializeCaches() {
    _completeDateCache = _LRUCache(
      _config.maxCompleteDateCacheSize,
      _config.cacheTTL,
    );
    _myanmarDateCache = _LRUCache(
      _config.maxMyanmarDateCacheSize,
      _config.cacheTTL,
    );
    _westernDateCache = _LRUCache(
      _config.maxWesternDateCacheSize,
      _config.cacheTTL,
    );
    _astroInfoCache = _LRUCache(
      _config.maxAstroInfoCacheSize,
      _config.cacheTTL,
    );
    _holidayInfoCache = _LRUCache(
      _config.maxHolidayInfoCacheSize,
      _config.cacheTTL,
    );
  }

  /// Reconfigure cache
  void configure(CacheConfig config) {
    _config = config;
    clearAll(); // Clear old caches
    _initializeCaches();
  }

  // ============================================================================
  // COMPLETE DATE CACHE
  // ============================================================================

  /// Get cached CompleteDate
  CompleteDate? getCompleteDate(DateTime dateTime) {
    if (!_config.enableCaching) return null;

    final key = _generateDateKey(dateTime);
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

    final key = _generateDateKey(dateTime);
    _completeDateCache.put(key, completeDate);
  }

  // ============================================================================
  // MYANMAR DATE CACHE
  // ============================================================================

  /// Get cached MyanmarDate
  MyanmarDate? getMyanmarDate(double julianDayNumber) {
    if (!_config.enableCaching) return null;

    final key = _generateJDNKey(julianDayNumber);
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

    final key = _generateJDNKey(julianDayNumber);
    _myanmarDateCache.put(key, myanmarDate);
  }

  // ============================================================================
  // WESTERN DATE CACHE
  // ============================================================================

  /// Get cached WesternDate
  WesternDate? getWesternDate(double julianDayNumber) {
    if (!_config.enableCaching) return null;

    final key = _generateJDNKey(julianDayNumber);
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

    final key = _generateJDNKey(julianDayNumber);
    _westernDateCache.put(key, westernDate);
  }

  // ============================================================================
  // ASTRO INFO CACHE
  // ============================================================================

  /// Get cached AstroInfo
  AstroInfo? getAstroInfo(MyanmarDate myanmarDate) {
    if (!_config.enableCaching) return null;

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
  void putAstroInfo(MyanmarDate myanmarDate, AstroInfo astroInfo) {
    if (!_config.enableCaching) return;

    final key = _generateMyanmarDateKey(myanmarDate);
    _astroInfoCache.put(key, astroInfo);
  }

  // ============================================================================
  // HOLIDAY INFO CACHE
  // ============================================================================

  /// Get cached HolidayInfo
  HolidayInfo? getHolidayInfo(MyanmarDate myanmarDate) {
    if (!_config.enableCaching) return null;

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
  void putHolidayInfo(MyanmarDate myanmarDate, HolidayInfo holidayInfo) {
    if (!_config.enableCaching) return;

    final key = _generateMyanmarDateKey(myanmarDate);
    _holidayInfoCache.put(key, holidayInfo);
  }

  // ============================================================================
  // KEY GENERATION
  // ============================================================================

  String _generateDateKey(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
  }

  String _generateJDNKey(double julianDayNumber) {
    return julianDayNumber.toStringAsFixed(6);
  }

  String _generateMyanmarDateKey(MyanmarDate myanmarDate) {
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
  void clearCompleteDateCache() {
    _completeDateCache.clear();
  }

  /// Clear MyanmarDate cache only
  void clearMyanmarDateCache() {
    _myanmarDateCache.clear();
  }

  /// Clear WesternDate cache only
  void clearWesternDateCache() {
    _westernDateCache.clear();
  }

  /// Clear AstroInfo cache only
  void clearAstroInfoCache() {
    _astroInfoCache.clear();
  }

  /// Clear HolidayInfo cache only
  void clearHolidayInfoCache() {
    _holidayInfoCache.clear();
  }

  /// Warm up cache with common dates
  void warmUp({
    DateTime? startDate,
    DateTime? endDate,
    required MyanmarCalendarService service,
  }) {
    if (!_config.enableCaching) return;

    final start =
        startDate ?? DateTime.now().subtract(const Duration(days: 30));
    final end = endDate ?? DateTime.now().add(const Duration(days: 60));

    var currentDate = start;
    while (currentDate.isBefore(end) || currentDate.isAtSameMomentAs(end)) {
      // This will populate the cache
      service.getCompleteDate(currentDate);
      currentDate = currentDate.add(const Duration(days: 1));
    }
  }

  // ============================================================================
  // STATISTICS AND DIAGNOSTICS
  // ============================================================================

  /// Get cache hit rate
  double get hitRate {
    final total = _hits + _misses;
    if (total == 0) return 0;
    return _hits / total;
  }

  /// Get comprehensive cache statistics
  Map<String, dynamic> getStatistics() {
    final total = _hits + _misses;
    return {
      'enabled': _config.enableCaching,
      'hits': _hits,
      'misses': _misses,
      'total_requests': total,
      'hit_rate_percent': total > 0 ? (hitRate * 100).toStringAsFixed(2) : '0',
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

  /// Get current configuration
  CacheConfig get config => _config;

  /// Check if caching is enabled
  bool get isEnabled => _config.enableCaching;
}
