## 3.0.0-dev.1

### Breaking Changes

- Complete rewrite of core date calculation engine
- Restructured API for better consistency and type safety
- Renamed and consolidated various utility methods

### New Features

- 📅 **Complete Myanmar Calendar System**: Full support for Myanmar calendar with accurate date conversions
- 🌙 **Astrological Calculations**: Buddhist era, sabbath days, moon phases, yatyaza, pyathada, and more
- 🎯 **Multi-language Support**: Myanmar, English, Mon, Shan, Karen, and Zawgyi scripts
- 🎨 **Beautiful UI Components**: Pre-built calendar widgets and date pickers
- 🌐 **Holiday Support**: Myanmar public holidays, religious days, and cultural events
- ⚙️ **Highly Configurable**: Customizable themes, date formats, and display options
- 📱 **Responsive Design**: Works perfectly on mobile, tablet, and desktop
- 🔄 **Date Arithmetic**: Easy date calculations and manipulations
- 🛡️ **Type Safe**: Full null safety support with comprehensive error handling

### Improvements

- Optimized performance for date conversions
- Comprehensive documentation and examples
- Calendar and picker widgets with theme customization options
- Improved error handling and validation

### Documentation

- Added detailed API documentation
- New example applications
- Comprehensive README with usage examples
- Added contributing guidelines
- Improved inline code documentation

### Dependencies

- Requires Flutter 3.0.0 or higher
- Dart SDK ">=3.0.0 <4.0.0"

### Internal Changes

- Restructured project architecture
- Added comprehensive test suite
- New build and deployment pipeline
- Improved code organization and modularity

## 2.0.1

- Added `puntuation` and `puntuation` translation.

## 2.0.0

> Breaking Changes

- `MmCalendarConfig` improvement for calendar language translation.
- Refactor code base for cleaness
- Remove some unnecessay helper functions and files

## 1.1.2

- `Calculation` classes are now available to use.
- Documentation update

## 1.1.1

- Add `MoonPhaseWidget`
- Fixed language does not change while config change

## 1.1.0

**BREAKING CHANGES**

- Remove `MmCalendarConfig.initDefault()`.

## 1.0.1

- Fixed `fortnightDay` wrong for some year.

## 1.0.0

- Update `flutter_lints` to `4.0.0`
- Stable version release.

## 0.0.8

- Upgrade `flutter_lints` to `3.0.0`
- Update `README.md` document

## 0.0.7

- Fixed: `getSabbath()` return wrong value

## 0.0.6

- Fixed: `Thingyan` calculation wrong
- Add more example

## 0.0.5

- Add `Tai` and `Karen` language maps
- Change to name parameters in `MyanmarDate.formatByPatternAndLanguage` and `MyanmarDate.format`

## 0.0.4

- Update `README.md`
- Fixed: calculator not exported
- `Myanmar Thingyan` days retrieving.

## 0.0.3

- Update `README.md`
- Update example code

## 0.0.2

- Redesign code base

## 0.0.1

- `MyanmarDateConverter`
- `WesternDateConverter`
- `AstrologicalConverter`
- `Holidays` calculation including myanmar `Thingyan` holidays.
