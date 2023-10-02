import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// Language catalog
class LanguageCatalog {
  static LanguageCatalog? _instance;
  static LanguageCatalog get instance => _instance ??= LanguageCatalog();

  late Language _language;
  Language get language => _language;

  LanguageCatalog({Language? language}) {
    _language = language ??= MmCalendarConfig.instance.language;
  }

  /// Translate by `key` and default [Language] type config.
  String translate(String key) {
    return _translate(_language, key);
  }

  /// Translate accorting to [Language] type.
  String _translate(Language language, String key) {
    return switch (language) {
      Language.myanmar => englishToMyanmarMap[key] ?? '',
      Language.english => englishToMyanglishMap[key] ?? '',
      Language.mon => englishToMonMap[key] ?? '',
      Language.zawgyi => englishToZawgyiMap[key] ?? '',
    };
  }
}

/// Map `english` to `myanmar`.
Map<String, String> englishToMyanmarMap = {
  "0": "\u1040",
  "1": "\u1041",
  "2": "\u1042",
  "3": "\u1043",
  "4": "\u1044",
  "5": "\u1045",
  "6": "\u1046",
  "7": "\u1047",
  "8": "\u1048",
  "9": "\u1049",
  "January": "\u1007\u1014\u103A\u1014\u101D\u102B\u101B\u102E",
  "February": "\u1016\u1031\u1016\u1031\u102C\u103A\u101D\u102B\u101B\u102E",
  "March": "\u1019\u1010\u103A",
  "April": "\u1027\u1015\u103C\u102E",
  "May": "\u1019\u1031",
  "June": "\u1007\u103D\u1014\u103A",
  "July": "\u1007\u1030\u101C\u102D\u102F\u1004\u103A",
  "August": "\u1029\u1002\u102F\u1010\u103A",
  "September": "\u1005\u1000\u103A\u1010\u1004\u103A\u1018\u102C",
  "October": "\u1021\u1031\u102C\u1000\u103A\u1010\u102D\u102F\u1018\u102C",
  "November": "\u1014\u102D\u102F\u101D\u1004\u103A\u1018\u102C",
  "December": "\u1012\u102E\u1007\u1004\u103A\u1018\u102C",
  "First Waso": "\u1015\u101D\u102B\u1006\u102D\u102F",
  "Second Waso": "\u1012\u102F\u101D\u102B\u1006\u102D\u102F",
  "Tagu": "\u1010\u1014\u103A\u1001\u1030\u1038",
  "Late Tagu":
      "\u1014\u103E\u1031\u102C\u1004\u103A\u1038\u1010\u1014\u103A\u1001\u1030\u1038",
  "Kason": "\u1000\u1006\u102F\u1014\u103A",
  "Late Kason":
      "\u1014\u103E\u1031\u102C\u1004\u103A\u1038\u1000\u1006\u102F\u1014\u103A",
  "Nayon": "\u1014\u101A\u102F\u1014\u103A",
  "Waso": "\u101D\u102B\u1006\u102D\u102F",
  "Wagaung": "\u101D\u102B\u1001\u1031\u102B\u1004\u103A",
  "Tawthalin": "\u1010\u1031\u102C\u103A\u101E\u101C\u1004\u103A\u1038",
  "Thadingyut":
      "\u101E\u102E\u1010\u1004\u103A\u1038\u1000\u103B\u103D\u1010\u103A",
  "Tazaungmon":
      "\u1010\u1014\u103A\u1006\u1031\u102C\u1004\u103A\u1019\u102F\u1014\u103A\u1038",
  "Nadaw": "\u1014\u1010\u103A\u1010\u1031\u102C\u103A",
  "Pyatho": "\u1015\u103C\u102C\u101E\u102D\u102F",
  "Tabodwe": "\u1010\u1015\u102D\u102F\u1037\u1010\u103D\u1032",
  "Tabaung": "\u1010\u1015\u1031\u102B\u1004\u103A\u1038",
  "waxing": "\u101C\u1006\u1014\u103A\u1038",
  "waning": "\u101C\u1006\u102F\u1010\u103A",
  "full moon": "\u101C\u1015\u103C\u100A\u103A\u1037",
  "new moon": "\u101C\u1000\u103D\u101A\u103A",
  "Myanmar Year":
      "\u1019\u103C\u1014\u103A\u1019\u102C\u1014\u103E\u1005\u103A",
  "Ku": "\u1001\u102F",
  "Late": "\u1014\u103E\u1031\u102C\u1004\u103A\u1038",
  "Second": "\u1012\u102F",
  "Sunday": "\u1010\u1014\u1004\u103A\u1039\u1002\u1014\u103D\u1031",
  "Monday": "\u1010\u1014\u1004\u103A\u1039\u101C\u102C",
  "Tuesday": "\u1021\u1004\u103A\u1039\u1002\u102B",
  "Wednesday": "\u1017\u102F\u1012\u1039\u1013\u101F\u1030\u1038",
  "Thursday": "\u1000\u103C\u102C\u101E\u1015\u1010\u1031\u1038",
  "Friday": "\u101E\u1031\u102C\u1000\u103C\u102C",
  "Saturday": "\u1005\u1014\u1031",
  "Nay": "\u1014\u1031\u1037",
  "Yat": "\u101B\u1000\u103A",
  "Sabbath Eve": "\u1021\u1016\u102D\u1010\u103A",
  "Sabbath": "\u1025\u1015\u102F\u101E\u103A",
  "Yatyaza": "\u101B\u1000\u103A\u101B\u102C\u1007\u102C",
  "Afternoon Pyathada":
      "\u1019\u103D\u1014\u103A\u1038\u101C\u103D\u1032\u1015\u103C\u103F\u1012\u102B\u1038",
  "Pyathada": "\u1015\u103C\u103F\u1012\u102B\u1038",
  "New Year Day": "New Year's Day",
  "Independence Day":
      "\u101C\u103D\u1010\u103A\u101C\u1015\u103A\u101B\u1031\u1038\u1014\u1031\u1037",
  "Union Day":
      "\u1015\u103C\u100A\u103A\u1011\u1031\u102C\u1004\u103A\u1005\u102F\u1014\u1031\u1037",
  "Peasants Day":
      "\u1010\u1031\u102C\u1004\u103A\u101E\u1030 \u101C\u101A\u103A\u101E\u1019\u102C\u1038\u1014\u1031\u1037",
  "Resistance Day":
      "\u1010\u1031\u102C\u103A\u101C\u103E\u1014\u103A\u101B\u1031\u1038\u1014\u1031\u1037",
  "Labour Day":
      "\u1021\u101C\u102F\u1015\u103A\u101E\u1019\u102C\u1038\u1014\u1031\u1037",
  "Martyrs Day": "\u1021\u102C\u1007\u102C\u1014\u100A\u103A\u1014\u1031\u1037",
  "Christmas Day":
      "\u1001\u101B\u1005\u1039\u1005\u1019\u1010\u103A\u1014\u1031\u1037",
  "Buddha Day":
      "\u100A\u1031\u102C\u1004\u103A\u101B\u1031\u101E\u103D\u1014\u103A\u1038\u1015\u103D\u1032",
  "Start of Buddhist Lent":
      "\u1013\u1019\u1039\u1019\u1005\u1000\u103C\u102C\u1014\u1031\u1037",
  "End of Buddhist Lent":
      "\u1019\u102E\u1038\u1011\u103D\u1014\u103A\u1038\u1015\u103D\u1032",
  "Tazaungdaing":
      "\u1010\u1014\u103A\u1006\u1031\u102C\u1004\u103A\u1010\u102D\u102F\u1004\u103A",
  "National Day":
      "\u1021\u1019\u103B\u102D\u102F\u1038\u101E\u102C\u1038\u1014\u1031\u1037",
  "Karen New Year Day":
      "\u1000\u101B\u1004\u103A\u1014\u103E\u1005\u103A\u101E\u1005\u103A\u1000\u1030\u1038",
  "Tabaung Pwe": "\u1010\u1015\u1031\u102B\u1004\u103A\u1038\u1015\u103D\u1032",
  "Thingyan Akyo":
      "\u101E\u1004\u103A\u1039\u1000\u103C\u1014\u103A\u1021\u1000\u103C\u102D\u102F",
  "Thingyan Akya":
      "\u101E\u1004\u103A\u1039\u1000\u103C\u1014\u103A\u1021\u1000\u103B",
  "Thingyan Akyat":
      "\u101E\u1004\u103A\u1039\u1000\u103C\u1014\u103A\u1021\u1000\u103C\u1010\u103A",
  "Thingyan Atat":
      "\u101E\u1004\u103A\u1039\u1000\u103C\u1014\u103A\u1021\u1010\u1000\u103A",
  "Myanmar New Year Day":
      "\u1014\u103E\u1005\u103A\u1006\u1014\u103A\u1038\u1010\u1005\u103A\u101B\u1000\u103A",
  "Amyeittasote":
      "\u1021\u1019\u103C\u102D\u1010\u1039\u1010\u1005\u102F\u1010\u103A",
  "Warameittugyi":
      "\u101D\u102B\u101B\u1019\u102D\u1010\u1039\u1010\u102F\u1000\u103C\u102E\u1038",
  "Warameittunge":
      "\u101D\u102B\u101B\u1019\u102D\u1010\u1039\u1010\u102F\u1004\u101A\u103A",
  "Thamaphyu": "\u101E\u1019\u102C\u1038\u1016\u103C\u1030",
  "Thamanyo": "\u101E\u1019\u102C\u1038\u100A\u102D\u102F",
  "Yatpote": "\u101B\u1000\u103A\u1015\u102F\u1015\u103A",
  "Yatyotema": "\u101B\u1000\u103A\u101A\u102F\u1010\u103A\u1019\u102C",
  "Mahayatkyan":
      "\u1019\u101F\u102C\u101B\u1000\u103A\u1000\u103C\u1019\u103A\u1038",
  "Nagapor": "\u1014\u1002\u102B\u1038\u1015\u1031\u102B\u103A",
  "Shanyat": "\u101B\u103E\u1019\u103A\u1038\u101B\u1000\u103A",
  ":": "\u104A",
  ".": "\u104B",
  "Mon National Day":
      "\u1019\u103D\u1014\u103A\u1021\u1019\u103B\u102D\u102F\u1038\u101E\u102C\u1038\u1014\u1031\u1037",
  "G. Aung San BD":
      "\u1017\u102D\u102F\u101C\u103A\u1001\u103B\u102F\u1015\u103A\u1019\u103D\u1031\u1038\u1014\u1031\u1037",
  "Valentines Day":
      "\u1001\u103B\u1005\u103A\u101E\u1030\u1019\u103B\u102C\u1038\u1014\u1031\u1037",
  "Earth Day":
      "\u1000\u1019\u1039\u1018\u102C\u1019\u103C\u1031\u1014\u1031\u1037",
  "April Fools Day":
      "\u1027\u1015\u103C\u102E\u1021\u101B\u1030\u1038\u1014\u1031\u1037",
  "Red Cross Day":
      "\u1000\u103C\u1000\u103A\u1001\u103C\u1031\u1014\u102E\u1014\u1031\u1037",
  "United Nations Day":
      "\u1000\u102F\u101C\u101E\u1019\u1039\u1019\u1002\u1039\u1002\u1014\u1031\u1037",
  "Halloween": "\u101E\u101B\u1032\u1014\u1031\u1037",
  "Shan New Year Day":
      "\u101B\u103E\u1019\u103A\u1038\u1014\u103E\u1005\u103A\u101E\u1005\u103A\u1000\u1030\u1038",
  "Mothers Day": "\u1021\u1019\u1031\u1014\u1031\u1037",
  "Fathers Day": "\u1021\u1016\u1031\u1014\u1031\u1037",
  "Sasana Year": "\u101E\u102C\u101E\u1014\u102C\u1014\u103E\u1005\u103A",
  "Eid": "\u1021\u102D\u1012\u103A",
  "Diwali": "\u1012\u102E\u101D\u102B\u101C\u102E",
  "Mahathamaya Day": "\u1019\u101F\u102C\u101E\u1019\u101A\u1014\u1031\u1037",
  "Garudhamma Day":
      "\u1002\u101B\u102F\u1013\u1019\u1039\u1019\u1014\u1031\u1037",
  "Metta Day": "\u1019\u1031\u1010\u1039\u1010\u102C\u1014\u1031\u1037",
  "Taungpyone Pwe":
      "\u1010\u1031\u102C\u1004\u103A\u1015\u103C\u102F\u1014\u103A\u1038\u1015\u103D\u1032",
  "Yadanagu Pwe":
      "\u101B\u1010\u1014\u102C\u1037\u1002\u1030\u1015\u103D\u1032",
  "Authors Day":
      "\u1005\u102C\u1006\u102D\u102F\u1010\u1031\u102C\u103A\u1014\u1031\u1037",
  "World Teachers Day":
      "\u1000\u1019\u1039\u1018\u102C\u1037\u1006\u101B\u102C\u1019\u103B\u102C\u1038\u1014\u1031\u1037",
  "Holiday":
      "\u101B\u102F\u1036\u1038\u1015\u102D\u1010\u103A\u101B\u1000\u103A",
  "Chinese New Year":
      "\u1010\u101B\u102F\u1010\u103A\u1014\u103E\u1005\u103A\u101E\u1005\u103A\u1000\u1030\u1038",
  "Easter":
      "\u1011\u1019\u103C\u1031\u102C\u1000\u103A\u101B\u102C\u1014\u1031\u1037",
  "Good Friday":
      "\u101E\u1031\u102C\u1000\u103C\u102C\u1014\u1031\u1037\u1000\u103C\u102E\u1038",
  "West": "\u1021\u1014\u1031\u102C\u1000\u103A",
  "North": "\u1019\u103C\u1031\u102C\u1000\u103A",
  "East": "\u1021\u101B\u103E\u1031\u1037",
  "South": "\u1010\u1031\u102C\u1004\u103A",
  "Binga": "\u1018\u1004\u103A\u1039\u1002",
  "Atun": "\u1021\u1011\u103D\u1014\u103A\u1038",
  "Yaza": "\u101B\u102C\u1007",
  "Adipati": "\u1021\u1013\u102D\u1015\u1010\u102D",
  "Marana": "\u1019\u101B\u100F",
  "Thike": "\u101E\u102D\u102F\u1000\u103A",
  "Puti": "\u1015\u102F\u1010\u102D",
  "Orc": "\u1018\u102E\u101C\u1030\u1038",
  "Elf": "\u1014\u1010\u103A",
  "Human": "\u101C\u1030",
};

