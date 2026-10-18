import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import 'language_locale.dart';
import 'mm_calendar_theme_data.dart';
import 'mm_visual_style.dart';

/// Calendar settings shared by every widget below a [MyanmarCalendarScope].
@immutable
class MyanmarCalendarScopeData {
  /// Creates scope data. Most apps use [MyanmarCalendarScope] instead.
  const MyanmarCalendarScopeData({
    required this.client,
    required this.language,
    this.style = MmVisualStyle.automatic,
    this.theme,
    this.firstDayOfWeek = DateTime.sunday,
    this.translationRevision = 0,
  });

  /// The client every widget computes dates with: its config sets the time
  /// zone, Sasana year type and custom or disabled holidays, and it owns the
  /// bounded day cache.
  final MyanmarCalendarClient client;

  /// The language widgets show dates and names in.
  final Language language;

  /// The requested style; see [MyanmarCalendarScope.styleOf].
  final MmVisualStyle style;

  /// A theme that wins over the app theme's extension, if set.
  final MmCalendarThemeData? theme;

  /// The weekday calendars start on, as a `DateTime` weekday (1 is Monday,
  /// 7 is Sunday).
  final int firstDayOfWeek;

  /// `TranslationService.revision` when this data was built, so widgets
  /// rebuild after translations change.
  final int translationRevision;

  /// Everything about the day [date] falls on, in [language].
  CompleteDate day(DateTime date) => client.getCompleteDateFor(
    date.year,
    date.month,
    date.day,
    language: language,
  );

  /// [number] in [language]'s digits.
  String digits(int number) => language.digits(number);

  @override
  bool operator ==(Object other) =>
      other is MyanmarCalendarScopeData &&
      identical(other.client, client) &&
      other.language == language &&
      other.style == style &&
      other.theme == theme &&
      other.firstDayOfWeek == firstDayOfWeek &&
      other.translationRevision == translationRevision;

  @override
  int get hashCode => Object.hash(
    client,
    language,
    style,
    theme,
    firstDayOfWeek,
    translationRevision,
  );
}

/// Provides the calendar client, language, style and theme to every calendar
/// widget below it.
///
/// ```dart
/// MyanmarCalendarScope(
///   language: Language.myanmar,
///   config: CalendarConfig(customHolidays: [familyDays]),
///   child: MaterialApp(...),
/// )
/// ```
///
/// Without a scope, widgets use English, the default `CalendarConfig` and
/// [MmVisualStyle.automatic].
class MyanmarCalendarScope extends StatefulWidget {
  /// Creates a scope.
  ///
  /// Pass either [config] (the scope builds and owns a client) or [client]
  /// (yours, shared with code outside the widgets). When [language] is null
  /// it comes from the app's locale, then from the config's default language.
  const MyanmarCalendarScope({
    required this.child,
    super.key,
    this.language,
    this.config,
    this.client,
    this.cacheConfig = const CacheConfig(),
    this.style = MmVisualStyle.automatic,
    this.theme,
    this.firstDayOfWeek = DateTime.sunday,
  }) : assert(
         config == null || client == null,
         'Pass either config or client, not both.',
       ),
       assert(
         firstDayOfWeek >= DateTime.monday && firstDayOfWeek <= DateTime.sunday,
         'firstDayOfWeek is a DateTime weekday, 1 to 7.',
       );

  /// The widgets that use this scope.
  final Widget child;

  /// The language widgets use; `null` follows the app's locale.
  final Language? language;

  /// The calendar configuration for a client the scope creates.
  final CalendarConfig? config;

  /// A client to use as is.
  final MyanmarCalendarClient? client;

  /// Cache sizes for a client the scope creates.
  final CacheConfig cacheConfig;

  /// The style widgets draw with.
  final MmVisualStyle style;

  /// A theme that wins over the app theme's [MmCalendarThemeData] extension.
  final MmCalendarThemeData? theme;

