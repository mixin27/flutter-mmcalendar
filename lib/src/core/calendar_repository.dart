// ignore_for_file: implementation_imports, public_member_api_docs

import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';
import 'package:myanmar_calendar_dart/src/services/myanmar_calendar_service.dart';

/// Thin adapter used by widgets so UI code does not depend on global state.
class CalendarRepository {
  /// Creates a repository bound to a [language] and optional [config].
  CalendarRepository({required Language language, CalendarConfig? config})
    : _language = language,
      _config = config,
      _service = MyanmarCalendarService(
        config: config,
        defaultLanguage: language,
      );

  MyanmarCalendarService _service;
  Language _language;
  CalendarConfig? _config;
  final Map<String, CompleteDate> _cache = <String, CompleteDate>{};

  /// Current language used for formatting and translations.
  Language get language => _language;

  /// Active configuration used by the internal calendar service.
  CalendarConfig? get config => _config;

  /// Rebuilds internal services when language/config changes.
  void reconfigure({required Language language, CalendarConfig? config}) {
    if (_language == language && _config == config) {
      return;
    }

    _language = language;
    _config = config;
    _service = MyanmarCalendarService(
      config: config,
      defaultLanguage: language,
    );
    _cache.clear();
  }

  /// Returns cached or calculated [CompleteDate] for the given day.
  CompleteDate getCompleteDate(DateTime dateTime) {
    final dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
    final key = _cacheKey(dateOnly);
    final cached = _cache[key];
    if (cached != null) {
      return cached;
    }

    final complete = _service.getCompleteDate(dateOnly, language: _language);
    _cache[key] = complete;
    return complete;
  }

  /// Converts western [DateTime] to [MyanmarDate].
  MyanmarDate getMyanmarDate(DateTime dateTime) {
    return _service.westernToMyanmar(dateTime);
  }

  /// Formats a [MyanmarDate] using the current or overridden language.
  String formatMyanmar(
    MyanmarDate date, {
    String? pattern,
    Language? language,
  }) {
    return _service.formatMyanmarDate(
      date,
      pattern: pattern,
      language: language ?? _language,
    );
  }

  /// Formats a [WesternDate] using the current or overridden language.
  String formatWestern(
    WesternDate date, {
    String? pattern,
    Language? language,
  }) {
    return _service.formatWesternDate(
      date,
      pattern: pattern,
      language: language ?? _language,
    );
  }

  /// Clears in-memory date cache.
  void clear() {
    _cache.clear();
  }

  String _cacheKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
}
