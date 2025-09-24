# Contributing to Flutter Myanmar Calendar

Thank you for your interest in contributing to Flutter Myanmar Calendar! This document provides guidelines and instructions for contributing to this project.

## Code of Conduct

Please read and follow our [Code of Conduct](CODE_OF_CONDUCT.md) to maintain a respectful and inclusive environment.

## Getting Started

1. Fork the repository and clone it locally:

```bash
git clone https://github.com/yourusername/flutter-mmcalendar.git
cd flutter-mmcalendar
```

2. Install dependencies:

```bash
flutter pub get
```

3. Create a new branch for your changes:

```bash
git checkout -b feature/your-feature-name
```

## Development Guidelines

### Code Style

- Follow the [Flutter style guide](https://github.com/flutter/flutter/blob/master/docs/contributing/Style-guide-for-Flutter-repo.md)
- Use proper Dart formatting:

```bash
dart format .
```

- Run static analysis:

```bash
flutter analyze
```

### Testing

- Add tests for new features or bug fixes
- Ensure all tests pass:

```bash
flutter test
```

- Aim for good test coverage

### Documentation

- Update documentation for new features or changes
- Include dartdoc comments for public APIs
- Update example app if necessary
- Keep README.md up to date

## Project Structure

```bash
lib/
  ├── src/
  │   ├── core/           # Core calendar logic
  │   ├── localization/   # Language support
  │   ├── models/         # Data models
  │   ├── services/       # Calendar services
  │   ├── utils/          # Utility functions
  │   └── widgets/        # UI components
  ├── flutter_mmcalendar.dart
  └── ...
```

## Making Contributions

1. **Create an Issue**
   - For bugs: Include steps to reproduce, expected vs actual behavior
   - For features: Describe the feature and its benefits

2. **Submit a Pull Request**
   - Reference the related issue
   - Describe your changes
   - Include screenshots for UI changes
   - Update tests and documentation
   - Ensure CI checks pass

3. **Review Process**
   - Maintainers will review your PR
   - Address review comments
   - Keep the PR updated with the main branch

## Calendar-Specific Guidelines

### Date Calculations

- Use UTC for internal calculations
- Test edge cases (leap years, Myanmar calendar exceptions)
- Validate date ranges

### Localization

- Support both Myanmar and English
- Use translation keys
- Test with different languages

### UI Components

- Follow Material Design guidelines
- Support both light and dark themes
- Ensure accessibility
- Test on different screen sizes

## Release Process

1. Version numbers follow [Semantic Versioning](https://semver.org/)
2. Update CHANGELOG.md
3. Create a release tag
4. Publish to pub.dev

## Getting Help

- Open an issue for questions
<!-- - Join our [Discord channel](#) for discussions -->
- Check existing issues and documentation

## License

By contributing, you agree that your contributions will be licensed under the project's [MIT License](LICENSE).
