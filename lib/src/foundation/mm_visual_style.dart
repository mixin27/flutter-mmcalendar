import 'package:flutter/foundation.dart';

import 'apple_os_version.dart';

/// The look the calendar widgets draw with.
enum MmVisualStyle {
  /// Cupertino on iOS and macOS, Material elsewhere. On iOS and macOS 26 and
  /// later it resolves to [glass].
  automatic,

  /// Material 3: tonal surfaces from the app's `ColorScheme`.
  material,

  /// Cupertino: grouped lists, hairlines and sheets with a grabber.
  cupertino,

  /// Liquid Glass: translucent surfaces that refract what is behind them.
  glass;

  /// The first Apple OS major version on which [automatic] picks [glass].
  static const int glassFromAppleVersion = 26;

  /// The concrete style this resolves to; never [automatic].
  ///
  /// [platform] and [appleMajorVersion] default to the running device; pass
  /// them to resolve for another platform, as tests and previews do.
  MmVisualStyle resolve({TargetPlatform? platform, int? appleMajorVersion}) {
    if (this != automatic) return this;
    final target = platform ?? defaultTargetPlatform;
    final isApple =
        target == TargetPlatform.iOS || target == TargetPlatform.macOS;
    if (!isApple) return material;
    // On web the OS version can't be read, so web never turns glass on by
    // itself.
    final version = appleMajorVersion ?? (kIsWeb ? null : appleOsMajorVersion);
    if (version != null && version >= glassFromAppleVersion) return glass;
    return cupertino;
  }

  /// Corner radius for cards and sheets in this style.
  double get cardRadius => switch (this) {
    material || automatic => 18,
    cupertino => 12,
    glass => 28,
  };
}
