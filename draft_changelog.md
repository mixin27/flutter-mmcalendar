# Changelog

All notable changes to the Myanmar Calendar Flutter package will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [3.0.0] - 2025-09-24

### 🎉 Initial Release

This is the first stable release of Myanmar Calendar Flutter - a comprehensive Flutter package for Myanmar (Burmese) calendar system with full support for date conversions, astrological calculations, and localization.

### ✨ Added

#### Core Features

- **Myanmar Calendar System**: Complete implementation of traditional Myanmar calendar
- **Date Conversion**: Bidirectional conversion between Gregorian and Myanmar calendars
- **Astrological Calculations**: Full support for Myanmar astrology including:
  - Moon phases (Waxing, Full, Waning, New)
  - Sabbath days calculation
  - Yatyaza, Pyathada, Nagahle calculations
  - Mahabote, Nakhat calculations
  - 12-year cycle animal names
- **Holiday System**: Comprehensive holiday database with:
  - Public holidays
  - Religious holidays (Buddhist)
  - Cultural festivals
  - Regional celebrations

#### Multi-Language Support

- **6 Languages**: Myanmar Unicode, Zawgyi, English, Mon, Shan, Karen
- **Dynamic Language Switching**: Runtime language changes
- **Localized Formatting**: Date formatting in all supported languages
- **Translation Service**: Built-in translation system for UI elements

#### Widgets & UI Components

- **MyanmarCalendarWidget**: Full-featured calendar display widget
- **MyanmarDatePickerWidget**: Interactive date picker with modal support
- **Customizable Themes**: Built-in and custom theme support
- **Responsive Design**: Adaptive layouts for different screen sizes

#### Date & Time Classes

- **MyanmarDateTime**: Primary date-time class with extensive functionality
- **MyanmarDate**: Core Myanmar date representation
- **WesternDate**: Western calendar date handling
- **CompleteDate**: Comprehensive date information container

#### Configuration & Customization

- **CalendarConfig**: Flexible configuration system
- **Theme System**: Extensive theming capabilities with:
  - Light and dark themes
  - Custom color schemes
  - Configurable typography
  - Border and elevation controls
- **Calendar Types**: Support for British, Gregorian, and Julian calendar systems

#### Utility Functions

- **Date Arithmetic**: Add/subtract days, months, years
- **Date Validation**: Comprehensive validation system
- **Batch Operations**: Process multiple dates efficiently
- **Julian Day Calculations**: Astronomical date calculations
- **Moon Phase Finding**: Find next/previous moon phases
- **Sabbath Detection**: Find sabbath days in any month/year

#### Developer Tools

- **API Documentation**: Comprehensive inline documentation
- **Type Safety**: Full null safety support
- **Error Handling**: Robust error handling with detailed messages
- **Diagnostics**: Built-in diagnostic tools for troubleshooting
- **Testing Support**: Comprehensive test coverage

### 📱 Platform Support

- **Android**: API 21+ (Android 5.0+)
- **iOS**: iOS 11.0+
- **Web**: Modern browsers
- **Desktop**: Windows, macOS, Linux

### 🎨 Theming & Customization

- **Pre-built Themes**: Default, Dark, Traditional, Royal, Emerald, Crimson, Ocean, Sunset
- **Custom Theme Builder**: Create and export custom themes
- **Color Customization**: Full control over all UI colors
- **Typography Control**: Customizable fonts and text styles
- **Layout Options**: Configurable spacing, borders, and elevations

### 🌍 Localization Features

- **Date Formatting**: Flexible date formatting patterns
- **Number Localization**: Numbers displayed in local scripts
- **Month Names**: Localized month and weekday names
- **Holiday Names**: Translated holiday descriptions
- **UI Strings**: All user interface text localized

### 🔧 Configuration Options

- **Sasana Year Types**: Multiple calculation methods (0, 1, 2)
- **Calendar Systems**: British, Gregorian, Julian support
- **Timezone Support**: Configurable timezone offsets
- **Gregorian Start**: Customizable Gregorian calendar adoption date
- **Validation Limits**: Configurable date range limits

### 📊 Performance & Optimization

- **Lazy Loading**: Efficient resource loading
- **Caching System**: Smart caching for date calculations
- **Memory Management**: Optimized memory usage
- **Fast Calculations**: Optimized algorithms for date conversions
- **Minimal Dependencies**: Lightweight package with minimal external dependencies

