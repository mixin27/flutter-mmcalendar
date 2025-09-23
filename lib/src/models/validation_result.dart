/// Result of validation operations for Myanmar calendar dates and components
///
/// This class encapsulates the result of various validation operations throughout
/// the Myanmar Calendar package. It provides a consistent way to handle validation
/// results, error messages, and additional context information.
///
/// Example:
/// ```dart
/// ValidationResult result = validateMyanmarDate(1380, 5, 15);
/// if (result.isValid) {
///   print('Date is valid');
/// } else {
///   print('Validation failed: ${result.error}');
///   if (result.hasWarnings) {
///     print('Warnings: ${result.warnings}');
///   }
/// }
/// ```
class ValidationResult {
  /// Whether the validation passed
  final bool isValid;

  /// Error message if validation failed, null if valid
  final String? error;

  /// Warning messages (non-critical issues)
  final List<String> warnings;

  /// Additional context or details about the validation
  final Map<String, dynamic>? context;

  /// Error code for programmatic handling
  final String? errorCode;

  /// Severity level of the validation result
  final ValidationSeverity severity;

  /// Field or component that failed validation
  final String? field;

  /// Suggested corrections or alternatives
  final List<String> suggestions;

  /// Creates a validation result
  ///
  /// [isValid] indicates whether the validation passed
  /// [error] provides a human-readable error message if validation failed
  /// [warnings] contains non-critical issues that don't prevent operation
  /// [context] can contain additional details about the validation
  /// [errorCode] provides a code for programmatic error handling
  /// [severity] indicates the severity level of any issues
  /// [field] identifies which field or component failed validation
  /// [suggestions] provides potential corrections or alternatives
  const ValidationResult({
    required this.isValid,
    this.error,
    this.warnings = const [],
    this.context,
    this.errorCode,
    this.severity = ValidationSeverity.error,
    this.field,
    this.suggestions = const [],
  });

  /// Creates a successful validation result
  ///
  /// This factory constructor creates a validation result that indicates
  /// successful validation with optional warnings and context.
  ///
  /// Example:
  /// ```dart
  /// ValidationResult.success(); // Simple success
  /// ValidationResult.success(
  ///   warnings: ['Date is at the edge of supported range'],
  ///   context: {'adjustedValue': correctedDate},
  /// );
  /// ```
  factory ValidationResult.success({
    List<String> warnings = const [],
    Map<String, dynamic>? context,
    List<String> suggestions = const [],
  }) {
    return ValidationResult(
      isValid: true,
      warnings: warnings,
      context: context,
      severity: warnings.isEmpty
          ? ValidationSeverity.none
          : ValidationSeverity.warning,
      suggestions: suggestions,
    );
  }

  /// Creates a failed validation result
  ///
  /// This factory constructor creates a validation result that indicates
  /// failed validation with error details.
  ///
  /// Example:
  /// ```dart
  /// ValidationResult.failure(
  ///   error: 'Invalid month value',
  ///   errorCode: 'INVALID_MONTH',
  ///   field: 'month',
  ///   suggestions: ['Month must be between 1 and 14'],
  /// );
  /// ```
  factory ValidationResult.failure({
    required String error,
    String? errorCode,
    String? field,
    List<String> warnings = const [],
    Map<String, dynamic>? context,
    ValidationSeverity severity = ValidationSeverity.error,
    List<String> suggestions = const [],
  }) {
    return ValidationResult(
      isValid: false,
      error: error,
      errorCode: errorCode,
      field: field,
      warnings: warnings,
      context: context,
      severity: severity,
      suggestions: suggestions,
    );
  }

  /// Creates a validation result with warnings only
  ///
  /// This factory constructor creates a successful validation result
  /// but with warnings that should be noted.
  ///
  /// Example:
  /// ```dart
  /// ValidationResult.withWarnings([
  ///   'Date is in a historical period with limited accuracy',
  ///   'Consider using approximate calculations',
  /// ]);
  /// ```
  factory ValidationResult.withWarnings(
    List<String> warnings, {
    Map<String, dynamic>? context,
    List<String> suggestions = const [],
  }) {
    return ValidationResult(
      isValid: true,
      warnings: warnings,
      context: context,
      severity: ValidationSeverity.warning,
      suggestions: suggestions,
    );
  }

