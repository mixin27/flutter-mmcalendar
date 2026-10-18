import 'dart:ui' show lerpDouble;

import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

/// Colours, type and shape for the calendar widgets.
///
/// Add it to `ThemeData.extensions`, or pass it to `MyanmarCalendarScope`.
/// Without either, widgets use [MmCalendarThemeData.fromColorScheme] with the
/// app's `ColorScheme`, so light and dark mode follow the app.
@immutable
class MmCalendarThemeData extends ThemeExtension<MmCalendarThemeData> {
  /// Creates a theme from explicit values.
  const MmCalendarThemeData({
    required this.brightness,
    required this.accent,
    required this.onAccent,
    required this.accentContainer,
    required this.surface,
    required this.surfaceVariant,
    required this.ink,
    required this.muted,
    required this.outline,
    required this.outside,
    required this.publicHoliday,
    required this.religiousHoliday,
    required this.culturalHoliday,
    required this.anniversary,
    required this.otherHoliday,
    required this.sabbath,
    required this.moon,
    required this.moonShadow,
    this.myanmarFontFamilyFallback = defaultMyanmarFonts,
    this.myanmarLineHeight = 1.6,
    this.cardRadius,
    this.cellRadius = 12,
  });

  /// Builds a theme from the app's [scheme]. Holiday, Sabbath and moon colours
  /// are fixed per brightness so they mean the same thing in every app.
  factory MmCalendarThemeData.fromColorScheme(ColorScheme scheme) {
    final dark = scheme.brightness == Brightness.dark;
    return MmCalendarThemeData(
      brightness: scheme.brightness,
      accent: scheme.primary,
      onAccent: scheme.onPrimary,
      accentContainer: scheme.primaryContainer,
      // White cards on a grey page in light mode; lifted cards in dark.
      surface: dark ? scheme.surfaceContainer : scheme.surfaceContainerLowest,
      surfaceVariant: scheme.surfaceContainerHighest,
      ink: scheme.onSurface,
      muted: scheme.onSurfaceVariant,
      outline: scheme.outlineVariant,
      outside: scheme.onSurface.withValues(alpha: 0.38),
      publicHoliday: dark ? const Color(0xFFFF6B6B) : const Color(0xFFD6343A),
      religiousHoliday: dark
          ? const Color(0xFFF2B256)
          : const Color(0xFFBE720C),
      culturalHoliday: dark ? const Color(0xFF4FD1BD) : const Color(0xFF0F8A7A),
      anniversary: dark ? const Color(0xFFB3A6F0) : const Color(0xFF7562B8),
      otherHoliday: dark ? const Color(0xFF9DAAC4) : const Color(0xFF5B6B86),
      sabbath: dark ? const Color(0xFFFFB84D) : const Color(0xFFA86400),
      moon: dark ? const Color(0xFFFFD45C) : const Color(0xFFE2A90A),
      moonShadow: dark ? const Color(0xFF3A3F50) : const Color(0xFFD9DCE6),
    );
  }

  /// Builds a theme from a [seed] colour, as `ColorScheme.fromSeed` does.
  factory MmCalendarThemeData.fromSeed(
    Color seed, {
    Brightness brightness = Brightness.light,
  }) => MmCalendarThemeData.fromColorScheme(
    ColorScheme.fromSeed(seedColor: seed, brightness: brightness),
  );

  /// Fonts tried for Myanmar script when the app's font lacks it.
  static const List<String> defaultMyanmarFonts = [
    'Noto Sans Myanmar',
    'Myanmar Sangam MN',
    'Padauk',
  ];

  /// Whether this is a light or dark theme.
  final Brightness brightness;

  /// Selection, today and controls.
  final Color accent;

  /// Text and icons on [accent].
  final Color onAccent;

  /// Range middles and tonal buttons.
  final Color accentContainer;

  /// Cards and calendar backgrounds.
  final Color surface;

  /// Inset fields, wells and segmented-control tracks.
  final Color surfaceVariant;

  /// Primary text.
  final Color ink;

  /// Secondary text: Myanmar days under Western days, captions.
  final Color muted;

  /// Hairlines and dividers.
  final Color outline;

  /// Days from the previous or next month.
  final Color outside;

  /// Public holidays.
  final Color publicHoliday;

  /// Religious holidays.
  final Color religiousHoliday;

  /// Cultural holidays.
  final Color culturalHoliday;

  /// Myanmar and other anniversary days.
  final Color anniversary;

  /// Holidays of any other type.
  final Color otherHoliday;

  /// Sabbath and Sabbath Eve.
  final Color sabbath;

  /// The lit part of the moon.
  final Color moon;

  /// The unlit part of the moon.
  final Color moonShadow;

  /// Fonts tried for Myanmar script, in order.
  final List<String> myanmarFontFamilyFallback;

  /// Line height for Myanmar text, which needs room for stacked marks.
  final double myanmarLineHeight;

  /// Corner radius for cards and sheets; `null` uses the visual style's.
  final double? cardRadius;

  /// Corner radius for day cells.
  final double cellRadius;

