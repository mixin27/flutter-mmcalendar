import 'language_catalog.dart';

/// Convert Number to String according to [LanguageCatalog]
///
/// `number` - Number to convert
/// `languageCatalog` - [LanguageCatalog] to translate
String convertNumberToLanguage(double number, LanguageCatalog languageCatalog) {
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
    s = languageCatalog.translate(r.toString()) + s;
  } while (number > 0);

  return g + s;
}
