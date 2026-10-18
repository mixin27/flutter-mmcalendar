import 'dart:io';

/// The iOS or macOS major version, or `null` on other platforms.
///
/// `Platform.operatingSystemVersion` reads like "Version 26.0 (Build 23A341)"
/// on both.
final int? appleOsMajorVersion = () {
  if (!Platform.isIOS && !Platform.isMacOS) return null;
  return parseAppleMajorVersion(Platform.operatingSystemVersion);
}();

/// The first number in [version], or `null` if it has none.
int? parseAppleMajorVersion(String version) {
  final match = RegExp(r'(\d+)').firstMatch(version);
  return match == null ? null : int.tryParse(match.group(1)!);
}