  /// The colour for holidays of [type].
  Color holidayColor(HolidayType type) => switch (type) {
    HolidayType.public => publicHoliday,
    HolidayType.religious => religiousHoliday,
    HolidayType.cultural => culturalHoliday,
    HolidayType.myanmarAnniversary ||
    HolidayType.otherAnniversary => anniversary,
    HolidayType.other => otherHoliday,
  };

  /// [style] with the Myanmar font fallback and, for Myanmar-script
  /// languages, the taller line height.
  TextStyle textStyle(TextStyle style, Language language) {
    final myanmarScript = language != Language.english;
    return style.copyWith(
      fontFamilyFallback: [
        ...?style.fontFamilyFallback,
        ...myanmarFontFamilyFallback,
      ],
      height: myanmarScript ? myanmarLineHeight : style.height,
    );
  }

  @override
  MmCalendarThemeData copyWith({
    Brightness? brightness,
    Color? accent,
    Color? onAccent,
    Color? accentContainer,
    Color? surface,
    Color? surfaceVariant,
    Color? ink,
    Color? muted,
    Color? outline,
    Color? outside,
    Color? publicHoliday,
    Color? religiousHoliday,
    Color? culturalHoliday,
    Color? anniversary,
    Color? otherHoliday,
    Color? sabbath,
    Color? moon,
    Color? moonShadow,
    List<String>? myanmarFontFamilyFallback,
    double? myanmarLineHeight,
    double? cardRadius,
    double? cellRadius,
  }) {
    return MmCalendarThemeData(
      brightness: brightness ?? this.brightness,
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      accentContainer: accentContainer ?? this.accentContainer,
      surface: surface ?? this.surface,
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      ink: ink ?? this.ink,
      muted: muted ?? this.muted,
      outline: outline ?? this.outline,
      outside: outside ?? this.outside,
      publicHoliday: publicHoliday ?? this.publicHoliday,
      religiousHoliday: religiousHoliday ?? this.religiousHoliday,
      culturalHoliday: culturalHoliday ?? this.culturalHoliday,
      anniversary: anniversary ?? this.anniversary,
      otherHoliday: otherHoliday ?? this.otherHoliday,
      sabbath: sabbath ?? this.sabbath,
      moon: moon ?? this.moon,
      moonShadow: moonShadow ?? this.moonShadow,
      myanmarFontFamilyFallback:
          myanmarFontFamilyFallback ?? this.myanmarFontFamilyFallback,
      myanmarLineHeight: myanmarLineHeight ?? this.myanmarLineHeight,
      cardRadius: cardRadius ?? this.cardRadius,
      cellRadius: cellRadius ?? this.cellRadius,
    );
  }

  @override
  MmCalendarThemeData lerp(MmCalendarThemeData? other, double t) {
    if (other == null) return this;
    Color c(Color a, Color b) => Color.lerp(a, b, t)!;
    return MmCalendarThemeData(
      brightness: t < 0.5 ? brightness : other.brightness,
      accent: c(accent, other.accent),
      onAccent: c(onAccent, other.onAccent),
      accentContainer: c(accentContainer, other.accentContainer),
      surface: c(surface, other.surface),
      surfaceVariant: c(surfaceVariant, other.surfaceVariant),
      ink: c(ink, other.ink),
      muted: c(muted, other.muted),
      outline: c(outline, other.outline),
      outside: c(outside, other.outside),
      publicHoliday: c(publicHoliday, other.publicHoliday),
      religiousHoliday: c(religiousHoliday, other.religiousHoliday),
      culturalHoliday: c(culturalHoliday, other.culturalHoliday),
      anniversary: c(anniversary, other.anniversary),
      otherHoliday: c(otherHoliday, other.otherHoliday),
      sabbath: c(sabbath, other.sabbath),
      moon: c(moon, other.moon),
      moonShadow: c(moonShadow, other.moonShadow),
      myanmarFontFamilyFallback: t < 0.5
          ? myanmarFontFamilyFallback
          : other.myanmarFontFamilyFallback,
      myanmarLineHeight: lerpDouble(
        myanmarLineHeight,
        other.myanmarLineHeight,
        t,
      )!,
      cardRadius: lerpDouble(cardRadius, other.cardRadius, t),
      cellRadius: lerpDouble(cellRadius, other.cellRadius, t)!,
    );
  }

  List<Object?> get _props => [
    brightness,
    accent,
    onAccent,
    accentContainer,
    surface,
    surfaceVariant,
    ink,
    muted,
    outline,
    outside,
    publicHoliday,
    religiousHoliday,
    culturalHoliday,
    anniversary,
    otherHoliday,
    sabbath,
    moon,
    moonShadow,
    Object.hashAll(myanmarFontFamilyFallback),
    myanmarLineHeight,
    cardRadius,
    cellRadius,
  ];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MmCalendarThemeData) return false;
    return listEquals(_props, other._props) &&
        listEquals(myanmarFontFamilyFallback, other.myanmarFontFamilyFallback);
  }

  @override
  int get hashCode => Object.hashAll(_props);
}
