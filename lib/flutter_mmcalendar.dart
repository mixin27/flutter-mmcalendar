/// Myanmar calendar library for flutter application with
/// many utility methods and calculations.
library flutter_mmcalendar;

import 'src/converters/myanmar_date_converter.dart';
import 'src/enums/language.dart';
import 'src/models/myanmar_date.dart';
import 'src/utils/language_catalog.dart';

export 'src/models/astro.dart';
export 'src/models/era.dart';
export 'src/models/myanmar_date.dart';
export 'src/models/myanmar_months.dart';
export 'src/models/thingyan.dart';
export 'src/models/western_date.dart';

export 'src/utils/binary_search_utils.dart';
export 'src/utils/language_catalog.dart';
export 'src/utils/number_to_string_utils.dart';

export 'src/constants/calendar_constants.dart';
export 'src/constants/format_constants.dart';

export 'src/enums/calendar_type.dart';
export 'src/enums/language.dart';

export 'src/converters/astro_converter.dart';
export 'src/converters/myanmar_date_converter.dart';
export 'src/converters/western_date_converter.dart';

export 'src/algorithms/astro_logic.dart';
export 'src/algorithms/myanmar_date_logic.dart';
export 'src/algorithms/western_date_logic.dart';

export 'src/calculator/holidays_calculator.dart';
export 'src/calculator/thingyan_calculator.dart';

export 'src/config/mm_calendar_config.dart';

class FlutterMmcalendar {
  /// Get [MyanmarDate] object by `year`, `month` and `day.
  ///
  /// `year` - Year
  ///
  /// `month` - Month
  ///
  /// `day` - Day
  static MyanmarDate getMyanmarDate({
    required int year,
    required int month,
    required int day,
  }) {
    return MyanmarDateConverter.fromDate(year, month, day);
  }

  /// Get formatted string by [Language].
  ///
  /// `dateTime` - [DateTime] to format.
  ///
  /// `language` - Language type `englisht` | `myanmar` | `mon` | `zawgyi`.
  static String getDateByLanguage(
    DateTime dateTime, {
    Language? language,
  }) {
    final mmDate = MyanmarDateConverter.fromDateTime(dateTime);
    return mmDate.formatByPatternAndLanguage(
      languageCatalog: LanguageCatalog(language: language),
    );
  }
}
