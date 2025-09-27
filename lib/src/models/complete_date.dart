import 'astro_info.dart';
import 'holiday_info.dart';
import 'myanmar_date.dart';
import 'western_date.dart';

/// Complete date information combining all calendars and calculations
///
/// This class represents a complete date that includes Myanmar date, Western date,
/// astrological information, and holiday information all in one comprehensive object.
/// It serves as the primary data model for applications that need full calendar
/// information for any given date.
///
/// Example:
/// ```dart
/// final completeDate = CompleteDate(
///   western: westernDate,
///   myanmar: myanmarDate,
///   astro: astroInfo,
///   holidays: holidayInfo,
/// );
///
/// // Access different aspects of the date
/// print('Myanmar: ${completeDate.myanmar.year}/${completeDate.myanmar.month}/${completeDate.myanmar.day}');
/// print('Western: ${completeDate.western.year}-${completeDate.western.month}-${completeDate.western.day}');
/// print('Astrological days: ${completeDate.astro.astrologicalDays}');
/// print('Holidays: ${completeDate.holidays.allHolidays}');
///
/// ```
class CompleteDate {
  /// Western calendar date information
  final WesternDate western;

  /// Myanmar calendar date information
  final MyanmarDate myanmar;

  /// Astrological and astronomical information
  final AstroInfo astro;

  /// Holiday and special day information
  final HolidayInfo holidays;

  /// Creates a complete date with all calendar systems and information
  ///
  /// All parameters are required as a complete date should contain information
  /// from all supported calendar systems and calculation services.
  const CompleteDate({
    required this.western,
    required this.myanmar,
    required this.astro,
    required this.holidays,
  });

  /// Creates a copy of this complete date with optionally updated values
  ///
  /// This method allows you to create a new [CompleteDate] based on this one
  /// but with some values changed. Only non-null parameters will be updated.
  ///
  /// Example:
  /// ```dart
  /// final updatedDate = completeDate.copyWith(
  ///   astro: newAstroInfo,
  ///   holidays: newHolidayInfo,
  /// );
  /// ```
  CompleteDate copyWith({
    WesternDate? western,
    MyanmarDate? myanmar,
    AstroInfo? astro,
    HolidayInfo? holidays,
  }) {
    return CompleteDate(
      western: western ?? this.western,
      myanmar: myanmar ?? this.myanmar,
      astro: astro ?? this.astro,
      holidays: holidays ?? this.holidays,
    );
  }

  /// Gets the Julian Day Number for this date
  ///
  /// Returns the Julian Day Number from the Myanmar date, which should be
  /// consistent with the Western date's JDN.
  double get julianDayNumber => myanmar.julianDayNumber;

  /// Gets the weekday index for this date (0=Saturday, 1=Sunday, ..., 6=Friday)
  ///
  /// Returns the weekday from the Myanmar date system.
  int get weekday => myanmar.weekday;

  /// Gets the year from the Myanmar calendar
  int get myanmarYear => myanmar.year;

  /// Gets the month from the Myanmar calendar (1-14)
  int get myanmarMonth => myanmar.month;

  /// Gets the day from the Myanmar calendar (1-30)
  int get myanmarDay => myanmar.day;

  /// Gets the year from the Western calendar
  int get westernYear => western.year;

  /// Gets the month from the Western calendar (1-12)
  int get westernMonth => western.month;

  /// Gets the day from the Western calendar (1-31)
  int get westernDay => western.day;

  /// Gets the Sasana year
  int get sasanaYear => myanmar.sasanaYear;

  /// Gets the moon phase (0=waxing, 1=full moon, 2=waning, 3=new moon)
  int get moonPhase => myanmar.moonPhase;

  /// Check moon phase is full moon.
  bool get isFullMoon => moonPhase == 1;

  /// Check moon phase is new moon.
  bool get isNewMoon => moonPhase == 3;

  /// Gets the fortnight day (1-15)
  int get fortnightDay => myanmar.fortnightDay;

  /// Gets the year type (0=common, 1=little watat, 2=big watat)
  int get yearType => myanmar.yearType;

  /// Checks if this date has any holidays
  bool get hasHolidays => holidays.hasHolidays;

  /// Checks if this date has astrological significance
  bool get hasAstrologicalDays => astro.astrologicalDays.isNotEmpty;

  /// Checks if this date is a sabbath day
  bool get isSabbath => astro.sabbath == 'Sabbath';

  /// Get sabbath
  String get sabbath => astro.sabbath;

  /// Checks if this date is a sabbath eve
  bool get isSabbathEve => astro.sabbath == 'Sabbath Eve';

  /// Checks if this date is a Yatyaza day (inauspicious)
  bool get isYatyaza => astro.yatyaza == 'Yatyaza';

  /// Get yatyaza
  String get yatyaza => astro.yatyaza;

  /// Checks if this date has Pyathada (inauspicious time)
  bool get hasPyathada => astro.pyathada.isNotEmpty;

  /// Get pyathada
  String get pyathada => astro.pyathada;

  /// Checks if this date is in a watat (intercalary) year
  bool get isWatatYear => myanmar.yearType > 0;

