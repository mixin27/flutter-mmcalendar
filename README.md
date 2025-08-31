# Flutter MMCalendar

[![License: MIT][license_badge]][license_link]
![Pub Version (including pre-releases)](https://img.shields.io/pub/v/flutter_mmcalendar?style=flat-square&color=3297D1&link=https%3A%2F%2Fpub.dev%2Fpackages%2Fflutter_mmcalendar)

Package to get **Myanmar** calendar information with `Burmese Astrological Information`, `Holidays` and `Moon phase` widget.

You can check [Myanmar Calendar App](https://github.com/mixin27/mmcalendar) using `flutter_mmcalendar`.

## Installation 💻

**❗ In order to start using `flutter_mmcalendar` you must have the [Flutter SDK][flutter_install_link] installed on your machine.**

Add `flutter_mmcalendar` to your `pubspec.yaml`:

```yaml
dependencies:
  flutter_mmcalendar:
```

Install it:

```sh
flutter packages get
```

## Features

- `Myanmar Date`
- `Western Date`
- `Astrological Information`
- `Holidays` - Myanmar Thingyan holidays and other holidays.
- `MoonPhase` widget.

## Usage

Import package

```dart
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
```

Sample Usage:

```dart
// Default
final mmCalendar = MmCalendar();

// English language config
final mmCalendar = MmCalendar(
  config: MmCalendarConfig.englishLanguage(),
);

// Specific language and calendar type
final mmCalendar = MmCalendar(
  config: const MmCalendarConfig(
    calendarType: CalendarType.gregorian,
    language: Language.myanmar,
  ),
);
```

And use it

```dart
// Get MyanmarDate by year, month and day
final myanmarDate = mmCalendar.fromDate(2023, 10, 19);

// Get MyanmarDate from DateTime
final today = DateTime.now();
final myanmarDate = mmCalendar.fromDateTime(tody);
```

Available configs:

- `MmCalendarConfig.defaultConfig()`
- `MmCalendarConfig.myanmarLanguage()`
- `MmCalendarConfig.zawgyiLanguage()`
- `MmCalendarConfig.englishLanguage()`
- `MmCalendarConfig.monLanguage()`
- `MmCalendarConfig.karenLanguage()`
- `MmCalendarConfig.taiLanguage()`

Available languages:

- `english`
- `myanmar` - Myanmar Unicode
- `zawgyi` - Myanmar Zawgyi
- `mon`
- `karen`
- `tai`

> **NOTE:** I am not gaurantee all of the languages are properply translated well. If you find out some translations are wrong, you can contact the developer via Email or you can contribute the github repository for translation accuracy.

### Changing calendar config settings

You can call the following methods from your app settings. It will change globally.

```dart
// Calendar type
GlobalCalendarConfig().setCalendarType(CalendarType.julian);
// Language
GlobalCalendarConfig().setLanguage(Language.english);
```

Other usages:

```dart
final mmCalendar = MmCalendar();

// Date conversion methods.
// From built-in DateTime
mmCalendar.fromDateTime(DateTime.now());

// From a specified date
mmCalendar.fromDate(2023, 7, 27);

// From a specified date and time
mmCalendar.fromDateAndTime(2023, 7, 27, 10, 30, 01);

// From julian day
mmCalendar.fromJulian(2456599);

// Get WesternDate from julian day
final westernDate = mmCalendar.getWesternDateFromJulianDay(2456599);

/// Astrological information
final date = DateTime.now();
final astro = mmCalendar.getAstro(date);

// or you can get Astro from MyanmarDate
final astro = myanmarDate.astrol

astro.getMahabote();

// All Holidays
List<String> holidays = mmCalendar.getHolidays(DateTime.now());
List<String> anniversaries = mmCalendar.getAnniversaries(DateTime.now());
List<String> thingyanDays = mmCalendar.getThingyanDays(DateTime.now());

// or
List<String> holidays = myanmarDate.holidays;

// Formatting
// Default
final mmDateStr = myanmarDate.format();
// Custom pattern
final mmDateStr = myanmarDate.format("S s k, B y k, M p f r, En.");
```

#### Myanmar Date Format Patterns

Myanmar Date formats are specified by date pattern strings.
The following pattern letters are defined ('S', 's', 'B', 'y', 'k', 'M', 'p', 'f', 'E', 'n', 'r', are reserved):

```dart
// S s k, B y k, M p f r En
MyanmarDateFormat.simple
// S
MyanmarDateFormat.sasanaYear
// s
MyanmarDateFormat.buddhistEra
// B
MyanmarDateFormat.burmeseYear
// y
MyanmarDateFormat.myanmarYear
// k
MyanmarDateFormat.ku
// M
MyanmarDateFormat.monthInYear
// p
MyanmarDateFormat.moonPhase
// f
MyanmarDateFormat.fortnightDay
// E
MyanmarDateFormat.dayNameInWeek
// n
MyanmarDateFormat.nay
// r
MyanmarDateFormat.yat
```

| Letter | Date Component   | Examples Myanmar | Examples English |
| ------ | ---------------- | ---------------- | ---------------- |
| S      | Sasana year      | သာသနာနှစ်        | Sasana Year      |
| s      | Buddhist era     | ၂၅၆၁             | 2561             |
| B      | Burmese year     | မြန်မာနှစ်       | Myanmar Year     |
| y      | Myanmar year     | ၁၃၇၉             | 1379             |
| k      | Ku               | ခု               |                  |
| M      | Month in year    | ဝါခေါင်          | Wagaung          |
| p      | Moon phase       | လဆန်း            | waxing           |
| f      | Fortnight Day    | ၁                | 1                |
| r      | Yat              | ရက်              |                  |
| E      | Day name in week | တနင်္လာ          | Monday           |
| n      | Nay              | နေ့              |                  |

### Astrological Information

```dart
final mmCalendar = MmCalendar();

final myanmarDate = mmCalendar.fromDate(2023, 10, 19);
final astro = myanmarDate.astro;

// or
final astro = mmCalendar.getAstro(DateTime(2023, 10, 19))

// အမြိတ္တစုတ်
final amyeittasote = astro.getAmyeittasote();

// ရက်ရာဇာ, ပြဿဒါး, မွန်းလွဲပြဿဒါး
final astrologicalDay = astro.getAstrologicalDay();

// "Binga", "Atun", "Yaza", "Adipati", "Marana", "Thike", "Puti"
final mahabote = astro.getMahabote();

// မဟာရက်ကြမ်း
final mahayatkyan = astro.getMahayatkyan();

// "West", "North", "East", "South"
final nagahle = astro.getNagahle();

// နဂါးပေါ်
final nagapor = astro.getNagapor();

// "Ogre", "Elf", "Human"
final nakhat = astro.getNakhat();

// ဥပုသ်
final sabbath = astro.getSabbath();

// ရှမ်းရက်
final shanyat = astro.getShanyat();

// သမားညို
final thamanyo = astro.getThamanyo();

// သမားဖြူ
final thamaphyu = astro.getThamaphyu();

// ဝါရမိတ္တုကြီး
final warameittugyi = astro.getWarameittugyi();

// ဝါရမိတ္တုငယ်
final warameittunge = astro.getWarameittunge();

// ရက်ပုပ်
final yatpote = astro.getYatpote();

// ရက်ယုတ်မာ
final yatyotema = astro.getYatyotema();

// "ပုဿနှစ်", "မာခနှစ်", "ဖ္လကိုန်သံဝစ္ဆိုဝ်ရနှစ်", "စယ်နှစ်", "ပိသျက်နှစ်", "စိဿနှစ်", "အာသတ်နှစ်", "သရဝန်နှစ်",
// "ဘဒ္ဒြသံဝစ္ဆုံရ်နှစ်", "အာသိန်နှစ်", "ကြတိုက်နှစ်", "မြိက္ကသိုဝ်နှစ်"
final yearName = astro.getYearName();
```

You can also check these days by calling `is` prefix properties.

Example:

```dart
// It will return true or false
final isAmyeittasote = astro.isAmyeittasote;
```

### Moon Phase Widget

```dart
MoonPhaseWidget(
  date: DateTime.now(),
  size: 90,
),
```

### Concept reference resources

Algorithm, Program and Calculation of Myanmar Calendar

- [https://cool-emerald.blogspot.com/2013/06/algorithm-program-and-calculation-of.html](https://cool-emerald.blogspot.com/2013/06/algorithm-program-and-calculation-of.html) [(Dr Yan Naing Aye)](https://github.com/yan9a/)

C++ and Javascript Implementation

- [https://github.com/yan9a/mmcal](https://github.com/yan9a/mmcal)

Java Library Implementation

- [https://github.com/chanmratekoko/mmcalendar](https://github.com/chanmratekoko/mmcalendar)

[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[flutter_install_link]: https://docs.flutter.dev/get-started/install
