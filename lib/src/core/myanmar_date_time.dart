import 'package:flutter_mmcalendar/src/core/calendar_config.dart';
import 'package:flutter_mmcalendar/src/localization/language.dart';
import 'package:flutter_mmcalendar/src/models/astro_info.dart';
import 'package:flutter_mmcalendar/src/models/complete_date.dart';
import 'package:flutter_mmcalendar/src/models/holiday_info.dart';
import 'package:flutter_mmcalendar/src/models/myanmar_date.dart';
import 'package:flutter_mmcalendar/src/models/western_date.dart';
import 'package:flutter_mmcalendar/src/services/astro_calculator.dart';
import 'package:flutter_mmcalendar/src/services/date_converter.dart';
import 'package:flutter_mmcalendar/src/services/format_service.dart';
import 'package:flutter_mmcalendar/src/services/holiday_calculator.dart';
import 'package:flutter_mmcalendar/src/utils/calendar_constants.dart';
import 'package:flutter_mmcalendar/src/utils/calendar_utils.dart';

/// Myanmar DateTime class that provides a convenient interface for Myanmar calendar operations
///
/// This class acts as a wrapper around the DateConverter service, providing:
/// - Easy creation from various date sources
/// - Convenient getters for all date properties
/// - Factory constructors for different use cases
/// - Integration with Dart's DateTime class
/// - Astrological and holiday information access
class MyanmarDateTime {
  final DateConverter _converter;
  final AstroCalculator _astroCalculator;
  final HolidayCalculator _holidayCalculator;
  final double _julianDayNumber;

  // Cache for computed properties
  MyanmarDate? _myanmarDate;
  WesternDate? _westernDate;
  AstroInfo? _astroInfo;
  HolidayInfo? _holidayInfo;

  /// Private constructor
  MyanmarDateTime._(
    this._converter,
    this._astroCalculator,
    this._holidayCalculator,
    this._julianDayNumber,
  );

  // ============================================================================
  // FACTORY CONSTRUCTORS
  // ============================================================================

  /// Creates Myanmar DateTime from current date/time
  factory MyanmarDateTime.now({CalendarConfig? config}) {
    final converter = DateConverter(config ?? const CalendarConfig());
    final astroCalculator = AstroCalculator();
    final holidayCalculator = HolidayCalculator();

    // Get current UTC time and convert to Julian Day Number
    final now = DateTime.now().toUtc();
    final jdn = converter.westernToJulian(
      now.year,
      now.month,
      now.day,
      now.hour,
      now.minute,
      now.second,
    );

    return MyanmarDateTime._(
      converter,
      astroCalculator,
      holidayCalculator,
      jdn,
    );
  }

  /// Creates Myanmar DateTime from DateTime object
  factory MyanmarDateTime.fromDateTime(
    DateTime dateTime, {
    CalendarConfig? config,
  }) {
    final converter = DateConverter(config ?? const CalendarConfig());
    final astroCalculator = AstroCalculator();
    final holidayCalculator = HolidayCalculator();

    final jdn = converter.westernToJulian(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
    );

    return MyanmarDateTime._(
      converter,
      astroCalculator,
      holidayCalculator,
      jdn,
    );
  }

  /// Creates Myanmar DateTime from Western date components
  factory MyanmarDateTime.fromWestern(
    int year,
    int month,
    int day, {
    int hour = 12,
    int minute = 0,
    int second = 0,
    CalendarConfig? config,
  }) {
    final converter = DateConverter(config ?? const CalendarConfig());
    final astroCalculator = AstroCalculator();
    final holidayCalculator = HolidayCalculator();

    final jdn = converter.westernToJulian(
      year,
      month,
      day,
      hour,
      minute,
      second,
    );

    return MyanmarDateTime._(
      converter,
      astroCalculator,
      holidayCalculator,
      jdn,
    );
  }

  /// Creates Myanmar DateTime from Myanmar date components
  factory MyanmarDateTime.fromMyanmar(
    int year,
    int month,
    int day, {
    int hour = 12,
    int minute = 0,
    int second = 0,
    CalendarConfig? config,
  }) {
    final converter = DateConverter(config ?? const CalendarConfig());
    final astroCalculator = AstroCalculator();
    final holidayCalculator = HolidayCalculator();

    final jdn = converter.myanmarToJulian(
      year,
      month,
      day,
      hour,
      minute,
      second,
    );

    return MyanmarDateTime._(
      converter,
      astroCalculator,
      holidayCalculator,
      jdn,
    );
  }

