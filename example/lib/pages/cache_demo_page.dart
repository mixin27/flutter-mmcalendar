import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class CacheDemoApp extends StatelessWidget {
  const CacheDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Myanmar Calendar Cache Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const CacheDemoPage(),
    );
  }
}

class CacheDemoPage extends StatefulWidget {
  const CacheDemoPage({super.key});

  @override
  State<CacheDemoPage> createState() => _CacheDemoPageState();
}

class _CacheDemoPageState extends State<CacheDemoPage> {
  Map<String, dynamic>? _cacheStats;
  String _selectedProfile = 'Default';
  bool _isLoading = false;
  final List<String> _logs = [];

  @override
  void initState() {
    super.initState();
    _updateStats();
  }

  void _updateStats() {
    setState(() {
      _cacheStats = MyanmarCalendar.getCacheStatistics();
    });
  }

  void _log(String message) {
    log(message);
    setState(() {
      _logs.insert(
        0,
        '${DateTime.now().toIso8601String().substring(11, 19)} - $message',
      );
      if (_logs.length > 10) _logs.removeLast();
    });
  }

  Future<void> _changeProfile(String profile) async {
    setState(() {
      _selectedProfile = profile;
      _isLoading = true;
    });

    _log('Changing to $profile profile...');

    switch (profile) {
      case 'High Performance':
        MyanmarCalendar.configureCache(const CacheConfig.highPerformance());
        break;
      case 'Memory Efficient':
        MyanmarCalendar.configureCache(const CacheConfig.memoryEfficient());
        break;
      case 'Default':
        MyanmarCalendar.configureCache(const CacheConfig());
        break;
      case 'Disabled':
        MyanmarCalendar.configureCache(const CacheConfig.disabled());
        break;
    }

    await Future.delayed(const Duration(milliseconds: 500));

    _log('Profile changed to $profile');
    _updateStats();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _warmUpCache() async {
    setState(() => _isLoading = true);

    _log('Warming up cache with 90 days...');

    final stopwatch = Stopwatch()..start();

    try {
      MyanmarCalendar.warmUpCache(
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 90)),
      );
      stopwatch.stop();
      _log('Cache warmed up in ${stopwatch.elapsedMilliseconds}ms');
    } catch (e) {
      stopwatch.stop();
      _log('Error warming up cache: $e');
    }

