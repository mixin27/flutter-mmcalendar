import '../core/calendar_config.dart';
import '../localization/language.dart';
import '../models/chronicle_models.dart';
import '../utils/chronicle_dynasties.dart';
import '../utils/chronicle_entries.dart';

/// Chronicle service for loading and managing chronicle data.
class ChronicleService {
  ///
  final CalendarConfig config;

  /// Language of the chronicle.
  final Language language;

  /// List of entries.
  List<ChronicleEntryData>? _entries; // same reference to const list

  /// List of dynasties.
  List<DynastyData>? _dynasties;

  /// Simple indices.
  List<ChronicleEntryData>? _sortedByStart;
  Map<String, List<ChronicleEntryData>>? _dynastyToEntries;

  /// Create a new Chronicle service.
  ChronicleService({required this.config, required this.language});

  /// Ensure the data is loaded.
  void _ensureLoaded() {
    _entries ??= kChronicleEntries;
    _dynasties ??= kDynasties;

    _sortedByStart ??= List<ChronicleEntryData>.from(_entries!)
      ..sort((a, b) => a.startJdn.compareTo(b.startJdn));

    if (_dynastyToEntries == null) {
      _dynastyToEntries = <String, List<ChronicleEntryData>>{};
      for (final e in _entries!) {
        if (e.dynastyId == null) continue;
        (_dynastyToEntries![e.dynastyId!] ??= <ChronicleEntryData>[]).add(e);
      }
      for (final list in _dynastyToEntries!.values) {
        list.sort((a, b) => a.startJdn.compareTo(b.startJdn));
      }
    }
  }

  /// Get entries by Julian day number.
  List<ChronicleEntryData> byJdn(double jdn) {
    _ensureLoaded();
    // For moderate data sizes, linear filter is fine. Otherwise binary search over _sortedByStart + span check.
    final result = <ChronicleEntryData>[];
    for (final e in _entries!) {
      if (e.includesJdn(jdn)) result.add(e);
    }
    return result;
  }

  /// Get dynasty by Julian day number.
  DynastyData? dynastyForJdn(double jdn) {
    _ensureLoaded();
    for (final d in _dynasties!) {
      if (jdn >= d.startJdn && jdn <= d.endJdn) return d;
    }
    return null;
  }
}