  /// Creates Myanmar DateTime from MyanmarDate object
  factory MyanmarDateTime.fromMyanmarDate(
    MyanmarDate myanmarDate, {
    CalendarConfig? config,
  }) {
    final converter = DateConverter(config ?? const CalendarConfig());
    final astroCalculator = AstroCalculator();
    final holidayCalculator = HolidayCalculator();

    return MyanmarDateTime._(
      converter,
      astroCalculator,
      holidayCalculator,
      myanmarDate.julianDayNumber,
    );
  }

  /// Creates Myanmar DateTime from WesternDate object
  factory MyanmarDateTime.fromWesternDate(
    WesternDate westernDate, {
    CalendarConfig? config,
  }) {
    final converter = DateConverter(config ?? const CalendarConfig());
    final astroCalculator = AstroCalculator();
    final holidayCalculator = HolidayCalculator();

    return MyanmarDateTime._(
      converter,
      astroCalculator,
      holidayCalculator,
      westernDate.julianDayNumber,
    );
  }

  /// Creates Myanmar DateTime from Julian Day Number
  factory MyanmarDateTime.fromJulianDay(
    double julianDayNumber, {
    CalendarConfig? config,
  }) {
    final converter = DateConverter(config ?? const CalendarConfig());
    final astroCalculator = AstroCalculator();
    final holidayCalculator = HolidayCalculator();

    return MyanmarDateTime._(
      converter,
      astroCalculator,
      holidayCalculator,
      julianDayNumber,
    );
  }

  /// Creates Myanmar DateTime from milliseconds since epoch
  factory MyanmarDateTime.fromMillisecondsSinceEpoch(
    int milliseconds, {
    bool isUtc = false,
    CalendarConfig? config,
  }) {
    final dateTime = isUtc
        ? DateTime.fromMillisecondsSinceEpoch(milliseconds, isUtc: true)
        : DateTime.fromMillisecondsSinceEpoch(milliseconds);

    return MyanmarDateTime.fromDateTime(dateTime, config: config);
  }

  // ============================================================================
  // GETTERS - BASIC PROPERTIES
  // ============================================================================

  /// Julian Day Number for this date
  double get julianDayNumber => _julianDayNumber;

  /// Julian Day Number adjusted for local timezone
  double get localJulianDayNumber =>
      _julianDayNumber + _converter.config.timezoneOffset / 24.0;

  /// Rounded Julian Day Number
  int get julianDay => _julianDayNumber.round();

  /// Rounded local Julian Day Number
  int get localJulianDay => localJulianDayNumber.round();

  /// Calendar configuration
  CalendarConfig get config => _converter.config;

  // ============================================================================
  // GETTERS - MYANMAR DATE PROPERTIES
  // ============================================================================

  /// Myanmar date object (cached)
  MyanmarDate get myanmarDate {
    _myanmarDate ??= _converter.julianToMyanmar(_julianDayNumber);
    return _myanmarDate!;
  }

  /// Myanmar year
  int get myanmarYear => myanmarDate.year;

  /// Myanmar month (0-14)
  int get myanmarMonth => myanmarDate.month;

  /// Myanmar day (1-30)
  int get myanmarDay => myanmarDate.day;

  /// Year type (0=common, 1=little watat, 2=big watat)
  int get yearType => myanmarDate.yearType;

  /// Sasana year
  int get sasanaYear => myanmarDate.sasanaYear;

  /// Month length (29 or 30 days)
  int get monthLength => myanmarDate.monthLength;

  /// Moon phase (0=waxing, 1=full moon, 2=waning, 3=new moon)
  int get moonPhase => myanmarDate.moonPhase;

  /// Fortnight day (1-15)
  int get fortnightDay => myanmarDate.fortnightDay;

  /// Weekday (0=Saturday, 1=Sunday, ..., 6=Friday)
  int get weekday => myanmarDate.weekday;

  // ============================================================================
  // GETTERS - WESTERN DATE PROPERTIES
  // ============================================================================

  /// Western date object (cached)
  WesternDate get westernDate {
    _westernDate ??= _converter.julianToWestern(_julianDayNumber);
    return _westernDate!;
  }

  /// Western year
  int get westernYear => westernDate.year;

  /// Western month (1-12)
  int get westernMonth => westernDate.month;

  /// Western day (1-31)
  int get westernDay => westernDate.day;

  /// Hour (0-23)
  int get hour => westernDate.hour;

  /// Minute (0-59)
  int get minute => westernDate.minute;

  /// Second (0-59)
  int get second => westernDate.second;

  /// Millisecond (0-999)
  int get millisecond => westernDate.millisecond;

