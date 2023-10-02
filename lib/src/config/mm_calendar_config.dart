import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

final class MmCalendarConfig {
  CalendarType _calendarType = CalendarType.english;
  CalendarType get calendaryType => _calendarType;

  Language _language = Language.english;
  Language get language => _language;

  static MmCalendarConfig? _instance;
  static MmCalendarConfig get instance =>
      _instance ??= MmCalendarConfig._private(const MmCalendarOptions());

  MmCalendarConfig._private(MmCalendarOptions options) {
    _language = options.language;
    _calendarType = options.calendarType;
  }

  static void initDefault(MmCalendarOptions options) {
    _instance = MmCalendarConfig._private(options);
  }
}

final class MmCalendarOptions {
  final CalendarType calendarType;
  final Language language;

  const MmCalendarOptions({
    this.calendarType = CalendarType.english,
    this.language = Language.english,
  });
}