### 🧪 Testing & Quality

- **Unit Tests**: Comprehensive test coverage for all calculations
- **Widget Tests**: UI component testing
- **Integration Tests**: End-to-end testing
- **Date Accuracy**: Validated against traditional Myanmar calendar sources
- **Performance Tests**: Benchmarked for optimal performance

### 📚 Documentation & Examples

- **API Documentation**: Complete API reference
- **Usage Examples**: Comprehensive examples for all features
- **Demo Application**: Full-featured demo app showcasing all capabilities
- **Migration Guide**: Easy migration from other calendar packages
- **Best Practices**: Development guidelines and recommendations

### 🛠️ Developer Experience

- **Hot Reload**: Full hot reload support during development
- **Debugging Tools**: Built-in debugging and diagnostic features
- **Error Messages**: Clear, actionable error messages
- **IDE Support**: Full IntelliSense and code completion
- **Package Info**: Runtime package information and diagnostics

### 📋 API Highlights

```dart
// Core usage examples
final today = MyanmarCalendar.today();
final myanmarDate = MyanmarCalendar.fromWestern(2024, 1, 1);
final complete = MyanmarCalendar.getCompleteDate(DateTime.now());

// Widget usage
MyanmarCalendarWidget(
  language: Language.myanmar,
  showHolidays: true,
  showAstrology: true,
  onDateSelected: (date) => print(date.formatComplete()),
)

// Date picker
final selected = await showMyanmarDatePicker(
  context: context,
  language: Language.english,
  initialDate: DateTime.now(),
);
```

### 🔍 Validation & Error Handling

- **Input Validation**: Comprehensive validation for all date inputs
- **Error Recovery**: Graceful error handling with fallback options
- **Validation Results**: Detailed validation results with error descriptions
- **Range Checking**: Configurable date range validation
- **Type Safety**: Null-safe API design throughout

### 🎯 Use Cases

- **Calendar Applications**: Full-featured calendar apps
- **Event Management**: Holiday and event tracking systems
- **Educational Apps**: Myanmar culture and calendar learning
- **Religious Applications**: Buddhist calendar and festival tracking
- **Cultural Preservation**: Digital preservation of Myanmar calendar traditions
- **Business Applications**: Myanmar-localized business applications

### 📦 Package Structure

```bash
lib/
├── myanmar_calendar.dart          # Main API
├── src/
│   ├── core/                     # Core date-time classes
│   ├── localization/             # Multi-language support
│   ├── models/                   # Data models
│   ├── services/                 # Business logic services
│   ├── utils/                    # Utility functions
│   └── widgets/                  # UI components
└── example/                      # Demo application
```

### 🚀 Getting Started

```yaml
dependencies:
  flutter_mmcalendar: ^1.0.0
```

```dart
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

void main() {
  // Configure the calendar
  MyanmarCalendar.configure(
    language: Language.myanmar,
    timezoneOffset: 6.5,
  );

  // Get today's date
  final today = MyanmarCalendar.today();
  print('Today: ${today.formatComplete()}');
}
```

### 🙏 Acknowledgments

- Traditional Myanmar calendar scholars and references
- Flutter community for framework support
- Contributors and testers
- Myanmar developer community

### 📄 License

MIT License - see LICENSE file for details

---

## Next Release Plans

### [3.1.0] - Planned Features

- **Enhanced Widgets**: Additional calendar view modes
- **Advanced Theming**: More theme customization options
- **Performance Improvements**: Further optimization of calculations
- **Extended Localization**: Additional language support
- **Custom Event System**: User-defined events and reminders
- **Export Functionality**: Calendar export to various formats

### Feedback & Contributions

We welcome feedback, bug reports, and contributions! Please visit our GitHub repository or pub.dev page to:

- Report issues
- Suggest features
- Contribute code
- Improve documentation

---

**Package**: flutter_mmcalendar

**Homepage**: [https://pub.dev/packages/flutter_mmcalendar](https://pub.dev/packages/flutter_mmcalendar)

**Repository**: [https://github.com/mixin27/flutter-mmcalendar](https://github.com/mixin27/flutter-mmcalendar)

**Documentation**: [https://pub.dev/documentation/flutter_mmcalendar/](https://pub.dev/documentation/flutter_mmcalendar/)