  // ============================================================================
  // GETTERS - ASTROLOGICAL PROPERTIES
  // ============================================================================

  /// Astrological information (cached)
  AstroInfo get astroInfo {
    _astroInfo ??= _astroCalculator.calculate(myanmarDate);
    return _astroInfo!;
  }

  /// List of astrological days
  List<String> get astrologicalDays => astroInfo.astrologicalDays;

  /// Sabbath information
  String get sabbath => astroInfo.sabbath;

  /// Yatyaza information
  String get yatyaza => astroInfo.yatyaza;

  /// Pyathada information
  String get pyathada => astroInfo.pyathada;

  /// Naga head direction
  String get nagahle => astroInfo.nagahle;

  /// Mahabote value
  String get mahabote => astroInfo.mahabote;

  /// Nakhat value
  String get nakhat => astroInfo.nakhat;

  /// Year name from 12-year cycle
  String get yearName => astroInfo.yearName;

  // ============================================================================
  // GETTERS - HOLIDAY PROPERTIES
  // ============================================================================

  /// Holiday information (cached)
  HolidayInfo get holidayInfo {
    _holidayInfo ??= _holidayCalculator.getHolidays(myanmarDate);
    return _holidayInfo!;
  }

  /// All holidays
  List<String> get allHolidays => holidayInfo.allHolidays;

  /// Public holidays
  List<String> get publicHolidays => holidayInfo.publicHolidays;

  /// Religious holidays
  List<String> get religiousHolidays => holidayInfo.religiousHolidays;

  /// Cultural holidays
  List<String> get culturalHolidays => holidayInfo.culturalHolidays;

  // ============================================================================
  // GETTERS - BOOLEAN PROPERTIES
  // ============================================================================

  /// Check if this is a watat year
  bool get isWatatYear => yearType > 0;

  /// Check if this is a big watat year
  bool get isBigWatatYear => yearType == 2;

  /// Check if this is a little watat year
  bool get isLittleWatatYear => yearType == 1;

  /// Check if this is a common year
  bool get isCommonYear => yearType == 0;

  /// Check if this is a sabbath day
  bool get isSabbath => sabbath == 'Sabbath';

  /// Check if this is a sabbath eve
  bool get isSabbathEve => sabbath == 'Sabbath Eve';

  /// Check if this is a yatyaza day
  bool get isYatyaza => yatyaza == 'Yatyaza';

  /// Check if this has pyathada
  bool get hasPyathada => pyathada.isNotEmpty;

  /// Check if this date has holidays
  bool get hasHolidays => holidayInfo.hasHolidays;

  /// Check if this date has anniversary days
  bool get hasAnniversaryDays => holidayInfo.hasAnniversaryDays;

  /// Check if this date has astrological significance
  bool get hasAstrologicalDays => astrologicalDays.isNotEmpty;

  /// Check if this is a full moon day
  bool get isFullMoon => moonPhase == CalendarConstants.moonPhaseFullMoon;

  /// Check if this is a new moon day
  bool get isNewMoon => moonPhase == CalendarConstants.moonPhaseNewMoon;

  /// Check if this is in waxing phase
  bool get isWaxing => moonPhase == CalendarConstants.moonPhaseWaxing;

  /// Check if this is in waning phase
  bool get isWaning => moonPhase == CalendarConstants.moonPhaseWaning;

  // ============================================================================
  // DATE ARITHMETIC METHODS
  // ============================================================================

  /// Add days to this Myanmar DateTime
  MyanmarDateTime addDays(int days) {
    final newJdn = _julianDayNumber + days;
    return MyanmarDateTime._(
      _converter,
      _astroCalculator,
      _holidayCalculator,
      newJdn,
    );
  }

  /// Subtract days from this Myanmar DateTime
  MyanmarDateTime subtractDays(int days) {
    return addDays(-days);
  }

  /// Add hours to this Myanmar DateTime
  MyanmarDateTime addHours(int hours) {
    final newJdn = _julianDayNumber + (hours / 24.0);
    return MyanmarDateTime._(
      _converter,
      _astroCalculator,
      _holidayCalculator,
      newJdn,
    );
  }

  /// Add minutes to this Myanmar DateTime
  MyanmarDateTime addMinutes(int minutes) {
    final newJdn = _julianDayNumber + (minutes / 1440.0); // 24 * 60
    return MyanmarDateTime._(
      _converter,
      _astroCalculator,
      _holidayCalculator,
      newJdn,
    );
  }

