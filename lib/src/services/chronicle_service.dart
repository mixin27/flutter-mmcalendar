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

  /// Get entries for a given dynasty ID (ordered by start date).
  List<ChronicleEntryData> entriesForDynasty(String dynastyId) {
    _ensureLoaded();
    return List<ChronicleEntryData>.from(
      _dynastyToEntries?[dynastyId] ?? const <ChronicleEntryData>[],
    );
  }

  /// Get chronicle entries whose span intersects the JDN range [startJdn, endJdn].
  List<ChronicleEntryData> betweenJdn(double startJdn, double endJdn) {
    _ensureLoaded();
    final double a = startJdn <= endJdn ? startJdn : endJdn;
    final double b = startJdn <= endJdn ? endJdn : startJdn;
    final result = <ChronicleEntryData>[];
    for (final e in _entries!) {
      final double ej0 = e.startJdn;
      final double ej1 = e.endJdn ?? double.infinity;
      if (ej0 <= b && ej1 >= a) {
        result.add(e);
      }
    }
    result.sort((x, y) => x.startJdn.compareTo(y.startJdn));
    return result;
  }

  /// List all dynasties (ordered by start date).
  List<DynastyData> allDynasties() {
    _ensureLoaded();
    final list = List<DynastyData>.from(_dynasties!);
    list.sort((a, b) => a.startJdn.compareTo(b.startJdn));
    return list;
  }

  /// Lookup a dynasty by ID.
  DynastyData? dynastyById(String dynastyId) {
    _ensureLoaded();
    for (final d in _dynasties!) {
      if (d.id == dynastyId) return d;
    }
    return null;
  }
}