  /// Creates a validation result indicating an invalid range
  ///
  /// This factory constructor is specialized for range validation errors.
  factory ValidationResult.invalidRange({
    required String field,
    required dynamic value,
    required dynamic min,
    required dynamic max,
    String? customMessage,
  }) {
    final error =
        customMessage ??
        '$field value $value is out of range. Must be between $min and $max.';

    return ValidationResult.failure(
      error: error,
      errorCode: 'OUT_OF_RANGE',
      field: field,
      context: {'value': value, 'min': min, 'max': max},
      suggestions: ['Use a value between $min and $max'],
    );
  }

  /// Creates a validation result indicating a required field is missing
  ///
  /// This factory constructor is specialized for required field validation.
  factory ValidationResult.requiredField(String field) {
    return ValidationResult.failure(
      error: '$field is required',
      errorCode: 'REQUIRED_FIELD',
      field: field,
      suggestions: ['Provide a value for $field'],
    );
  }

  /// Creates a validation result indicating an invalid format
  ///
  /// This factory constructor is specialized for format validation errors.
  factory ValidationResult.invalidFormat({
    required String field,
    required String expectedFormat,
    String? actualValue,
  }) {
    final error = actualValue != null
        ? '$field "$actualValue" does not match expected format: $expectedFormat'
        : '$field does not match expected format: $expectedFormat';

    return ValidationResult.failure(
      error: error,
      errorCode: 'INVALID_FORMAT',
      field: field,
      context: {
        'expectedFormat': expectedFormat,
        if (actualValue != null) 'actualValue': actualValue,
      },
      suggestions: ['Use format: $expectedFormat'],
    );
  }

  /// Checks if this result has any warnings
  bool get hasWarnings => warnings.isNotEmpty;

  /// Checks if this result has context information
  bool get hasContext => context != null && context!.isNotEmpty;

  /// Checks if this result has suggestions
  bool get hasSuggestions => suggestions.isNotEmpty;

  /// Checks if this is a critical error
  bool get isCritical => severity == ValidationSeverity.critical;

  /// Checks if this is a warning level issue
  bool get isWarning => severity == ValidationSeverity.warning;

  /// Gets a combined message including error and warnings
  String get fullMessage {
    final buffer = StringBuffer();

    if (error != null) {
      buffer.write(error);
    }

    if (hasWarnings) {
      if (buffer.isNotEmpty) buffer.write('\n');
      buffer.write('Warnings: ${warnings.join(', ')}');
    }

    if (hasSuggestions) {
      if (buffer.isNotEmpty) buffer.write('\n');
      buffer.write('Suggestions: ${suggestions.join(', ')}');
    }

    return buffer.toString();
  }

  /// Gets context value by key with optional default
  T? getContextValue<T>(String key, [T? defaultValue]) {
    if (context == null) return defaultValue;
    final value = context![key];
    return value is T ? value : defaultValue;
  }

  /// Combines this validation result with another
  ///
  /// Creates a new validation result that combines the information from
  /// both results. The combined result is valid only if both are valid.
  ///
  /// Example:
  /// ```dart
  /// ValidationResult combined = result1.combine(result2);
  /// ```
  ValidationResult combine(ValidationResult other) {
    final combinedValid = isValid && other.isValid;
    final combinedWarnings = [...warnings, ...other.warnings];
    final combinedSuggestions = [...suggestions, ...other.suggestions];

    String? combinedError;
    if (!combinedValid) {
      final errors = <String>[];
      if (error != null) errors.add(error!);
      if (other.error != null) errors.add(other.error!);
      combinedError = errors.join('; ');
    }

    Map<String, dynamic>? combinedContext;
    if (hasContext || other.hasContext) {
      combinedContext = <String, dynamic>{};
      if (context != null) combinedContext.addAll(context!);
      if (other.context != null) combinedContext.addAll(other.context!);
    }

    final maxSeverity = severity.index > other.severity.index
        ? severity
        : other.severity;

    return ValidationResult(
      isValid: combinedValid,
      error: combinedError,
      warnings: combinedWarnings,
      context: combinedContext,
      severity: maxSeverity,
      suggestions: combinedSuggestions,
    );
  }

  /// Creates a copy of this validation result with modified values
  ValidationResult copyWith({
    bool? isValid,
    String? error,
    List<String>? warnings,
    Map<String, dynamic>? context,
    String? errorCode,
    ValidationSeverity? severity,
    String? field,
    List<String>? suggestions,
  }) {
    return ValidationResult(
      isValid: isValid ?? this.isValid,
      error: error ?? this.error,
      warnings: warnings ?? this.warnings,
      context: context ?? this.context,
      errorCode: errorCode ?? this.errorCode,
      severity: severity ?? this.severity,
      field: field ?? this.field,
      suggestions: suggestions ?? this.suggestions,
    );
  }