  /// Add seconds to this Myanmar DateTime
  MyanmarDateTime addSeconds(int seconds) {
    final newJdn = _julianDayNumber + (seconds / 86400.0); // 24 * 60 * 60
    return MyanmarDateTime._(
      _converter,
      _astroCalculator,
      _holidayCalculator,
      newJdn,
    );
  }

  /// Add a Duration to this Myanmar DateTime
  MyanmarDateTime add(Duration duration) {
    final newJdn = _julianDayNumber + (duration.inMicroseconds / 86400000000.0);
    return MyanmarDateTime._(
      _converter,
      _astroCalculator,
      _holidayCalculator,
      newJdn,
    );
  }

  /// Subtract a Duration from this Myanmar DateTime
  MyanmarDateTime subtract(Duration duration) {
    return add(-duration);
  }

  /// Calculate difference between this and another Myanmar DateTime
  Duration difference(MyanmarDateTime other) {
    final dayDifference = _julianDayNumber - other._julianDayNumber;
    final microseconds = (dayDifference * 86400000000.0).round();
    return Duration(microseconds: microseconds);
  }

  /// Calculate difference in days between this and another Myanmar DateTime
  int differenceInDays(MyanmarDateTime other) {
    return (_julianDayNumber - other._julianDayNumber).round();
  }

  // ============================================================================
  // COMPARISON METHODS
  // ============================================================================

  /// Check if this is before another Myanmar DateTime
  bool isBefore(MyanmarDateTime other) {
    return _julianDayNumber < other._julianDayNumber;
  }

  /// Check if this is after another Myanmar DateTime
  bool isAfter(MyanmarDateTime other) {
    return _julianDayNumber > other._julianDayNumber;
  }

  /// Check if this is at the same moment as another Myanmar DateTime
  bool isAtSameMomentAs(MyanmarDateTime other) {
    return _julianDayNumber == other._julianDayNumber;
  }

  /// Compare this with another Myanmar DateTime
  /// Returns -1 if before, 0 if same, 1 if after
  int compareTo(MyanmarDateTime other) {
    return _julianDayNumber.compareTo(other._julianDayNumber);
  }

  // ============================================================================
  // CONVERSION METHODS
  // ============================================================================

  /// Convert to Dart DateTime object
  DateTime toDateTime() {
    return westernDate.toDateTime();
  }

  /// Convert to UTC DateTime object
  DateTime toUtc() {
    final localDateTime = toDateTime();
    final offsetMinutes = (_converter.config.timezoneOffset * 60).round();
    return localDateTime.subtract(Duration(minutes: offsetMinutes));
  }

  /// Get milliseconds since epoch
  int get millisecondsSinceEpoch => toDateTime().millisecondsSinceEpoch;

  /// Get microseconds since epoch
  int get microsecondsSinceEpoch => toDateTime().microsecondsSinceEpoch;

