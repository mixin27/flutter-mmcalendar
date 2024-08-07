import 'language_catalog.dart';

/// Convert Number to String according to [LanguageCatalog]
///
/// `number` - Number to convert
/// `languageCatalog` - [LanguageCatalog] to translate
String convertNumberToLanguage(double number, LanguageCatalog languageCatalog) {
  const Map<String, String> myanmarNumbers = {
    '0': "၀",
    '1': "၁",
    '2': "၂",
    '3': "၃",
    '4': "၄",
    '5': "၅",
    '6': "၆",
    '7': "၇",
    '8': "၈",
    '9': "၉",
    '10': "၁၀",
    '11': "၁၁",
    '12': "၁၂",
    '13': "၁၃",
    '14': "၁၄",
    '15': "၁၅",
  };

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

  return myanmarNumbers[g + s] ?? g + s;
}
