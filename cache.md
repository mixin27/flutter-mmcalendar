# 🚀 Caching System

Myanmar Calendar includes a powerful built-in caching system that significantly improves performance for repeated date operations.

## ⚡ Quick Start

### Zero Configuration

Caching works automatically with optimal default settings:

```dart
// No configuration needed - just use it!
final today = MyanmarCalendar.today();
final tomorrow = today.addDays(1);

// Repeated access is automatically cached
print(today.formatComplete());
```

### Basic Configuration

```dart
void main() {
  // Configure cache once at app startup
  MyanmarCalendar.configureCache(const CacheConfig.highPerformance());

  runApp(MyApp());
}
```

## 📊 Performance Improvements

| Operation | Without Cache | With Cache | Improvement |
|-----------|--------------|------------|-------------|
| Repeated date access | ~0.5ms | ~0.01ms | **50x faster** |
| Calendar widget (30 days) | ~15ms | ~3ms | **5x faster** |
| Year view (365 dates) | ~180ms | ~40ms | **4.5x faster** |

## 🎯 Configuration Profiles

### 1. Default Configuration

```dart
MyanmarCalendar.configureCache(const CacheConfig());
```

**Best for:** Most applications

| Setting | Value |
|---------|-------|
| CompleteDate cache | 100 entries |
| Other caches | 150-200 entries |
| Memory usage | ~200-300 KB |
| TTL | No expiration |

### 2. High Performance

```dart
MyanmarCalendar.configureCache(const CacheConfig.highPerformance());
```

**Best for:** Desktop apps, web apps, data processing

| Setting | Value |
|---------|-------|
| CompleteDate cache | 500 entries |
| Other caches | 500-1000 entries |
| Memory usage | ~500 KB - 1 MB |
| TTL | No expiration |

### 3. Memory Efficient

```dart
MyanmarCalendar.configureCache(const CacheConfig.memoryEfficient());
```

**Best for:** Mobile apps, resource-constrained environments

| Setting | Value |
|---------|-------|
| CompleteDate cache | 30 entries |
| Other caches | 40-50 entries |
| Memory usage | ~50-100 KB |
| TTL | 1 hour |

### 4. Disabled

```dart
MyanmarCalendar.configureCache(const CacheConfig.disabled());
```

**Best for:** Testing, debugging

All caching disabled. Every calculation is fresh.

## 💡 Common Use Cases

### Mobile App

```dart
void main() {
  // Use memory-efficient profile
  MyanmarCalendar.configureCache(const CacheConfig.memoryEfficient());

  runApp(MyApp());
}
```

### Calendar Widget

```dart
class CalendarScreen extends StatefulWidget {
  @override
  void initState() {
    super.initState();

    // Warm up cache for visible dates
    final now = DateTime.now();
    MyanmarCalendar.warmUpCache(
      startDate: DateTime(now.year, now.month - 1, 1),
      endDate: DateTime(now.year, now.month + 2, 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MyanmarCalendarWidget(
      initialDate: DateTime.now(),
      language: Language.myanmar,
      // Cache is automatically used ✅
    );
  }
}
```

### Date Picker

```dart
Future<void> pickDate(BuildContext context) async {
  // Pre-load cache before showing picker
  MyanmarCalendar.warmUpCache(
    startDate: DateTime.now(),
    endDate: DateTime.now().add(const Duration(days: 365)),
  );

  final selectedDate = await showMyanmarDatePicker(
    context: context,
    initialDate: DateTime.now(),
    language: Language.myanmar,
  );

  if (selectedDate != null) {
    print('Selected: ${selectedDate.formatComplete()}');
  }
}
```

## 🔧 Advanced Configuration

### Custom Cache Sizes

```dart
MyanmarCalendar.configureCache(CacheConfig(
  maxCompleteDateCacheSize: 200,
  maxMyanmarDateCacheSize: 300,
  maxWesternDateCacheSize: 300,
  maxAstroInfoCacheSize: 250,
  maxHolidayInfoCacheSize: 250,
  enableCaching: true,
  cacheTTL: 0, // No expiration
));
```

### Time-To-Live (TTL)

Cache entries expire after specified time:

```dart
MyanmarCalendar.configureCache(CacheConfig(
  cacheTTL: 1800, // 30 minutes in seconds
));
```

### Warm Up Cache

Pre-load frequently accessed dates:

```dart
// Warm up with 90 days of data
MyanmarCalendar.warmUpCache(
  startDate: DateTime.now(),
  endDate: DateTime.now().add(const Duration(days: 90)),
);
```

## 📈 Monitoring Performance

### Get Statistics

```dart
final stats = MyanmarCalendar.getCacheStatistics();

print('Cache Hit Rate: ${stats['hit_rate_percent']}%');
print('Total Requests: ${stats['total_requests']}');
print('Cache Hits: ${stats['hits']}');
print('Cache Misses: ${stats['misses']}');
print('Memory Entries: ${stats['total_memory_entries']}');
```

### Check Cache Status

```dart
final stats = MyanmarCalendar.getCacheStatistics();

if (stats['enabled'] == true) {
  final hitRate = double.parse(stats['hit_rate_percent']);

  if (hitRate < 50.0) {
    print('⚠️ Low hit rate - consider warming up cache');
  } else {
    print('✅ Cache is performing well');
  }
}
```

### Real-time Monitoring

```dart
void monitorCache() {
  // Reset stats to start fresh
  MyanmarCalendar.resetCacheStatistics();

  // Perform operations
  for (var i = 0; i < 100; i++) {
    MyanmarCalendar.today();
  }

  // Check performance
  final stats = MyanmarCalendar.getCacheStatistics();
  print('Hit rate: ${stats['hit_rate_percent']}%');
  print('Hits: ${stats['hits']} / Misses: ${stats['misses']}');
}
```

## 🧹 Cache Management

### Clear Cache

```dart
// Clear all cached data
MyanmarCalendar.clearCache();
```

### Reset Statistics

```dart
// Reset hit/miss counters
MyanmarCalendar.resetCacheStatistics();
```

### Reconfigure Cache

```dart
// Change configuration at runtime
MyanmarCalendar.configureCache(const CacheConfig.highPerformance());

// Note: Reconfiguring clears existing cache
```

## ✅ Best Practices

### Do ✓

- ✓ Use default configuration for most applications
- ✓ Warm up cache before showing calendar widgets
- ✓ Monitor cache hit rate in production
- ✓ Use memory-efficient profile on mobile devices
- ✓ Clear cache after major configuration changes
- ✓ Reset statistics when measuring performance

### Don't ✗

- ✗ Set cache sizes too large (wastes memory)
- ✗ Disable caching unless testing/debugging
- ✗ Clear cache too frequently (defeats purpose)
- ✗ Ignore low hit rates (< 50%)
- ✗ Forget to warm up cache for calendar widgets

## 🐛 Troubleshooting

### Problem: Low Performance

**Check if cache is enabled:**
```dart
final stats = MyanmarCalendar.getCacheStatistics();
print('Cache enabled: ${stats['enabled']}');
```

**If enabled but low hit rate, warm up cache:**
```dart
MyanmarCalendar.warmUpCache(
  startDate: DateTime.now(),
  endDate: DateTime.now().add(Duration(days: 30)),
);
```

### Problem: High Memory Usage

**Switch to memory-efficient profile:**
```dart
MyanmarCalendar.configureCache(const CacheConfig.memoryEfficient());
```

**Or customize cache sizes:**
```dart
MyanmarCalendar.configureCache(CacheConfig(
  maxCompleteDateCacheSize: 50,
  maxMyanmarDateCacheSize: 100,
  maxWesternDateCacheSize: 100,
));
```

### Problem: Stale Data

**Clear cache after configuration changes:**
```dart
MyanmarCalendar.configure(
  timezoneOffset: 7.0, // Changed setting
);
MyanmarCalendar.clearCache(); // Clear stale data
```

**Or use TTL for automatic expiration:**
```dart
MyanmarCalendar.configureCache(CacheConfig(
  cacheTTL: 3600, // 1 hour
));
```

## 📋 API Reference

### Configuration Methods

```dart
// Configure cache
MyanmarCalendar.configureCache(CacheConfig config);

// Get statistics
Map<String, dynamic> stats = MyanmarCalendar.getCacheStatistics();

// Clear cache
MyanmarCalendar.clearCache();

// Warm up cache
MyanmarCalendar.warmUpCache({
  DateTime? startDate,
  DateTime? endDate,
});

// Reset statistics
MyanmarCalendar.resetCacheStatistics();
```