  /// Create a copy with different time components
  MyanmarDateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    bool? isUtc,
  }) {
    final currentWestern = westernDate;

    final newJdn = _converter.westernToJulian(
      year ?? currentWestern.year,
      month ?? currentWestern.month,
      day ?? currentWestern.day,
      hour ?? currentWestern.hour,
      minute ?? currentWestern.minute,
      second ?? currentWestern.second,
    );

    return MyanmarDateTime._(
      _converter,
      _astroCalculator,
      _holidayCalculator,
      newJdn,
    );
  }

  /// Create a copy with different Myanmar date components
  MyanmarDateTime copyWithMyanmar({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
  }) {
    final currentMyanmar = myanmarDate;
    final currentWestern = westernDate;

    final newJdn = _converter.myanmarToJulian(
      year ?? currentMyanmar.year,
      month ?? currentMyanmar.month,
      day ?? currentMyanmar.day,
      hour ?? currentWestern.hour,
      minute ?? currentWestern.minute,
      second ?? currentWestern.second,
    );

    return MyanmarDateTime._(
      _converter,
      _astroCalculator,
      _holidayCalculator,
      newJdn,
    );
  }

  // ============================================================================
  // UTILITY METHODS
  // ============================================================================

  /// Get the start of the day (00:00:00)
  MyanmarDateTime get startOfDay {
    return copyWith(hour: 0, minute: 0, second: 0, millisecond: 0);
  }

  /// Get the end of the day (23:59:59.999)
  MyanmarDateTime get endOfDay {
    return copyWith(hour: 23, minute: 59, second: 59, millisecond: 999);
  }

  /// Get the start of the month (first day, 00:00:00)
  MyanmarDateTime get startOfMonth {
    return copyWith(day: 1, hour: 0, minute: 0, second: 0, millisecond: 0);
  }

  /// Get the end of the month (last day, 23:59:59.999)
  MyanmarDateTime get endOfMonth {
    final daysInMonth = monthLength;
    return copyWith(
      day: daysInMonth,
      hour: 23,
      minute: 59,
      second: 59,
      millisecond: 999,
    );
  }

  /// Get the start of the year (Tagu 1, 00:00:00)
  MyanmarDateTime get startOfYear {
    return copyWithMyanmar(month: 1, day: 1, hour: 0, minute: 0, second: 0);
  }

  /// Check if this date is in the same day as another
  bool isSameDay(MyanmarDateTime other) {
    return startOfDay.isAtSameMomentAs(other.startOfDay);
  }

  /// Check if this date is in the same month as another
  bool isSameMonth(MyanmarDateTime other) {
    final thisMyanmar = myanmarDate;
    final otherMyanmar = other.myanmarDate;
    return thisMyanmar.year == otherMyanmar.year &&
        thisMyanmar.month == otherMyanmar.month;
  }

  /// Check if this date is in the same year as another
  bool isSameYear(MyanmarDateTime other) {
    return myanmarYear == other.myanmarYear;
  }

  /// Get complete date information
  CompleteDate get completeDate {
    return CompleteDate(
      western: westernDate,
      myanmar: myanmarDate,
      astro: astroInfo,
      holidays: holidayInfo,
    );
  }

  // ============================================================================
  // FORMATTING METHODS
  // ============================================================================

  /// Format Myanmar date with pattern
  String formatMyanmar([String? pattern, Language? language]) {
    final formatService = FormatService();
    return formatService.formatMyanmarDate(
      myanmarDate,
      pattern: pattern,
      language: language,
    );
  }

  /// Format Western date with pattern
  String formatWestern([String? pattern, Language? language]) {
    final formatService = FormatService();
    return formatService.formatWesternDate(
      westernDate,
      pattern: pattern,
      language: language,
    );
  }

  /// Format complete date information
  String formatComplete({
    String? myanmarPattern,
    String? westernPattern,
    Language? language,
    bool includeAstro = false,
    bool includeHolidays = false,
  }) {
    final formatService = FormatService();
    return formatService.formatCompleteDate(
      completeDate,
      myanmarPattern: myanmarPattern,
      westernPattern: westernPattern,
      language: language,
      includeAstro: includeAstro,
      includeHolidays: includeHolidays,
    );
  }

  // ============================================================================
  // STATIC UTILITY METHODS
  // ============================================================================

  /// Parse Myanmar date string
  static MyanmarDateTime? parseMyanmar(
    String dateString, {
    CalendarConfig? config,
  }) {
    final parsedDate = CalendarUtils.parseMyanmarDateString(dateString);
    if (parsedDate != null) {
      return MyanmarDateTime.fromMyanmarDate(parsedDate, config: config);
    }
    return null;
  }

  /// Parse Western date string
  static MyanmarDateTime? parseWestern(
    String dateString, {
    CalendarConfig? config,
  }) {
    try {
      final dateTime = DateTime.parse(dateString);
      return MyanmarDateTime.fromDateTime(dateTime, config: config);
    } catch (e) {
      return null;
    }
  }

  /// Create from timestamp (seconds since epoch)
  static MyanmarDateTime fromTimestamp(
    int timestamp, {
    CalendarConfig? config,
  }) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return MyanmarDateTime.fromDateTime(dateTime, config: config);
  }

  // ============================================================================
  // OVERRIDDEN METHODS
  // ============================================================================

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MyanmarDateTime &&
        other._julianDayNumber == _julianDayNumber;
  }

  @override
  int get hashCode => _julianDayNumber.hashCode;

  @override
  String toString() {
    return 'MyanmarDateTime('
        'MY: $myanmarYear/$myanmarMonth/$myanmarDay, '
        'WD: $westernYear-${westernMonth.toString().padLeft(2, '0')}-${westernDay.toString().padLeft(2, '0')} '
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}, '
        'JD: $julianDay'
        ')';
  }

  /// Detailed string representation
  String toDetailedString() {
    return completeDate.toDetailedString();
  }

  /// Compact string representation
  String toCompactString() {
    return completeDate.toCompactString();
  }

  /// Convert to Map for serialization
  Map<String, dynamic> toMap() {
    return completeDate.toMap();
  }

  /// Create from Map (deserialization)
  static MyanmarDateTime fromMap(
    Map<String, dynamic> map, {
    CalendarConfig? config,
  }) {
    final completeDate = CompleteDate.fromMap(map);
    return MyanmarDateTime.fromJulianDay(
      completeDate.julianDayNumber,
      config: config,
    );
  }
}
