**Myanmar Calendar** package for `Flutter` applications.

## Features

- `Myanmar Date Converter`
- `Western Date Converter`
- `Astrological Converter`
- `Myanmar Thingyan` holidays and other holidays calculation

## Getting started

Add package

```yaml
dependencies:
  flutter_mmcalendar: ^0.0.1
```

Import package

```dart
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
```

## Usage

Configure default `calendarType` and `language`. It is `optional`.

```dart
void main() {
  MmCalendarConfig.initDefault(
    const MmCalendarOptions(
      language: Language.myanmar,
    ),
  );

  runApp(const MyApp());
}

```

Sample Usage:

```dart
// Get MyanmarDate by year, month and day
final myanmarDate = MyanmarDateConverter.fromDate(2023, 10, 19);

// Output: 2567
final buddhistEra = myanmarDate.getBuddhistEra();

// Output: 1385
final year = myanmarDate.getYear();

// Output: Thadingyut
final monthName = myanmarDate.getMonthName();

// Output: full moon
final moonPhase = myanmarDate.getMoonPhase();

// Output: empty
final fortNightDay = myanmarDate.getFortnightDay();

// Output: Sunday
final weekday = myanmarDate.getWeekDay();
```

### Myanmar Date format

```dart
final myanmarDate = MyanmarDateConverter.fromDate(2023, 10, 19);

final resultStr = myanmarDate.formatByPatternAndLanguage(
    pattern: 'S s k, B y k, M p f r En',
    languageCatalog: LanguageCatalog(language: Language.myanmar),
);
// Output: သာသနာနှစ် ၂၅၆၇ ခု, မြန်မာနှစ် ၁၃၈၅ ခု, သီတင်းကျွတ် လပြည့်  ရက် တနင်္ဂနွေနေ့
// (or)

final resultStr = myanmarDate.formatByPatternAndLanguage(
    pattern: 'S s k, B y k, M p f r En',
    languageCatalog: LanguageCatalog(language: Language.english),
);
// Output: Sasana Year 2567 , Myanmar Year 1385 , Thadingyut full moon   Sunday
```

#### Myanmar Date Patterns

Myanmar Date formats are specified by date pattern strings.
The following pattern letters are defined ('S', 's', 'B', 'y', 'k', 'M', 'p', 'f', 'E', 'n', 'r', are reserved):

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

### Available Converters

- `MyanmarDateConverter`
- `WesternDateConverter`
- `AstroConverter`

`MyanmarDateConverter`

```dart
// Get MyanmarDate by dart DateTime
final myanmarDate = MyanmarDateConverter.fromDateTime(DateTime.now());
// Get MyanmarDate by custom year, month and day
final myanmarDate = MyanmarDateConverter.fromDate(2023, 10, 19);
// Get MyanmarDate by custom year, month, day, hour, minute and second
final myanmarDate = MyanmarDateConverter.fromDateAndTime(2023, 10, 19, 12, 30, 00);
// Get MyanmarDate by julian day numbers
final myanmarDate = MyanmarDateConverter.fromJulianDate(2460237);
```

`WesternDateConverter`

```dart
// By julian day number
final westernDate = WesternDateConverter.fromJulianDate(julianDate);
// By MyanmarDate
final westernDate = WesternDateConverter.fromMyanmarDate(myanmarDate);
```

`AstroConverter`

```dart
final astro = AstroConverter.convert(myanmarDate);
```

### Available Converting Logics

- **`AstroLogic`**
  - `getAstro()`
- **`MyanmarDateLogic`**
  - `julianToMyanmarDate()`
  - `myanmarDateToJulian()`
  - `myanmarDateToJulianWithDate()`
  - `toJulian()`
  - `getMyanmarMonths()`
- **`WesternDateLogic`**
  - `julianToWestern()`
  - `westernToJulian()`
  - `westernToJulianWithTime()`
  - `toJulian()`
  - `getJulianDayNumberOfStartOfMonth()`
  - `getJulianDayNumberOfEndOfMonth()`
  - `getLengthOfMonth()`

### Available Holidays Calculation

- `ThingyanCalculator`

  - `getMyanmarThingyanDaysFromDateTime()`
  - `getMyanmarThingyanDays()`

  ```dart
    final thingyanHolidays = ThingyanCalculator.getMyanmarThingyanDaysFromDateTime(DateTime.now());
  ```

  - `getThingyanFromDateTime()`
  - `getThingyan()`

- `HolidayCalculator`
  - `getHolidays()`
  - `myanmarHolidays()`
  - `thingyanHolidays()`
  - `englishHolidays()`
  - `englishAnniversaryDays()`
  - `myanmarAnniversaryDays()`
  - `getAnniversaries()`
  - `otherHolidays()`

### Astrological Information

```dart
final myanmarDate = MyanmarDateConverter.fromDateTime(DateTime.now());
final astro = AstroConverter.convert(myanmarDate);

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

// "Orc", "Elf", "Human"
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

### Concept reference resources

Algorithm, Program and Calculation of Myanmar Calendar

- [https://cool-emerald.blogspot.com/2013/06/algorithm-program-and-calculation-of.html](https://cool-emerald.blogspot.com/2013/06/algorithm-program-and-calculation-of.html) [(Dr Yan Naing Aye)](https://github.com/yan9a/)

C++ and Javascript Implementation

- [https://github.com/yan9a/mmcal](https://github.com/yan9a/mmcal)

Java Library Implementation

- [https://github.com/chanmratekoko/mmcalendar](https://github.com/chanmratekoko/mmcalendar)