    _updateStats();
    setState(() => _isLoading = false);
  }

  Future<void> _testPerformance() async {
    setState(() => _isLoading = true);

    _log('Testing performance with 1000 date conversions...');

    // Reset stats to measure accurately
    MyanmarCalendar.resetCacheStatistics();

    final stopwatch = Stopwatch()..start();

    try {
      // Convert 1000 dates (with repetition for cache hits)
      for (var i = 0; i < 1000; i++) {
        MyanmarCalendar.fromWestern(2024, 1, (i % 28) + 1);
      }
      stopwatch.stop();
      _log('Completed in ${stopwatch.elapsedMilliseconds}ms');

      final stats = MyanmarCalendar.getCacheStatistics();
      final hitRate = stats['hit_rate_percent'] as String;
      _log('Cache hit rate: $hitRate%');
    } catch (e) {
      stopwatch.stop();
      _log('Error: $e');
    }

    _updateStats();
    setState(() => _isLoading = false);
  }

  void _clearCache() {
    _log('Clearing cache...');
    MyanmarCalendar.clearCache();
    _log('Cache cleared');
    _updateStats();
  }

  void _resetStats() {
    _log('Resetting statistics...');
    MyanmarCalendar.resetCacheStatistics();
    _log('Statistics reset');
    _updateStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Myanmar Calendar Cache Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _updateStats,
            tooltip: 'Refresh Stats',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(),
                  const SizedBox(height: 16),
                  _buildProfileSelector(),
                  const SizedBox(height: 16),
                  _buildActionButtons(),
                  const SizedBox(height: 16),
                  _buildStatisticsCard(),
                  const SizedBox(height: 16),
                  _buildCacheDetailsCard(),
                  const SizedBox(height: 16),
                  _buildLogsCard(),
                ],
              ),
            ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue.shade700),
                const SizedBox(width: 8),
                Text(
                  'Cache System Demo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'This demo shows the Myanmar Calendar caching system in action. '
              'Try different profiles and observe the performance improvements!',
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSelector() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cache Profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  [
                    'High Performance',
                    'Default',
                    'Memory Efficient',
                    'Disabled',
                  ].map((profile) {
                    final isSelected = profile == _selectedProfile;
                    return ChoiceChip(
                      label: Text(profile),
                      selected: isSelected,
                      onSelected: (_) => _changeProfile(profile),
                      selectedColor: Colors.blue,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 8),
            Text(
              _getProfileDescription(_selectedProfile),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getProfileDescription(String profile) {
    switch (profile) {
      case 'High Performance':
        return 'Large cache sizes (500-1000 entries) for maximum speed';
      case 'Default':
        return 'Balanced cache sizes (100-200 entries) for typical use';
      case 'Memory Efficient':
        return 'Small cache sizes (30-50 entries) with 1-hour TTL';
      case 'Disabled':
        return 'No caching - all calculations are fresh';
      default:
        return '';
    }
  }

  Widget _buildActionButtons() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Actions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _warmUpCache,
                  icon: const Icon(Icons.wb_sunny),
                  label: const Text('Warm Up Cache'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black87,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _testPerformance,
                  icon: const Icon(Icons.speed),
                  label: const Text('Test Performance'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _clearCache,
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear Cache'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _resetStats,
                  icon: const Icon(Icons.restart_alt),
                  label: const Text('Reset Stats'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCard() {
    if (_cacheStats == null) return const SizedBox.shrink();

    final enabled = _cacheStats!['enabled'] as bool;
    final hits = _cacheStats!['hits'] as int;
    final misses = _cacheStats!['misses'] as int;
    final total = _cacheStats!['total_requests'] as int;
    final hitRate = _cacheStats!['hit_rate_percent'] as String;
    final totalEntries = _cacheStats!['total_memory_entries'] as int;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Cache Statistics',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    enabled ? 'ENABLED' : 'DISABLED',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  backgroundColor: enabled ? Colors.green : Colors.red,
                  labelStyle: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildStatRow('Total Requests', total.toString(), Icons.all_inbox),
            _buildStatRow(
              'Cache Hits',
              hits.toString(),
              Icons.check_circle,
              color: Colors.green,
            ),
            _buildStatRow(
              'Cache Misses',
              misses.toString(),
              Icons.cancel,
              color: Colors.red,
            ),
            _buildStatRow(
              'Hit Rate',
              '$hitRate%',
              Icons.trending_up,
              color: Colors.blue,
            ),
            _buildStatRow(
              'Total Entries',
              totalEntries.toString(),
              Icons.storage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: color ?? Colors.grey),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: const TextStyle(fontSize: 14))),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCacheDetailsCard() {
    if (_cacheStats == null) return const SizedBox.shrink();

    final caches = _cacheStats!['caches'] as Map<String, dynamic>;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cache Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ...caches.entries.map((entry) {
              final cacheName = entry.key;
              final cacheData = entry.value as Map<String, dynamic>;
              final size = cacheData['size'] as int;
              final maxSize = cacheData['maxSize'] as int;
              final utilization = cacheData['utilizationPercent'] as String;

              return _buildCacheDetailRow(
                _formatCacheName(cacheName),
                size,
                maxSize,
                utilization,
              );
            }),
          ],
        ),
      ),
    );
  }

  String _formatCacheName(String name) {
    return name
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Widget _buildCacheDetailRow(
    String name,
    int size,
    int maxSize,
    String utilization,
  ) {
    final percentage = double.tryParse(utilization) ?? 0.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontSize: 14)),
              Text(
                '$size / $maxSize',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: maxSize > 0 ? (percentage / 100) : 0,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              percentage > 80 ? Colors.red : Colors.blue,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            '$utilization% utilized',
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildLogsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Activity Log',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (_logs.isEmpty)
              const Text(
                'No activity yet. Try performing some actions above!',
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              )
            else
              ..._logs.map(
                (log) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.fiber_manual_record,
                        size: 8,
                        color: Colors.blue,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          log,
                          style: const TextStyle(
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