  /// Checks if this date is in a big watat year
  bool get isBigWatatYear => myanmar.yearType == 2;

  /// Checks if this date is in a little watat year
  bool get isLittleWatatYear => myanmar.yearType == 1;

  /// Checks if it is today.
  bool get isToday {
    final now = DateTime.now();
    return now.year == now.year && now.month == now.month && now.day == now.day;
  }

  /// Gets all holidays as a combined list
  List<String> get allHolidays => holidays.allHolidays;

  /// Gets public holidays only
  List<String> get publicHolidays => holidays.publicHolidays;

  /// Gets religious holidays only
  List<String> get religiousHolidays => holidays.religiousHolidays;

  /// Gets cultural holidays only
  List<String> get culturalHolidays => holidays.culturalHolidays;

  /// Gets all astrological days
  List<String> get astrologicalDays => astro.astrologicalDays;

  /// Gets the Mahabote value for this date
  String get mahabote => astro.mahabote;

  /// Gets the Nakhat value for this date
  String get nakhat => astro.nakhat;

  /// Gets the year name from the 12-year cycle
  String get yearName => astro.yearName;

  /// Gets the Naga head direction
  String get nagahle => astro.nagahle;

  /// Compares this complete date with another for equality
  ///
  /// Two complete dates are considered equal if all their component dates
  /// and information objects are equal.
  @override
  bool operator ==(covariant CompleteDate other) {
    if (identical(this, other)) return true;

    return other.western == western &&
        other.myanmar == myanmar &&
        other.astro == astro &&
        other.holidays == holidays;
  }

  /// Generates a hash code for this complete date
  ///
  /// The hash code is based on all component objects to ensure proper
  /// behavior in collections and maps.
  @override
  int get hashCode {
    return western.hashCode ^
        myanmar.hashCode ^
        astro.hashCode ^
        holidays.hashCode;
  }

  /// Returns a string representation of this complete date
  ///
  /// The string includes key information from all calendar systems
  /// in a readable format.
  @override
  String toString() {
    return 'CompleteDate('
        'western: ${western.year}-${western.month.toString().padLeft(2, '0')}-${western.day.toString().padLeft(2, '0')}, '
        'myanmar: ${myanmar.year}/${myanmar.month}/${myanmar.day}, '
        'weekday: $weekday, '
        'moonPhase: $moonPhase, '
        'yearType: $yearType, '
        'holidays: ${holidays.allHolidays.length}, '
        'astrologicalDays: ${astro.astrologicalDays.length}'
        ')';
  }

  /// Returns a detailed string representation
  ///
  /// This method provides comprehensive information about the date
  /// including all holidays, astrological information, and calendar details.
  String toDetailedString() {
    final buffer = StringBuffer();

    buffer.writeln('Complete Date Information:');
    buffer.writeln(
      'Western: ${western.year}-${western.month.toString().padLeft(2, '0')}-${western.day.toString().padLeft(2, '0')} (${_getWeekdayName(weekday)})',
    );
    buffer.writeln(
      'Myanmar: ${myanmar.year}/${myanmar.month}/${myanmar.day} (${_getMoonPhaseName(moonPhase)} ${myanmar.fortnightDay})',
    );
    buffer.writeln('Sasana Year: ${myanmar.sasanaYear}');
    buffer.writeln('Year Type: ${_getYearTypeName(myanmar.yearType)}');
    buffer.writeln('Julian Day: ${myanmar.julianDayNumber}');

    if (holidays.hasHolidays) {
      buffer.writeln('Holidays:');
      if (holidays.publicHolidays.isNotEmpty) {
        buffer.writeln('  Public: ${holidays.publicHolidays.join(', ')}');
      }
      if (holidays.religiousHolidays.isNotEmpty) {
        buffer.writeln('  Religious: ${holidays.religiousHolidays.join(', ')}');
      }
      if (holidays.culturalHolidays.isNotEmpty) {
        buffer.writeln('  Cultural: ${holidays.culturalHolidays.join(', ')}');
      }
    }

    if (astro.astrologicalDays.isNotEmpty) {
      buffer.writeln('Astrological Days: ${astro.astrologicalDays.join(', ')}');
    }

    if (astro.sabbath.isNotEmpty) {
      buffer.writeln('Sabbath: ${astro.sabbath}');
    }

    if (astro.yatyaza.isNotEmpty) {
      buffer.writeln('Yatyaza: ${astro.yatyaza}');
    }

    if (astro.pyathada.isNotEmpty) {
      buffer.writeln('Pyathada: ${astro.pyathada}');
    }

    buffer.writeln('Mahabote: ${astro.mahabote}');
    buffer.writeln('Nakhat: ${astro.nakhat}');
    buffer.writeln('Year Name: ${astro.yearName}');
    buffer.writeln('Naga Head: ${astro.nagahle}');

    return buffer.toString().trim();
  }

