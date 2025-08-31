import 'package:flutter_mmcalendar/src/config/calendar_config.dart';
import 'package:flutter_mmcalendar/src/language/language_catalog.dart';
import 'package:flutter_mmcalendar/src/language/language_extension.dart';

/// Convert a number to a string according to the current global language setting.
///
/// `number` - Number to convert
/// Returns translated number as string.
String convertNumberToLanguage(double number) {
  final langCode = GlobalCalendarConfig().config.language.toLanguageCode();
  int r = 0;
  String s = "", g = "";

  if (number < 0) {
    g = "-";
    number = number.abs();
  }

  number = number.floorToDouble();

  do {
    r = (number % 10).toInt();
    number = (number / 10).floorToDouble();
    s = LanguageCatalog.tr(r.toString(), langCode: langCode) + s;
  } while (number > 0);

  return g + s;
}