Map<String, String> englishToMyanglishMap = {
  "0": "0",
  "1": "1",
  "2": "2",
  "3": "3",
  "4": "4",
  "5": "5",
  "6": "6",
  "7": "7",
  "8": "8",
  "9": "9",
  "January": "January",
  "February": "February",
  "March": "March",
  "April": "April",
  "May": "May",
  "June": "June",
  "July": "July",
  "August": "August",
  "September": "September",
  "October": "October",
  "November": "November",
  "December": "December",
  "First Waso": "First Waso",
  "Second Waso": "\u1012\u102F\u101D\u102B\u1006\u102D\u102F",
  "Tagu": "Tagu",
  "Late Tagu": "Late Tagu",
  "Kason": "Kason",
  "Late Kason": "Late Kason",
  "Nayon": "Nayon",
  "Waso": "Waso",
  "Wagaung": "Wagaung",
  "Tawthalin": "Tawthalin",
  "Thadingyut": "Thadingyut",
  "Tazaungmon": "Tazaungmon",
  "Nadaw": "Nadaw",
  "Pyatho": "Pyatho",
  "Tabodwe": "Tabodwe",
  "Tabaung": "Tabaung",
  "waxing": "waxing",
  "waning": "waning",
  "full moon": "full moon",
  "new moon": "new moon",
  "Myanmar Year": "Myanmar Year",
  "Ku": "",
  "Late": "Late ",
  "Second": "Second ",
  "Sunday": "Sunday",
  "Monday": "Monday",
  "Tuesday": "Tuesday",
  "Wednesday": "Wednesday",
  "Thursday": "Thursday",
  "Friday": "Friday",
  "Saturday": "Saturday",
  "Nay": "",
  "Yat": "",
  "Sabbath Eve": "Sb Eve",
  "Sabbath": "Sabbath",
  "Yatyaza": "Yatyaza",
  "Afternoon Pyathada": "Afternoon Pyathada",
  "Pyathada": "Pyathada",
  "New Year Day": "New Year's Day",
  "Independence Day": "Independence Day",
  "Union Day": "Union Day",
  "Peasants Day": "Peasants Day",
  "Resistance Day": "Resistance Day",
  "Labour Day": "Labour Day",
  "Martyrs Day": "Martyrs' Day",
  "Christmas Day": "Christmas Day",
  "Buddha Day": "Buddha Day",
  "Start of Buddhist Lent": "Start of Buddhist Lent",
  "End of Buddhist Lent": "End of Buddhist Lent",
  "Tazaungdaing": "Tazaungdaing",
  "National Day": "National Day",
  "Karen New Year Day": "Karen New Year Day",
  "Tabaung Pwe": "Tabaung Pwe",
  "Thingyan Akyo": "Thingyan Akyo",
  "Thingyan Akya": "Thingyan Akya",
  "Thingyan Akyat": "Thingyan Akyat",
  "Thingyan Atat": "Thingyan Atat",
  "Myanmar New Year Day": "Myanmar New Year Day",
  "Amyeittasote": "Amyeittasote",
  "Warameittugyi": "Warameittugyi",
  "Warameittunge": "Warameittunge",
  "Thamaphyu": "Thamaphyu",
  "Thamanyo": "Thamanyo",
  "Yatpote": "Yatpote",
  "Yatyotema": "Yatyotema",
  "Mahayatkyan": "Mahayatkyan",
  "Nagapor": "Nagapor",
  "Shanyat": "Shanyat",
  ":": ":",
  ".": ".",
  "Mon National Day": "Mon National Day",
  "G. Aung San BD": "G. Aung San BD",
  "Valentines Day": "Valentines Day",
  "Earth Day": "Earth Day",
  "April Fools Day": "April Fools' Day",
  "Red Cross Day": "Red Cross Day",
  "United Nations Day": "United Nations Day",
  "Halloween": "Halloween",
  "Shan New Year Day": "Shan New Year Day",
  "Mothers Day": "Mothers' Day",
  "Fathers Day": "Fathers' Day",
  "Sasana Year": "Sasana Year",
  "Eid": "Eid",
  "Diwali": "Diwali",
  "Mahathamaya Day": "Great Integration",
  "Garudhamma Day": "Garudhamma Day",
  "Metta Day": "Metta Day",
  "Taungpyone Pwe": "Taungpyone Pwe",
  "Yadanagu Pwe": "Yadanagu Pwe",
  "Authors Day": "Authors' Day",
  "World Teachers Day": "World Teachers' Day",
  "Holiday": "Holiday",
  "Chinese New Year": "Chinese New Year",
  "Easter": "Easter",
  "Good Friday": "Good Friday",
  "West": "West",
  "North": "North",
  "East": "East",
  "South": "South",
  "Binga": "Binga",
  "Atun": "Atun",
  "Yaza": "Yaza",
  "Adipati": "Adipati",
  "Marana": "Marana",
  "Thike": "Thike",
  "Puti": "Puti",
  "Orc": "Orc",
  "Elf": "Elf",
  "Human": "Human",
};

