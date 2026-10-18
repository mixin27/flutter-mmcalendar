import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

import 'gallery_settings.dart';
import 'pages/calendar_page.dart';
import 'pages/day_page.dart';
import 'pages/pickers_page.dart';
import 'pages/tools_page.dart';
import 'pages/views_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Load the glass shader before the first frame, so glass doesn't start on
  // the fallback.
  MmGlass.precache();
  runApp(const GalleryApp());
}

/// The flutter_mmcalendar gallery: every widget, in every style.
class GalleryApp extends StatefulWidget {
  /// Creates the gallery.
  const GalleryApp({super.key, this.initialSettings = const GallerySettings()});

  /// The settings to start with; tests pass their own.
  final GallerySettings initialSettings;

  @override
  State<GalleryApp> createState() => _GalleryAppState();
}

class _GalleryAppState extends State<GalleryApp> {
  late GallerySettings _settings = widget.initialSettings;

  @override
  Widget build(BuildContext context) {
    ThemeData theme(Brightness b) => ThemeData(
      colorSchemeSeed: _settings.seed,
      brightness: b,
      platform: _settings.platform,
    );
    return MyanmarCalendarScope(
      style: _settings.style,
      language: _settings.language,
      firstDayOfWeek: _settings.firstDayOfWeek,
      child: MaterialApp(
        title: 'flutter_mmcalendar',
        debugShowCheckedModeBanner: false,
        theme: theme(Brightness.light),
        darkTheme: theme(Brightness.dark),
        themeMode: _settings.themeMode,
        home: GalleryHome(
          settings: _settings,
          onSettingsChanged: (s) => setState(() => _settings = s),
        ),
      ),
    );
  }
}

/// A gallery section.
class GallerySection {
  const GallerySection(this.label, this.icon, this.builder);

  final String label;
  final IconData icon;
  final WidgetBuilder builder;
}

final List<GallerySection> gallerySections = [
  GallerySection('Calendar', Icons.calendar_month, (_) => const CalendarPage()),
  GallerySection('Views', Icons.view_agenda_outlined, (_) => const ViewsPage()),
  GallerySection('Pickers', Icons.event_available, (_) => const PickersPage()),
  GallerySection('Day', Icons.wb_twilight, (_) => const DayPage()),
  GallerySection('Tools', Icons.handyman_outlined, (_) => const ToolsPage()),
];

/// The gallery's shell: a bottom bar on phones, a rail on tablets and
/// desktops.
class GalleryHome extends StatefulWidget {
  const GalleryHome({
    required this.settings,
    required this.onSettingsChanged,
    super.key,
  });

  final GallerySettings settings;
  final ValueChanged<GallerySettings> onSettingsChanged;

  @override
  State<GalleryHome> createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final style = MyanmarCalendarScope.styleOf(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final wide = MediaQuery.sizeOf(context).width >= 700;
    final section = gallerySections[_index];

    final settingsButton = MmIconButton(
      icon: Icons.tune,
      tooltip: 'Gallery settings',
      onPressed: () => showMmSheet<void>(
        context: context,
        builder: (_) => GallerySettingsPanel(
          settings: widget.settings,
          onChanged: widget.onSettingsChanged,
        ),
      ),
    );

    final body = Stack(
      fit: StackFit.expand,
      children: [
        // Glass needs something behind it.
        if (style == MmVisualStyle.glass)
          const GalleryWallpaper()
        else
          ColoredBox(
            color: Color.alphaBlend(
              theme.accent.withValues(alpha: 0.04),
              Theme.of(context).colorScheme.surface,
            ),
          ),
        SafeArea(
          bottom: false,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 12, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Semantics(
                        header: true,
                        child: Text(
                          section.label,
                          style: TextStyle(
                            color: theme.ink,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    settingsButton,
                  ],
                ),
              ),
              Expanded(
                child: KeyedSubtree(
                  key: ValueKey(_index),
                  child: section.builder(context),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    if (wide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: _index,
              labelType: NavigationRailLabelType.all,
              onDestinationSelected: (i) => setState(() => _index = i),
              destinations: [
                for (final s in gallerySections)
                  NavigationRailDestination(
                    icon: Icon(s.icon),
                    label: Text(s.label),
                  ),
              ],
            ),
            Expanded(child: body),
          ],
        ),
      );
    }

    if (style == MmVisualStyle.material) {
      return Scaffold(
        body: body,
        bottomNavigationBar: NavigationBar(
          selectedIndex: _index,
          onDestinationSelected: (i) => setState(() => _index = i),
          destinations: [
            for (final s in gallerySections)
              NavigationDestination(icon: Icon(s.icon), label: s.label),
          ],
        ),
      );
    }

    // Cupertino and Glass: a floating tab bar over the content.
    return Scaffold(
      extendBody: true,
      body: body,
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(12, 0, 12, 10),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: MmSegmented<int>(
            segments: {
              for (var i = 0; i < gallerySections.length; i++)
                i: gallerySections[i].label,
            },
            selected: _index,
            glassThickness: MmGlassThickness.frosted,
            onChanged: (i) => setState(() => _index = i),
          ),
        ),
      ),
    );
  }
}

/// A gradient with a moon and a pagoda, so glass has something to bend.
class GalleryWallpaper extends StatelessWidget {
  const GalleryWallpaper({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return CustomPaint(painter: _WallpaperPainter(dark: dark));
  }
}

class _WallpaperPainter extends CustomPainter {
  _WallpaperPainter({required this.dark});

  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: dark
              ? const [Color(0xFF2B3480), Color(0xFF0B0C22), Color(0xFF9A4E1C)]
              : const [Color(0xFF6F7FE0), Color(0xFFB59BE8), Color(0xFFF0A257)],
        ).createShader(rect),
    );
    canvas.drawCircle(
      Offset(size.width * 0.78, size.height * 0.14),
      size.shortestSide * 0.13,
      Paint()..color = const Color(0xFFFFD45C),
    );
    // A stepped pagoda silhouette.
    final base = size.height;
    final cx = size.width * 0.28;
    final unit = size.shortestSide * 0.05;
    final pagoda = Path()..moveTo(cx - unit * 6, base);
    for (var i = 0; i < 5; i++) {
      final w = unit * (6 - i);
      final y = base - unit * (1.6 * i + 1.6);
      pagoda
        ..lineTo(cx - w, y)
        ..lineTo(cx - w * 0.75, y);
    }
    pagoda.lineTo(cx, base - unit * 12);
    for (var i = 4; i >= 0; i--) {
      final w = unit * (6 - i);
      final y = base - unit * (1.6 * i + 1.6);
      pagoda
        ..lineTo(cx + w * 0.75, y)
        ..lineTo(cx + w, y);
    }
    pagoda
      ..lineTo(cx + unit * 6, base)
      ..close();
    canvas.drawPath(
      pagoda,
      Paint()
        ..color = (dark ? const Color(0xFF05061A) : const Color(0xFF2C2F6B))
            .withValues(alpha: 0.8),
    );
  }

  @override
  bool shouldRepaint(_WallpaperPainter old) => old.dark != dark;
}