### CacheConfig Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `maxCompleteDateCacheSize` | `int` | 100 | Max CompleteDate entries |
| `maxMyanmarDateCacheSize` | `int` | 200 | Max MyanmarDate entries |
| `maxWesternDateCacheSize` | `int` | 200 | Max WesternDate entries |
| `maxAstroInfoCacheSize` | `int` | 150 | Max AstroInfo entries |
| `maxHolidayInfoCacheSize` | `int` | 150 | Max HolidayInfo entries |
| `enableCaching` | `bool` | true | Enable/disable caching |
| `cacheTTL` | `int` | 0 | Time-to-live (seconds, 0 = no expiration) |

### Statistics Response

```dart
{
  'enabled': true,                    // Is caching enabled
  'hits': 850,                        // Cache hits
  'misses': 150,                      // Cache misses
  'total_requests': 1000,             // Total requests
  'hit_rate_percent': '85.00',        // Hit rate %
  'total_memory_entries': 450,        // Total cached entries
  'caches': {                         // Per-cache details
    'complete_date': {
      'size': 95,                     // Current entries
      'maxSize': 100,                 // Max entries
      'utilizationPercent': '95.00',  // Utilization %
      'ttl': 0,                       // Time-to-live
      'enabled': true                 // Cache enabled
    },
    // ... similar for other caches
  }
}
```

## 🎓 Complete Examples

### Example 1: Basic Usage

```dart
void main() {
  // Caching works automatically
  final date1 = MyanmarCalendar.today();
  final date2 = MyanmarCalendar.today(); // Cached! ⚡

  print(date1.formatComplete());
}
```

### Example 2: Performance Monitoring

```dart
void monitorPerformance() {
  MyanmarCalendar.resetCacheStatistics();

  // Perform 100 operations
  for (var i = 0; i < 100; i++) {
    MyanmarCalendar.today();
  }

  final stats = MyanmarCalendar.getCacheStatistics();
  print('Completed 100 operations');
  print('Hit rate: ${stats['hit_rate_percent']}%');
  print('Hits: ${stats['hits']} / Misses: ${stats['misses']}');
}
```

### Example 3: Calendar App

```dart
class MyCalendarApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalendarPage(),
    );
  }
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  void initState() {
    super.initState();

    // Configure for mobile
    MyanmarCalendar.configureCache(const CacheConfig.memoryEfficient());

    // Warm up visible range
    final now = DateTime.now();
    MyanmarCalendar.warmUpCache(
      startDate: DateTime(now.year, now.month - 1),
      endDate: DateTime(now.year, now.month + 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Myanmar Calendar')),
      body: MyanmarCalendarWidget(
        initialDate: DateTime.now(),
        language: Language.myanmar,
      ),
    );
  }
}
```

### Example 4: Batch Processing

```dart
Future<void> processDates() async {
  // Configure for high performance
  MyanmarCalendar.configureCache(const CacheConfig.highPerformance());

  // Process 1000 dates
  final results = <String>[];
  for (var i = 0; i < 1000; i++) {
    final date = MyanmarCalendar.fromWestern(2024, 1, (i % 28) + 1);
    results.add(date.formatMyanmar());
  }

  // Check cache efficiency
  final stats = MyanmarCalendar.getCacheStatistics();
  print('Processed ${results.length} dates');
  print('Cache hit rate: ${stats['hit_rate_percent']}%');
}
```

## 📚 Additional Resources

- [API Documentation](https://pub.dev/documentation/flutter_mmcalendar/latest/)
- [Examples](example/)
- [GitHub Repository](https://github.com/mixin27/flutter-mmcalendar)

## ⚡ Performance Tips

1. **Warm up cache** before displaying calendar widgets
2. **Use appropriate profile** for your platform (mobile/desktop)
3. **Monitor hit rate** to ensure cache is effective
4. **Batch operations** to maximize cache reuse
5. **Clear cache** only when necessary (configuration changes)

## 🆘 Support

If you encounter any issues with the caching system:

1. Check cache is enabled: `MyanmarCalendar.getCacheStatistics()['enabled']`
2. Monitor hit rate: Should be >50% for repeated operations
3. Try different profiles: `memoryEfficient` vs `highPerformance`
4. Clear cache: `MyanmarCalendar.clearCache()`
5. Report issues: [GitHub Issues](https://github.com/yourusername/flutter_mmcalendar/issues)

---

**Note:** The caching system is fully backward compatible. Existing code continues to work unchanged and automatically benefits from improved performance.