/// Map `english` to `mon`.
Map<String, String> englishToMonMap = {
  "0": "\u1040",
  "1": "\u1041",
  "2": "\u1042",
  "3": "\u1043",
  "4": "\u1044",
  "5": "\u1045",
  "6": "\u1046",
  "7": "\u1047",
  "8": "\u1048",
  "9": "\u1049",
  "January":
      "\u1002\u103B\u102C\u1014\u103A\u1014\u103B\u1030\u1021\u102C\u101B\u1033",
  "February":
      "\u101D\u103E\u1031\u101D\u103A\u1017\u103B\u1030\u1021\u102C\u101B\u1033",
  "March": "\u1019\u102C\u1010\u103A\u1001\u103B\u103A",
  "April": "\u1028\u1015\u103C\u1031\u101A\u103A\u101C\u103A",
  "May": "\u1019\u1031",
  "June": "\u1002\u103B\u102F\u1014\u103A",
  "July": "\u1002\u103B\u1030\u101C\u102C\u105A\u103A",
  "August": "\u1021\u101D\u103A\u1002\u102B\u1010\u103A",
  "September": "\u101E\u102D\u1010\u103A\u1011\u102E\u1017\u102C",
  "October": "\u1021\u1036\u1000\u103A\u1011\u101D\u103A\u1017\u102C",
  "November": "\u1014\u101D\u103A\u101D\u102B\u1019\u103A\u1017\u102C",
  "December": "\u1012\u102E\u1007\u103C\u1031\u1014\u103A\u1017\u102C",
  "First Waso":
      "\u1002\u102D\u1010\u102F\u1015-\u1012\u1039\u1002\u102D\u102F\u1014\u103A",
  "Second Waso":
      "\u1012\u102F\u101D\u102B\u1006\u102D\u102F", //need to translate
  "Tagu": "\u1002\u102D\u1010\u102F\u1005\u1032",
  "Late Tagu":
      "\u1014\u103E\u1031\u102C\u1004\u103A\u1038\u1010\u1014\u103A\u1001\u1030\u1038", //need to translate
  "Kason": "\u1002\u102D\u1010\u102F\u1015\u101E\u102C\u103A",
  "Late Kason":
      "\u1014\u103E\u1031\u102C\u1004\u103A\u1038\u1000\u1006\u102F\u1014\u103A", //need to translate
  "Nayon": "\u1002\u102D\u1010\u102F\u1007\u103E\u1031\u103A",
  "Waso": "\u1002\u102D\u1010\u102F\u1012\u1039\u1002\u102D\u102F\u1014\u103A",
  "Wagaung": "\u1002\u102D\u1010\u102F\u1001\u1039\u100D\u1032\u101E\u1033",
  "Tawthalin": "\u1002\u102D\u1010\u102F\u1018\u1010\u103A",
  "Thadingyut": "\u1002\u102D\u1010\u102F\u101D\u103E\u103A",
  "Tazaungmon":
      "\u1002\u102D\u1010\u102F\u1000\u1039\u1011\u102D\u102F\u1014\u103A",
  "Nadaw":
      "\u1002\u102D\u1010\u102F\u1019\u103C\u1031\u1000\u1039\u1000\u101E\u1035\u102F",
  "Pyatho": "\u1002\u102D\u1010\u102F\u1015\u103E\u1031\u102C\u103A",
  "Tabodwe": "\u1002\u102D\u1010\u102F\u1019\u102C\u103A",
  "Tabaung":
      "\u1002\u102D\u1010\u102F\u1016\u101D\u103A\u101B\u1002\u102D\u102F\u1014\u103A",
  "waxing": "\u1019\u1036\u1000\u103A",
  "waning": "\u1005\u103D\u1031\u1000\u103A",
  "full moon": "\u1015\u1031\u105A\u103A",
  "new moon": "\u1021\u102D\u102F\u1010\u103A",
  "Myanmar Year":
      "\u101E\u1000\u1039\u1000\u101B\u102C\u1007\u103A\u100D\u102F\u105A\u103A",
  "Ku": "\u101E\u105E\u102C\u1036",
  "Late": "",
  "Second": "\u1012\u102F",
  "Sunday": "\u1010\u1039\u105A\u1032\u1021\u1012\u102D\u102F\u1010\u103A",
  "Monday": "\u1010\u1039\u105A\u1032\u1005\u1014\u103A",
  "Tuesday": "\u1010\u1039\u105A\u1032\u1021\u1004\u1039\u105A\u102C",
  "Wednesday":
      "\u1010\u1039\u105A\u1032\u1017\u102F\u1012\u1039\u1013\u101D\u102B",
  "Thursday": "\u1010\u1039\u105A\u1032\u1017\u103C\u1034\u1017\u1010\u102D",
  "Friday": "\u1010\u1039\u105A\u1032\u101E\u102D\u102F\u1000\u103A",
  "Saturday":
      "\u1010\u1039\u105A\u1032\u101E\u1039\u105A\u102D\u101E\u101D\u103A",
  "Nay": "",
  "Yat": "",
  "Sabbath Eve": "\u1010\u1039\u105A\u1032\u1010\u102D\u105A\u103A",
  "Sabbath": "\u1010\u1039\u105A\u1032\u101E\u1033",
  "Yatyaza": "\u1010\u1039\u101B\u1032\u101B\u102C\u1007\u102C",
  "Afternoon Pyathada": "\u1010\u1039\u105A\u1032\u101B\u102C\u101F\u102F",
  "Pyathada":
      "\u1010\u1039\u105A\u1032\u1015\u103C\u102C\u1017\u1039\u1017\u1012\u102B",
  "New Year Day": "New Year's Day",
  "Independence Day":
      "\u1010\u1039\u105A\u1032\u101E\u1060\u1038\u1015\u103D\u1038",
  "Union Day":
      "\u1010\u1039\u105A\u1032\u1000\u105F\u102D\u1014\u103A\u100D\u102F\u105A\u103A",
  "Peasants Day":
      "\u1010\u1039\u105A\u1032\u101E\u105F\u102C\u1017\u1039\u105A",
  "Resistance Day":
      "\u1010\u1039\u105A\u1032\u1015\u1060\u1014\u103A\u1002\u1010\u1038\u1017\u105F\u102C",
  "Labour Day":
      "\u1010\u1039\u105A\u1032\u101E\u105F\u102C\u1000\u1019\u1060\u1031\u102C\u1014\u103A",
  "Martyrs Day": "\u1010\u1039\u105A\u1032\u1021\u102C\u1007\u102C\u1014\u1032",
  "Christmas Day":
      "\u1010\u1039\u105A\u1032\u1001\u101B\u1031\u103F\u1019\u102C\u1010\u103A",
  "Buddha Day":
      "\u1010\u1039\u105A\u1032\u101E\u1039\u1018\u105A\u103A\u1016\u100D\u102C\u103A\u1007\u103C\u1032",
  "Start of Buddhist Lent":
      "\u1010\u1039\u105A\u1032\u1010\u103D\u1036\u1013\u101D\u103A\u1013\u1019\u1039\u1019\u1005\u1000\u103A",
  "End of Buddhist Lent":
      "\u1010\u1039\u105A\u1032\u1021\u1018\u102D\u1013\u101B\u103A",
  "Tazaungdaing":
      "\u101E\u1039\u1018\u105A\u103A\u1015\u1030\u1007\u1034\u1015\u105F\u1010\u103A\u1015\u105E\u102C\u105A\u103A",
  "National Day":
      "\u1010\u1039\u105A\u1032\u1000\u1031\u102C\u1014\u103A\u1002\u1000\u1030\u1017\u105F\u102C",
  "Karen New Year Day":
      "\u1000\u101B\u1031\u105A\u103A\u101C\u103E\u102C\u1032\u101E\u105E\u102C\u1036",
  "Tabaung Pwe":
      "\u101E\u1039\u1018\u105A\u103A\u1016\u101D\u103A\u101B\u1002\u102D\u102F\u1014\u103A",
  "Thingyan Akyo":
      "\u1010\u1039\u105A\u1032\u1012\u1005\u1038\u1021\u1010\u1038",
  "Thingyan Akya":
      "\u1010\u1039\u105A\u1032\u1021\u1010\u1038\u1005\u103E\u1031\u103A",
  "Thingyan Akyat":
      "\u1010\u1039\u105A\u1032\u1021\u1010\u1038\u1000\u103C\u102C\u1015\u103A",
  "Thingyan Atat":
      "\u1010\u1039\u105A\u1032\u1021\u1010\u1038\u1010\u102D\u102F\u1014\u103A",
  "Myanmar New Year Day":
      "\u1010\u1039\u105A\u1032\u101E\u105E\u102C\u1036\u1010\u105F\u102D",
  "Amyeittasote":
      "\u1000\u102D\u102F\u1014\u103A\u1021\u1019\u103C\u102D\u102F\u1010\u103A",
  "Warameittugyi":
      "\u1000\u102D\u102F\u1014\u103A\u101D\u102B\u101B\u1019\u102D\u1010\u1039\u1010\u102F\u1007\u105E\u1031\u102C\u103A",
  "Warameittunge":
      "\u1000\u102D\u102F\u1014\u103A\u101D\u102B\u101B\u1019\u102D\u1010\u1039\u1010\u102F\u100D\u1031\u102C\u1010\u103A",
  "Thamaphyu":
      "\u1000\u102D\u102F\u1014\u103A\u101C\u1031\u105A\u103A\u1012\u102D\u102F\u1000\u103A",
  "Thamanyo":
      "\u1000\u102D\u102F\u1014\u103A\u101F\u102F\u1036\u1017\u103C\u1019\u103A",
  "Yatpote":
      "\u1000\u102D\u102F\u1014\u103A\u101C\u102E\u102F\u101C\u102C\u103A",
  "Yatyotema":
      "\u1000\u102D\u102F\u1014\u103A\u101A\u102F\u1010\u103A\u1019\u102C",
  "Mahayatkyan":
      "\u1000\u102D\u102F\u1014\u103A\u101F\u103D\u1036\u1001\u102D\u102F\u101F\u103A",
  "Nagapor": "\u1014\u102C\u103A\u1019\u1036\u1000\u103A",
  "Shanyat": "\u1010\u1039\u105A\u1032\u1012\u1010\u1014\u103A",
  ":": "\u104A",
  ".": "\u104B",
  "Mon National Day":
      "\u1010\u1039\u105A\u1032\u1000\u1031\u102C\u1014\u103A\u1002\u1000\u1030\u1019\u1014\u103A",
  "Mon Fallen Day":
      "\u1010\u1039\u105A\u1032\u101F\u1036\u101E\u102C\u101D\u1010\u1033\u101C\u102E\u102F",
  "Mon Revolution Day":
      "\u1010\u1039\u105A\u1032\u1015\u1060\u1014\u103A\u1002\u1010\u1038\u1019\u1014\u103A",
  "Mon Women Day":
      "\u1010\u1039\u105A\u1032\u100A\u1038\u1017\u103C\u1034\u1019\u1014\u103A",
  "G. Aung San BD":
      "\u1010\u1039\u105A\u1032\u101E\u105F\u102D\u105A\u103A\u1017\u105F\u102C \u1021\u1036\u105A\u103A\u101E\u102C\u1014\u103A\u1012\u103E\u103A\u1019\u105E\u102D\u101F\u103A",
  "Valentines Day":
      "\u1010\u1039\u105A\u1032\u101D\u102F\u1010\u103A\u1017\u1060\u102C\u1032",
  "Earth Day": "\u1010\u1039\u105A\u1032\u1002\u1060\u1038\u1000\u101D\u103A",
  "April Fools Day":
      "\u1010\u1039\u105A\u1032\u101E\u1039\u1015\u1015\u101B\u1021\u103A",
  "Red Cross Day":
      "\u1010\u1039\u105A\u1032\u1007\u102D\u102F\u105A\u103A\u1001\u1039\u100D\u102C\u103A\u100D\u102C\u1032",
  "United Nations Day":
      "\u1010\u1039\u105A\u1032\u1000\u102F\u101C\u101E\u1019\u1039\u1019\u1002\u1039\u1002",
  "Halloween":
      "\u1010\u1039\u105A\u1032\u101F\u1031\u101D\u103A\u101C\u101D\u103A\u101D\u102D\u1014\u103A",
  "Shan New Year Day":
      "\u1010\u1039\u105A\u1032\u101E\u1031\u1036\u101C\u103E\u102C\u1032\u101E\u105E\u102C\u1036",
  "Mothers Day": "\u1010\u1039\u105A\u1032\u1019\u102D\u1021\u1036\u1000\u103A",
  "Fathers Day": "\u1010\u1039\u105A\u1032\u1019\u1021\u1036\u1000\u103A",
  "Sasana Year":
      "\u101E\u1000\u1039\u1000\u101B\u102C\u1007\u103A \u101E\u102C\u101E\u1014\u102C",
  "Eid": "\u1021\u102D\u1012\u103A",
  "Diwali": "\u1012\u102E\u101D\u102B\u101C\u102E",
  "Mahathamaya Day": "\u1019\u101F\u102C\u101E\u1019\u101A\u1014\u1031\u1037",
  "Garudhamma Day":
      "\u1002\u101B\u102F\u1013\u1019\u1039\u1019\u1014\u1031\u1037",
  "Metta Day": "\u1019\u1031\u1010\u1039\u1010\u102C\u1014\u1031\u1037",
  "Taungpyone Pwe":
      "\u1010\u1031\u102C\u1004\u103A\u1015\u103C\u102F\u1014\u103A\u1038\u1015\u103D\u1032",
  "Yadanagu Pwe":
      "\u101B\u1010\u1014\u102C\u1037\u1002\u1030\u1015\u103D\u1032",
  "Authors Day":
      "\u1005\u102C\u1006\u102D\u102F\u1010\u1031\u102C\u103A\u1014\u1031\u1037",
  "World Teachers Day":
      "\u1000\u1019\u1039\u1018\u102C\u1037\u1006\u101B\u102C\u1019\u103B\u102C\u1038\u1014\u1031\u1037",
  "Holiday":
      "\u101B\u102F\u1036\u1038\u1015\u102D\u1010\u103A\u101B\u1000\u103A",
  "Chinese New Year":
      "\u1010\u101B\u102F\u1010\u103A\u1014\u103E\u1005\u103A\u101E\u1005\u103A\u1000\u1030\u1038",
  "Easter":
      "\u1011\u1019\u103C\u1031\u102C\u1000\u103A\u101B\u102C\u1014\u1031\u1037",
  "Good Friday":
      "\u101E\u1031\u102C\u1000\u103C\u102C\u1014\u1031\u1037\u1000\u103C\u102E\u1038",

  //TODO(me): Need Translate to Mon
  "West": "\u1021\u1014\u1031\u102C\u1000\u103A",
  "North": "\u1019\u103C\u1031\u102C\u1000\u103A",
  "East": "\u1021\u101B\u103E\u1031\u1037",
  "South": "\u1010\u1031\u102C\u1004\u103A",
  "Binga": "\u1018\u1004\u103A\u1039\u1002",
  "Atun": "\u1021\u1011\u103D\u1014\u103A\u1038",
  "Yaza": "\u101B\u102C\u1007",
  "Adipati": "\u1021\u1013\u102D\u1015\u1010\u102D",
  "Marana": "\u1019\u101B\u100F",
  "Thike": "\u101E\u102D\u102F\u1000\u103A",
  "Puti": "\u1015\u102F\u1010\u102D",
  "Orc": "\u1018\u102E\u101C\u1030\u1038",
  "Elf": "\u1014\u1010\u103A",
  "Human": "\u101C\u1030",
};

