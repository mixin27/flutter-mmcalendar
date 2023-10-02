**Myanmar Calendar** package for `Flutter` and `dart` applications.

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
  final mmCalendarBuilder = MmCalendarBuilder()
      .setCalendarType(CalendarType.english)
      .setLanguage(Language.english)
      .build();
  Config.initDefault(mmCalendarBuilder);

  runApp(const MyApp());
}

```

```dart
// Get MyanmarDate by year, month and day
MyanmarDate myanmarDate = MyanmarDateConverter.convertByYMD(2023, 10, 29);

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
myanmarDate.formatByPatternAndLanguage(
    'S s k, B y k, M p f r En',
    LanguageCatalog(language: Language.myanmar),
);
// Output: သာသနာနှစ် ၂၅၆၇ ခု, မြန်မာနှစ် ၁၃၈၅ ခု, သီတင်းကျွတ် လပြည့်  ရက် တနင်္ဂနွေနေ့
// (or)

myanmarDate.formatByPatternAndLanguage(
    'S s k, B y k, M p f r En',
    LanguageCatalog(language: Language.english),
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

### Concept reference resources

Algorithm, Program and Calculation of Myanmar Calendar

- [http://cool-emerald.blogspot.sg/2013/06/algorithm-program-and-calculation-of.html](http://cool-emerald.blogspot.sg/2013/06/algorithm-program-and-calculation-of.html) [(Dr Yan Naing Aye)](https://github.com/yan9a/)

Java Library

- [https://github.com/chanmratekoko/mmcalendar](https://github.com/chanmratekoko/mmcalendar)