  /// The weekday calendars start on (`DateTime.monday` to `DateTime.sunday`).
  final int firstDayOfWeek;

  static final MyanmarCalendarClient _defaultClient = MyanmarCalendarClient();

  /// The nearest scope's data, or the defaults when there is no scope.
  ///
  /// A scope without a language takes it from the locale at [context], so
  /// a scope above `MaterialApp` still follows the app's locale.
  static MyanmarCalendarScopeData of(BuildContext context) {
    final scope = context
        .dependOnInheritedWidgetOfExactType<_MyanmarCalendarInherited>();
    final client = scope?.client ?? _defaultClient;
    var language = scope?.language;
    if (language == null) {
      final locale = Localizations.maybeLocaleOf(context);
      language =
          (locale == null ? null : languageForLocale(locale)) ??
          (scope == null ? Language.english : client.defaultLanguage);
    }
    return MyanmarCalendarScopeData(
      client: client,
      language: language,
      style: scope?.style ?? MmVisualStyle.automatic,
      theme: scope?.theme,
      firstDayOfWeek: scope?.firstDayOfWeek ?? DateTime.sunday,
      translationRevision: TranslationService.revision,
    );
  }

  /// The concrete style to draw with: [override] if given, else the scope's
  /// style, resolved for the theme's platform (so `ThemeData.platform`
  /// overrides work in tests and previews).
  static MmVisualStyle styleOf(
    BuildContext context, [
    MmVisualStyle? override,
  ]) {
    final requested = override ?? of(context).style;
    return requested.resolve(platform: Theme.of(context).platform);
  }

  /// The calendar theme: the scope's, else the app theme's extension, else
  /// one built from the app's `ColorScheme`.
  static MmCalendarThemeData themeOf(BuildContext context) {
    final scoped = of(context).theme;
    if (scoped != null) return scoped;
    final theme = Theme.of(context);
    return theme.extension<MmCalendarThemeData>() ??
        (_fromScheme[theme.colorScheme] ??= MmCalendarThemeData.fromColorScheme(
          theme.colorScheme,
        ));
  }

  static final Expando<MmCalendarThemeData> _fromScheme = Expando();

  @override
  State<MyanmarCalendarScope> createState() => _MyanmarCalendarScopeState();
}

class _MyanmarCalendarScopeState extends State<MyanmarCalendarScope> {
  MyanmarCalendarClient? _owned;

  MyanmarCalendarClient get _client =>
      widget.client ??
      (_owned ??= MyanmarCalendarClient(
        config: widget.config,
        cacheConfig: widget.cacheConfig,
      ));

  @override
  void didUpdateWidget(MyanmarCalendarScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.config != oldWidget.config ||
        widget.cacheConfig != oldWidget.cacheConfig) {
      _owned = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _MyanmarCalendarInherited(
      client: _client,
      language: widget.language,
      style: widget.style,
      theme: widget.theme,
      firstDayOfWeek: widget.firstDayOfWeek,
      translationRevision: TranslationService.revision,
      child: widget.child,
    );
  }
}

class _MyanmarCalendarInherited extends InheritedWidget {
  const _MyanmarCalendarInherited({
    required this.client,
    required this.language,
    required this.style,
    required this.theme,
    required this.firstDayOfWeek,
    required this.translationRevision,
    required super.child,
  });

  final MyanmarCalendarClient client;
  final Language? language;
  final MmVisualStyle style;
  final MmCalendarThemeData? theme;
  final int firstDayOfWeek;
  final int translationRevision;

  @override
  bool updateShouldNotify(_MyanmarCalendarInherited oldWidget) =>
      !identical(client, oldWidget.client) ||
      language != oldWidget.language ||
      style != oldWidget.style ||
      theme != oldWidget.theme ||
      firstDayOfWeek != oldWidget.firstDayOfWeek ||
      translationRevision != oldWidget.translationRevision;
}
