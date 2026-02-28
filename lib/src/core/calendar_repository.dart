// ignore_for_file: implementation_imports, public_member_api_docs

import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';
import 'package:myanmar_calendar_dart/src/services/myanmar_calendar_service.dart';

/// Thin adapter used by widgets so UI code does not depend on global state.
class CalendarRepository {
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

  Language get language => _language;

  CalendarConfig? get config => _config;

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

  MyanmarDate getMyanmarDate(DateTime dateTime) {
    return _service.westernToMyanmar(dateTime);
  }

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

  void clear() {
    _cache.clear();
  }

  String _cacheKey(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }
}