  /// Returns a compact string representation for logging
  ///
  /// This provides essential information in a single line format
  /// suitable for logging and debugging purposes.
  String toCompactString() {
    return '${western.year}-${western.month.toString().padLeft(2, '0')}-${western.day.toString().padLeft(2, '0')} '
        '(MY:${myanmar.year}/${myanmar.month}/${myanmar.day}, '
        'JD:${myanmar.julianDayNumber.toInt()}, '
        'YT:${myanmar.yearType}, '
        'MP:${myanmar.moonPhase}, '
        'WD:$weekday, '
        'H:${holidays.allHolidays.length}, '
        'A:${astro.astrologicalDays.length})';
  }

  /// Converts this complete date to a Map for serialization
  ///
  /// This method creates a Map representation that can be easily
  /// serialized to JSON or other formats.
  Map<String, dynamic> toMap() {
    return {
      'western': {
        'year': western.year,
        'month': western.month,
        'day': western.day,
        'hour': western.hour,
        'minute': western.minute,
        'second': western.second,
        'millisecond': western.millisecond,
        'weekday': western.weekday,
        'julianDayNumber': western.julianDayNumber,
      },
      'myanmar': {
        'year': myanmar.year,
        'month': myanmar.month,
        'day': myanmar.day,
        'yearType': myanmar.yearType,
        'moonPhase': myanmar.moonPhase,
        'fortnightDay': myanmar.fortnightDay,
        'weekday': myanmar.weekday,
        'julianDayNumber': myanmar.julianDayNumber,
        'sasanaYear': myanmar.sasanaYear,
        'monthLength': myanmar.monthLength,
      },
      'astro': {
        'astrologicalDays': astro.astrologicalDays,
        'sabbath': astro.sabbath,
        'yatyaza': astro.yatyaza,
        'pyathada': astro.pyathada,
        'nagahle': astro.nagahle,
        'mahabote': astro.mahabote,
        'nakhat': astro.nakhat,
        'yearName': astro.yearName,
      },
      'holidays': {
        'publicHolidays': holidays.publicHolidays,
        'religiousHolidays': holidays.religiousHolidays,
        'culturalHolidays': holidays.culturalHolidays,
      },
    };
  }

  /// Creates a CompleteDate from a Map (deserialization)
  ///
  /// This factory constructor creates a CompleteDate instance from a Map,
  /// typically used when deserializing from JSON or other formats.
  factory CompleteDate.fromMap(Map<String, dynamic> map) {
    final westernMap = map['western'] as Map<String, dynamic>;
    final myanmarMap = map['myanmar'] as Map<String, dynamic>;
    final astroMap = map['astro'] as Map<String, dynamic>;
    final holidaysMap = map['holidays'] as Map<String, dynamic>;

    return CompleteDate(
      western: WesternDate(
        year: westernMap['year'] as int,
        month: westernMap['month'] as int,
        day: westernMap['day'] as int,
        hour: westernMap['hour'] as int? ?? 12,
        minute: westernMap['minute'] as int? ?? 0,
        second: westernMap['second'] as int? ?? 0,
        millisecond: westernMap['millisecond'] as int? ?? 0,
        weekday: westernMap['weekday'] as int,
        julianDayNumber: westernMap['julianDayNumber'] as double,
      ),
      myanmar: MyanmarDate(
        year: myanmarMap['year'] as int,
        month: myanmarMap['month'] as int,
        day: myanmarMap['day'] as int,
        yearType: myanmarMap['yearType'] as int,
        moonPhase: myanmarMap['moonPhase'] as int,
        fortnightDay: myanmarMap['fortnightDay'] as int,
        weekday: myanmarMap['weekday'] as int,
        julianDayNumber: myanmarMap['julianDayNumber'] as double,
        sasanaYear: myanmarMap['sasanaYear'] as int,
        monthLength: myanmarMap['monthLength'] as int,
        monthType: myanmarMap['monthType'] as int,
      ),
      astro: AstroInfo(
        astrologicalDays: List<String>.from(
          astroMap['astrologicalDays'] as List,
        ),
        sabbath: astroMap['sabbath'] as String,
        yatyaza: astroMap['yatyaza'] as String,
        pyathada: astroMap['pyathada'] as String,
        nagahle: astroMap['nagahle'] as String,
        mahabote: astroMap['mahabote'] as String,
        nakhat: astroMap['nakhat'] as String,
        yearName: astroMap['yearName'] as String,
      ),
      holidays: HolidayInfo(
        publicHolidays: List<String>.from(
          holidaysMap['publicHolidays'] as List,
        ),
        religiousHolidays: List<String>.from(
          holidaysMap['religiousHolidays'] as List,
        ),
        culturalHolidays: List<String>.from(
          holidaysMap['culturalHolidays'] as List,
        ),
      ),
    );
  }

  /// Helper method to get weekday name
  String _getWeekdayName(int weekdayIndex) {
    const weekdays = [
      'Saturday',
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
    ];

    return weekdays[weekdayIndex % 7];
  }

  /// Helper method to get moon phase name
  String _getMoonPhaseName(int moonPhase) {
    const phases = ['Waxing', 'Full Moon', 'Waning', 'New Moon'];
    return phases[moonPhase % 4];
  }

  /// Helper method to get year type name
  String _getYearTypeName(int yearType) {
    const types = ['Common Year', 'Little Watat', 'Big Watat'];
    return types[yearType % 3];
  }
}
