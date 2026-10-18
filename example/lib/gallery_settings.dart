import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// What the gallery's settings sheet controls.
@immutable
class GallerySettings {
  const GallerySettings({
    this.style = MmVisualStyle.automatic,
    this.themeMode = ThemeMode.system,
    this.language = Language.english,
    this.platform,
    this.firstDayOfWeek = DateTime.sunday,
    this.seed = Colors.indigo,
  });

  final MmVisualStyle style;
  final ThemeMode themeMode;
  final Language language;

  /// Overrides the platform, so `automatic` can be tried as iOS on Android.
  final TargetPlatform? platform;
  final int firstDayOfWeek;
  final Color seed;

  GallerySettings copyWith({
    MmVisualStyle? style,
    ThemeMode? themeMode,
    Language? language,
    TargetPlatform? Function()? platform,
    int? firstDayOfWeek,
    Color? seed,
  }) => GallerySettings(
    style: style ?? this.style,
    themeMode: themeMode ?? this.themeMode,
    language: language ?? this.language,
    platform: platform == null ? this.platform : platform(),
    firstDayOfWeek: firstDayOfWeek ?? this.firstDayOfWeek,
    seed: seed ?? this.seed,
  );
}

/// The settings sheet's content.
class GallerySettingsPanel extends StatefulWidget {
  const GallerySettingsPanel({
    required this.settings,
    required this.onChanged,
    super.key,
  });

  final GallerySettings settings;
  final ValueChanged<GallerySettings> onChanged;

  @override
  State<GallerySettingsPanel> createState() => _GallerySettingsPanelState();
}

class _GallerySettingsPanelState extends State<GallerySettingsPanel> {
  late GallerySettings _s = widget.settings;

  void _set(GallerySettings s) {
    setState(() => _s = s);
    widget.onChanged(s);
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyanmarCalendarScope.themeOf(context);
    Widget label(String text) => Padding(
      padding: const EdgeInsets.only(top: 14, bottom: 6),
      child: Text(
        text,
        style: TextStyle(color: theme.muted, fontWeight: FontWeight.w600),
      ),
    );
    Widget choice<T extends Object>(
      Map<T, String> options,
      T selected,
      ValueChanged<T> onChanged,
    ) => FittedBox(
      // Every option stays visible on narrow phones.
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: MmSegmented<T>(
        segments: options,
        selected: selected,
        onChanged: onChanged,
      ),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          label('Style'),
          choice(
            const {
              MmVisualStyle.automatic: 'Automatic',
              MmVisualStyle.material: 'Material',
              MmVisualStyle.cupertino: 'Cupertino',
              MmVisualStyle.glass: 'Glass',
            },
            _s.style,
            (v) => _set(_s.copyWith(style: v)),
          ),
          label('Theme'),
          choice(
            const {
              ThemeMode.system: 'System',
              ThemeMode.light: 'Light',
              ThemeMode.dark: 'Dark',
            },
            _s.themeMode,
            (v) => _set(_s.copyWith(themeMode: v)),
          ),
          label('Language'),
          choice(
            const {
              Language.english: 'English',
              Language.myanmar: 'မြန်မာ',
              Language.shan: 'Shan',
              Language.mon: 'Mon',
              Language.karen: 'Karen',
            },
            _s.language,
            (v) => _set(_s.copyWith(language: v)),
          ),
          label('Platform'),
          choice(
            const {'device': 'Device', 'android': 'Android', 'ios': 'iOS'},
            switch (_s.platform) {
              TargetPlatform.android => 'android',
              TargetPlatform.iOS => 'ios',
              _ => 'device',
            },
            (v) => _set(
              _s.copyWith(
                platform: () => switch (v) {
                  'android' => TargetPlatform.android,
                  'ios' => TargetPlatform.iOS,
                  _ => null,
                },
              ),
            ),
          ),
          label('Week starts on'),
          choice(
            const {
              DateTime.sunday: 'Sunday',
              DateTime.monday: 'Monday',
              DateTime.saturday: 'Saturday',
            },
            _s.firstDayOfWeek,
            (v) => _set(_s.copyWith(firstDayOfWeek: v)),
          ),
          label('Colour'),
          Wrap(
            spacing: 10,
            children: [
              for (final c in const [
                Colors.indigo,
                Colors.teal,
                Colors.deepOrange,
                Colors.pink,
                Colors.brown,
              ])
                Semantics(
                  button: true,
                  selected: _s.seed == c,
                  label: 'Colour',
                  child: GestureDetector(
                    onTap: () => _set(_s.copyWith(seed: c)),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: c,
                      child: _s.seed == c
                          ? const Icon(
                              Icons.check,
                              size: 16,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
