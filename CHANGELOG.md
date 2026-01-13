## 3.2.5

- bumps: `myanmar_calendar_dart: ^1.1.0`

## 3.2.4

- Separate core calendar logic implementations by [myanmar_calendar_dart](https://pub.dev/packages/myanmar_calendar_dart) package

## 3.2.3

### 🎉 New Features

#### Exception Handling
- **Added custom exception classes** for better error handling throughout the package
  - `InvalidMyanmarDateException` - For invalid Myanmar date components with helpful suggestions
  - `InvalidWesternDateException` - For invalid Western date components
  - `DateConversionException` - For date conversion failures with factory methods
  - `DateParseException` - For date string parsing failures
  - `InvalidConfigurationException` - For invalid configuration parameters
  - `DateOutOfRangeException` - For dates outside supported ranges
  - `CacheException` - For caching system issues
  - `AstrologicalCalculationException` - For astrological calculation failures
  - `HolidayCalculationException` - For holiday calculation failures
- All exceptions include detailed error messages and recovery suggestions

#### Performance Utilities
- **Added `LRUCache<K, V>`** - Generic Least Recently Used cache with TTL support
  - Automatic eviction of least recently used items
  - Optional Time-To-Live for cache entries
  - Statistics tracking (hits, misses, hit rate)
  - Useful for general-purpose caching needs (Note: Use built-in `CalendarCache` for calendar dates)
- **Added `PerformanceMonitor`** - Track and measure operation performance
  - Measure synchronous and async operations
  - Track min/max/average execution times
  - Generate performance reports
- **Added `BatchOptimizer`** - Process large datasets without blocking UI
  - Configurable batch sizes and delays
  - Support for both sync and async processing
- **Added `Debouncer` and `Throttler`** - Control operation frequency
  - Prevent excessive function calls
  - Useful for search inputs and scroll handlers

#### Accessibility Features
- **Added `CalendarAccessibility`** - Comprehensive screen reader support
  - Generate semantic labels for dates (Myanmar + Western)
  - Include holiday and astrological information in labels
  - Screen reader announcements for date selection
  - Month navigation hints
- **Added `CalendarKeyboardHandler`** - Full keyboard navigation support
  - Arrow keys for date navigation
  - Enter/Space for selection
  - Home/End for quick navigation
  - Escape for dismissal
- **Added `HighContrastHelper`** - High contrast theme support
  - Detect high contrast mode
  - Apply appropriate colors and borders
- **Added `TextScalingHelper`** - Text scaling support
  - Respect system text scaling settings
  - Clamp font sizes within acceptable ranges
  - Support for large text mode

#### Optimized Widgets
- **Added `OptimizedCalendarCell`** - Best-practice calendar cell widget
  - Wrapped in `RepaintBoundary` for better performance
  - Full semantic labels for accessibility
  - High contrast theme support
  - Custom `MyanmarCalendarTheme` support
  - Automatic text scaling
  - Holiday and astrological indicators

#### Date Selection Modes
- **Added `CalendarSelectionMode`** support to `MyanmarCalendarWidget`
  - **Single selection**: Default behavior
  - **Range selection**: Select start and end dates with connected visual highlights and themed corners
  - **Multi selection**: Select multiple independent dates
- Added new callbacks: `onRangeSelected` and `onMultiSelected`

#### Advanced Astrology & AI
- **Added `HoroscopeWidget`** - A comprehensive widget for detailed astrological readings
  - Displays Nakhat, Mahabote, and auspiciousness status
  - Integrated AI prompt generation menu
- **Enhanced AI Prompt Generation**
  - Expanded `AIPromptType` to support **Horoscope**, **Fortune Telling**, and **Divination**
  - Fully localized prompt templates in all 6 supported languages
- **New Public API**: `MyanmarCalendar.generateAIPrompt` for easy access to the AI prompt engine

#### Localization
- **Extended localization** for all new astrological features in **Mon**, **Shan**, and **Karen**
- Improved astrological term descriptions across all languages

### 🔧 Improvements
- **Refactored `MyanmarCalendarWidget`** to use `OptimizedCalendarCell`
  - Reduced code by ~155 lines
  - Better performance with `RepaintBoundary`
  - Automatic accessibility support
  - Consistent theming
- **Added `westernWeekdayName` getter** to `CompleteDate` model
- **Updated to modern Flutter APIs**
  - `MediaQuery.textScalerOf()` instead of deprecated `textScaleFactor`
  - `MediaQuery.highContrastOf()` instead of deprecated `highContrast`
  - `Color.withValues(alpha:)` instead of deprecated `withOpacity()`
  - `SemanticsService.sendAnnouncement()` with View
- **Simplified API**: Publicly exported `AIPromptService` and `AIPromptType`
- Improved `MyanmarCalendarTheme` with new selection style properties

### 📚 Documentation
- Added comprehensive implementation guide
- Added detailed API documentation for all new utilities
- Added usage examples for exceptions, performance, and accessibility features

### 🧪 Testing
- Added comprehensive tests for exception classes (258 lines)
- Added tests for performance utilities (200+ lines)
- Total test coverage: 450+ lines of new tests

### 📦 Exports
All new features are properly exported from the main library:
- `src/exceptions/calendar_exceptions.dart`
- `src/utils/performance_utils.dart`
- `src/utils/accessibility_utils.dart`
- `src/widgets/optimized_calendar_cell.dart`

### ⚠️ Notes
- The new `LRUCache` is a general-purpose utility. For caching calendar dates, continue using the built-in `CalendarCache` which is optimized for calendar operations.
- All accessibility features are optional and work seamlessly with existing code.
- Performance utilities are available for monitoring and optimization but don't affect existing functionality.

## 3.2.2

- Redo `&f` and `&ff` format by removing Yat in `FormatService`
- Shan calendar year calculation support.

## 3.2.1

- Fixed: Diwali, Eid, Chinese new year holidays - Instead of hard-coded arrays, calculate these dates dynamically. Can be extend more in the future.
- Fixed: `MyanmarDateTime` cached with better approach
- Added anniversary days and other holidays getter to `MyanmarDateTime`
- Publically export `translateNumbers()` in `FormatService`

## 3.2.0

- Added `Cache` system: See [Cache Docs](https://github.com/mixin27/flutter-mmcalendar/blob/main/cache.md) for usage.

## 3.1.1

- Added `MoonPhaseIndicator` widget
- Added chronicles and dynasties data

## 3.1.0

- Fixed myanmar `National Day` calculation.
- Added `National Day` translation
- Remove unrelated holidays like `UN Day`, `Valentines Day`, etc.
- Added chronicles and dynasties data and can be used via public api

## 3.0.0

- Fixed `isToday` calculation in `CompleteDate`
- Fixed weekday style with compact mode flag
- Fixed myanmar month translation
- Added condition for special years in `getMyanmarMonth()`
- Added `MoonPhase` painter and widget for early use. There is a plan to make more advance.

## 3.0.0-dev.3

- Added more getter values like `isToday` in `CompleteDate`.
- Fixed wrong information in document comments

## 3.0.0-dev.2

- Fixed: Widget theme color
- Update example application
- Minor improvements

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