  /// Converts this validation result to a Map for serialization
  Map<String, dynamic> toMap() {
    return {
      'isValid': isValid,
      if (error != null) 'error': error,
      if (warnings.isNotEmpty) 'warnings': warnings,
      if (context != null) 'context': context,
      if (errorCode != null) 'errorCode': errorCode,
      'severity': severity.name,
      if (field != null) 'field': field,
      if (suggestions.isNotEmpty) 'suggestions': suggestions,
    };
  }

  /// Creates a ValidationResult from a Map
  factory ValidationResult.fromMap(Map<String, dynamic> map) {
    return ValidationResult(
      isValid: map['isValid'] as bool,
      error: map['error'] as String?,
      warnings: List<String>.from(map['warnings'] ?? []),
      context: map['context'] as Map<String, dynamic>?,
      errorCode: map['errorCode'] as String?,
      severity: ValidationSeverity.values.firstWhere(
        (s) => s.name == map['severity'],
        orElse: () => ValidationSeverity.error,
      ),
      field: map['field'] as String?,
      suggestions: List<String>.from(map['suggestions'] ?? []),
    );
  }

  @override
  bool operator ==(covariant ValidationResult other) {
    if (identical(this, other)) return true;

    return other.isValid == isValid &&
        other.error == error &&
        _listEquals(other.warnings, warnings) &&
        _mapEquals(other.context, context) &&
        other.errorCode == errorCode &&
        other.severity == severity &&
        other.field == field &&
        _listEquals(other.suggestions, suggestions);
  }

  @override
  int get hashCode {
    return isValid.hashCode ^
        error.hashCode ^
        warnings.hashCode ^
        context.hashCode ^
        errorCode.hashCode ^
        severity.hashCode ^
        field.hashCode ^
        suggestions.hashCode;
  }

  @override
  String toString() {
    if (isValid) {
      if (hasWarnings) {
        return 'ValidationResult(valid: true, warnings: ${warnings.length})';
      } else {
        return 'ValidationResult(valid: true)';
      }
    } else {
      return 'ValidationResult(valid: false, error: $error)';
    }
  }

  /// Helper method to compare lists
  bool _listEquals<T>(List<T>? a, List<T>? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  /// Helper method to compare maps
  bool _mapEquals<K, V>(Map<K, V>? a, Map<K, V>? b) {
    if (a == null && b == null) return true;
    if (a == null || b == null) return false;
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || a[key] != b[key]) return false;
    }
    return true;
  }
}

/// Enumeration of validation severity levels
///
/// This enum defines the different severity levels that can be associated
/// with validation results, allowing for more nuanced handling of validation
/// outcomes.
enum ValidationSeverity {
  /// No issues found
  none,

  /// Information level - no action required
  info,

  /// Warning level - should be noted but doesn't prevent operation
  warning,

  /// Error level - prevents successful operation
  error,

  /// Critical level - serious error that may affect system stability
  critical,
}

/// Extension methods for ValidationSeverity
extension ValidationSeverityExtension on ValidationSeverity {
  /// Gets a human-readable name for the severity level
  String get displayName {
    switch (this) {
      case ValidationSeverity.none:
        return 'No Issues';
      case ValidationSeverity.info:
        return 'Information';
      case ValidationSeverity.warning:
        return 'Warning';
      case ValidationSeverity.error:
        return 'Error';
      case ValidationSeverity.critical:
        return 'Critical';
    }
  }

  /// Gets a color code associated with the severity level
  int get colorCode {
    switch (this) {
      case ValidationSeverity.none:
        return 0xFF4CAF50; // Green
      case ValidationSeverity.info:
        return 0xFF2196F3; // Blue
      case ValidationSeverity.warning:
        return 0xFFFF9800; // Orange
      case ValidationSeverity.error:
        return 0xFFF44336; // Red
      case ValidationSeverity.critical:
        return 0xFF9C27B0; // Purple
    }
  }

  /// Checks if this severity level indicates a problem
  bool get isError =>
      this == ValidationSeverity.error || this == ValidationSeverity.critical;

  /// Checks if this severity level is informational
  bool get isInformational =>
      this == ValidationSeverity.info || this == ValidationSeverity.none;
}