/// Map `english` to `zawgyi`.
Map<String, String> englishToZawgyiMap = {
  "0": "\u1040",
  "1": "\u1041",
  "2": "\u1042",
  "3": "\u1043",
  "4": "\u1044",
  "5": "\u1045",
  "6": "\u1046",
  "7": "\u1047",
  "8": "\u1048",
  "9": "\u1049",
  "January": "\u1007\u1014\u1039\u1014\u101D\u102B\u101B\u102E",
  "February": "\u1031\u1016\u1031\u1016\u102C\u1039\u101D\u102B\u101B\u102E",
  "March": "\u1019\u1010\u1039",
  "April": "\u1027\u107F\u1015\u102E",
  "May": "\u1031\u1019",
  "June": "\u1007\u103C\u1014\u1039",
  "July": "\u1007\u1030\u101C\u102D\u102F\u1004\u1039",
  "August": "\u1029\u1002\u102F\u1010\u1039",
  "September": "\u1005\u1000\u1039\u1010\u1004\u1039\u1018\u102C",
  "October": "\u1031\u1021\u102C\u1000\u1039\u1010\u102D\u102F\u1018\u102C",
  "November": "\u1014\u102D\u102F\u101D\u1004\u1039\u1018\u102C",
  "December": "\u1012\u102E\u1007\u1004\u1039\u1018\u102C",
  "First Waso": "\u1015\u101D\u102B\u1006\u102D\u102F",
  "Second Waso": "\u1012\u102F\u101D\u102B\u1006\u102D\u102F",
  "Tagu": "\u1010\u1014\u1039\u1001\u1030\u1038",
  "Late Tagu":
      "\u1031\u108F\u103D\u102C\u1004\u1039\u1038\u1010\u1014\u1039\u1001\u1030\u1038",
  "Kason": "\u1000\u1006\u102F\u1014\u1039",
  "Late Kason":
      "\u1031\u108F\u103D\u102C\u1004\u1039\u1038\u1000\u1006\u102F\u1014\u1039",
  "Nayon": "\u1014\u101A\u102F\u1014\u1039",
  "Waso": "\u101D\u102B\u1006\u102D\u102F",
  "Wagaung": "\u101D\u102B\u1031\u1001\u102B\u1004\u1039",
  "Tawthalin": "\u1031\u1010\u102C\u1039\u101E\u101C\u1004\u1039\u1038",
  "Thadingyut":
      "\u101E\u102E\u1010\u1004\u1039\u1038\u1000\u103C\u103A\u1010\u1039",
  "Tazaungmon":
      "\u1010\u1014\u1039\u1031\u1006\u102C\u1004\u1039\u1019\u102F\u1014\u1039\u1038",
  "Nadaw": "\u1014\u1010\u1039\u1031\u1010\u102C\u1039",
  "Pyatho": "\u103B\u1015\u102C\u101E\u102D\u102F",
  "Tabodwe": "\u1010\u1015\u102D\u102F\u1094\u1010\u103C\u1032",
  "Tabaung": "\u1010\u1031\u1015\u102B\u1004\u1039\u1038",
  "waxing": "\u101C\u1006\u1014\u1039\u1038",
  "waning": "\u101C\u1006\u102F\u1010\u1039",
  "full moon": "\u101C\u103B\u1015\u100A\u1039\u1037",
  "new moon": "\u101C\u1000\u103C\u101A\u1039",
  "Myanmar Year":
      "\u103B\u1019\u1014\u1039\u1019\u102C\u108F\u103D\u1005\u1039",
  "Ku": "\u1001\u102F",
  "Late": "\u1031\u108F\u103D\u102C\u1004\u1039\u1038",
  "Second": "\u1012\u102F",
  "Sunday": "\u1010\u1014\u1002\u1064\u1031\u108F\u103C",
  "Monday": "\u1010\u1014\u101C\u1064\u102C",
  "Tuesday": "\u1021\u1002\u1064\u102B",
  "Wednesday": "\u1017\u102F\u1012\u1076\u101F\u1030\u1038",
  "Thursday": "\u107E\u1000\u102C\u101E\u1015\u1031\u1010\u1038",
  "Friday": "\u1031\u101E\u102C\u107E\u1000\u102C",
  "Saturday": "\u1005\u1031\u1014",
  "Nay": "\u1031\u1014\u1094",
  "Yat": "\u101B\u1000\u1039",
  "Sabbath Eve": "\u1021\u1016\u102D\u1010\u1039",
  "Sabbath": "\u1025\u1015\u102F\u101E\u1039",
  "Yatyaza": "\u101B\u1000\u1039\u101B\u102C\u1007\u102C",
  "Afternoon Pyathada":
      "\u1019\u103C\u1014\u1039\u1038\u101C\u103C\u1032\u103B\u1015\u1086\u1012\u102B\u1038",
  "Pyathada": "\u103B\u1015\u1086\u1012\u102B\u1038",
  "New Year Day": "New Year's Day",
  "Independence Day":
      "\u101C\u103C\u1010\u1039\u101C\u1015\u1039\u1031\u101B\u1038\u1031\u1014\u1094",
  "Union Day":
      "\u103B\u1015\u100A\u1039\u1031\u1011\u102C\u1004\u1039\u1005\u102F\u1031\u1014\u1094",
  "Peasants Day":
      "\u1031\u1010\u102C\u1004\u1039\u101E\u1030 \u101C\u101A\u1039\u101E\u1019\u102C\u1038\u1031\u1014\u1094",
  "Resistance Day":
      "\u1031\u1010\u102C\u1039\u101C\u103D\u1014\u1039\u1031\u101B\u1038\u1031\u1014\u1094",
  "Labour Day":
      "\u1021\u101C\u102F\u1015\u1039\u101E\u1019\u102C\u1038\u1031\u1014\u1094",
  "Martyrs Day": "\u1021\u102C\u1007\u102C\u1014\u100A\u1039\u1031\u1014\u1094",
  "Christmas Day":
      "\u1001\u101B\u1005\u1065\u1019\u1010\u1039\u1031\u1014\u1094",
  "Buddha Day":
      "\u1031\u100A\u102C\u1004\u1039\u1031\u101B \u101E\u103C\u1014\u1039\u1038\u1015\u103C\u1032",
  "Start of Buddhist Lent":
      "\u1013\u1019\u107C\u1005\u107E\u1000\u102C\u1031\u1014\u1094",
  "End of Buddhist Lent":
      "\u1019\u102E\u1038\u1011\u103C\u1014\u1039\u1038\u1015\u103C\u1032",
  "Tazaungdaing":
      "\u1010\u1014\u1039\u1031\u1006\u102C\u1004\u1039\u1010\u102D\u102F\u1004\u1039",
  "National Day":
      "\u1021\u1019\u103A\u102D\u1033\u1038\u101E\u102C\u1038\u1031\u1014\u1094",
  "Karen New Year Day":
      "\u1000\u101B\u1004\u1039 \u1014\u103D\u1005\u1039\u101E\u1005\u1039\u1000\u1030\u1038",
  "Tabaung Pwe": "\u1010\u1031\u1015\u102B\u1004\u1039\u1038\u1015\u103C\u1032",
  "Thingyan Akyo":
      "\u101E\u107E\u1000\u1064\u1014\u1039 \u1021\u1080\u1000\u102D\u1033",
  "Thingyan Akya":
      "\u101E\u1080\u1000\u1064\u1014\u1039\u1039 \u1021\u1000\u103A",
  "Thingyan Akyat":
      "\u101E\u1080\u1000\u1064\u1014\u1039\u1039 \u1021\u107E\u1000\u1010\u1039",
  "Thingyan Atat":
      "\u101E\u1080\u1000\u1064\u1014\u1039\u1039 \u1021\u1010\u1000\u1039",
  "Myanmar New Year Day":
      "\u1014\u103D\u1005\u1039\u1006\u1014\u1039\u1038 \u1010\u1005\u1039\u101B\u1000\u1039",
  "Amyeittasote":
      "\u1021\u107F\u1019\u102D\u1010\u1071\u1005\u102F\u1010\u1039",
  "Warameittugyi":
      "\u101D\u102B\u101B\u1019\u102D\u1010\u1071\u1033\u1080\u1000\u102E\u1038",
  "Warameittunge":
      "\u101D\u102B\u101B\u1019\u102D\u1010\u1071\u1033\u1004\u101A\u1039",
  "Thamaphyu": "\u101E\u1019\u102C\u1038\u103B\u1016\u1034",
  "Thamanyo": "\u101E\u1019\u102C\u1038\u100A\u102D\u1033",
  "Yatpote": "\u101B\u1000\u1039\u1015\u102F\u1015\u1039",
  "Yatyotema": "\u101B\u1000\u1039\u101A\u102F\u1010\u1039\u1019\u102C",
  "Mahayatkyan":
      "\u1019\u101F\u102C\u101B\u1000\u1039\u107E\u1000\u1019\u1039\u1038",
  "Nagapor": "\u1014\u1002\u102B\u1038\u1031\u1015\u105A",
  "Shanyat": "\u101B\u103D\u1019\u1039\u1038\u101B\u1000\u1039",
  ":": "\u104A",
  ".": "\u104B",
  "Mon National Day":
      "\u1019\u103C\u1014\u1039\u1021\u1019\u103A\u102D\u1033\u1038\u101E\u102C\u1038\u1031\u1014\u1094",
  "G. Aung San BD":
      "\u1017\u102D\u102F\u101C\u1039\u1001\u103A\u1033\u1015\u1039\u1031\u1019\u103C\u1038\u1031\u1014\u1094",
  "Valentines Day":
      "\u1001\u103A\u1005\u1039\u101E\u1030\u1019\u103A\u102C\u1038\u1031\u1014\u1094",
  "Earth Day": "\u1000\u1019\u107B\u102C\u1031\u103B\u1019\u1031\u1014\u1094",
  "April Fools Day":
      "\u1027\u107F\u1015\u102E\u1021\u1090\u1030\u1038\u1031\u1014\u1094",
  "Red Cross Day":
      "\u107E\u1000\u1000\u1039\u1031\u103B\u1001\u1014\u102E\u1031\u1014\u1094",
  "United Nations Day":
      "\u1000\u102F\u101C\u101E\u1019\u107C\u1002\u1062\u1031\u1014\u1094",
  "Halloween": "\u101E\u101B\u1032\u1031\u1014\u1094",
  "Shan New Year Day":
      "\u101B\u103D\u1019\u1039\u1038\u1014\u103D\u1005\u1039\u101E\u1005\u1039\u1000\u1030\u1038",
  "Mothers Day": "\u1021\u1031\u1019\u1031\u1014\u1094",
  "Fathers Day": "\u1021\u1031\u1016\u1031\u1014\u1094",
  "Sasana Year": "\u101E\u102C\u101E\u1014\u102C\u108F\u103D\u1005\u1039",
  "Eid": "\u1021\u102D\u1012\u1039",
  "Diwali": "\u1012\u102E\u101D\u102B\u101C\u102E",
  "Mahathamaya Day": "\u1019\u101F\u102C\u101E\u1019\u101A\u1031\u1014\u1094",
  "Garudhamma Day": "\u1002\u1090\u102F\u1013\u1019\u107C\u1031\u1014\u1094",
  "Metta Day": "\u1031\u1019\u1010\u1071\u102C\u1031\u1014\u1094",
  "Taungpyone Pwe":
      "\u1031\u1010\u102C\u1004\u1039\u103B\u1015\u1033\u1014\u1039\u1038\u1015\u103C\u1032",
  "Yadanagu Pwe":
      "\u101B\u1010\u1014\u102C\u1037\u1002\u1030\u1015\u103C\u1032",
  "Authors Day":
      "\u1005\u102C\u1006\u102D\u102F\u1031\u1010\u102C\u1039\u1031\u1014\u1094",
  "World Teachers Day":
      "\u1000\u1019\u107B\u102C\u1037\u1006\u101B\u102C\u1019\u103A\u102C\u1038\u1031\u1014\u1094",
  "Holiday":
      "\u1090\u102F\u1036\u1038\u1015\u102D\u1010\u1039\u101B\u1000\u1039",
  "Chinese New Year":
      "\u1010\u1090\u102F\u1010\u1039\u108F\u103D\u1005\u1039\u101E\u1005\u1039\u1000\u1030\u1038",
  "Easter":
      "\u1011\u1031\u103B\u1019\u102C\u1000\u1039\u101B\u102C\u1031\u1014\u1094",
  "Good Friday":
      "\u1031\u101E\u102C\u107E\u1000\u102C\u1031\u1014\u1094\u1080\u1000\u102E\u1038",
  "West": "\u1021\u1031\u1014\u102C\u1000\u1039",
  "North": "\u1031\u103B\u1019\u102C\u1000\u1039",
  "East": "\u1021\u1031\u101B\u103D\u1095",
  "South": "\u1031\u1010\u102C\u1004\u1039",
  "Binga": "\u1018\u1002\u1064",
  "Atun": "\u1021\u1011\u103C\u1014\u1039\u1038",
  "Yaza": "\u101B\u102C\u1007",
  "Adipati": "\u1021\u1013\u102D\u1015\u1010\u102D",
  "Marana": "\u1019\u101B\u100F",
  "Thike": "\u101E\u102D\u102F\u1000\u1039",
  "Puti": "\u1015\u102F\u1010\u102D",
  "Orc": "\u1018\u102E\u101C\u1030\u1038",
  "Elf": "\u1014\u1010\u1039",
  "Human": "\u101C\u1030",
};
