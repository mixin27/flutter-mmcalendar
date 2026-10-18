import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _app(MmVisualStyle style, Widget child) => MyanmarCalendarScope(
  style: style,
  child: MaterialApp(
    home: Scaffold(body: Center(child: child)),
  ),
);

void main() {
  group('each style builds its own controls', () {
    testWidgets('material', (tester) async {
      await tester.pumpWidget(
        _app(
          MmVisualStyle.material,
          Column(
            children: [
              MmButton(label: 'OK', onPressed: () {}),
              MmIconButton(icon: Icons.add, tooltip: 'Add', onPressed: () {}),
              MmSegmented(
                segments: const {1: 'A', 2: 'B'},
                selected: 1,
                onChanged: (_) {},
              ),
            ],
          ),
        ),
      );
      expect(find.byType(FilledButton), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byType(SegmentedButton<int>), findsOneWidget);
      expect(find.byType(MmGlass), findsNothing);
    });

    testWidgets('cupertino', (tester) async {
      await tester.pumpWidget(
        _app(
          MmVisualStyle.cupertino,
          Column(
            children: [
              MmButton(label: 'OK', onPressed: () {}),
              MmSegmented(
                segments: const {1: 'A', 2: 'B'},
                selected: 1,
                onChanged: (_) {},
              ),
              const MmListGroup(children: [MmListRow(title: Text('Row'))]),
            ],
          ),
        ),
      );
      expect(find.byType(CupertinoButton), findsOneWidget);
      expect(
        find.byType(CupertinoSlidingSegmentedControl<int>),
        findsOneWidget,
      );
      expect(find.byType(CupertinoListTile), findsOneWidget);
    });

    testWidgets('glass', (tester) async {
      await tester.pumpWidget(
        _app(
          MmVisualStyle.glass,
          Column(
            children: [
              MmButton(label: 'OK', onPressed: () {}),
              const MmSurface(child: Text('Card')),
            ],
          ),
        ),
      );
      expect(find.byType(MmGlass), findsNWidgets(2));
      expect(find.byType(FilledButton), findsNothing);
    });
  });

  testWidgets('glass falls back to a blur where shaders are unsupported', (
    tester,
  ) async {
    expect(ui.ImageFilter.isShaderFilterSupported, isFalse);
    await tester.pumpWidget(
      _app(MmVisualStyle.glass, const MmGlass(child: Text('Glass'))),
    );
    expect(MmGlass.usesShader, isFalse);
    expect(find.byType(BackdropFilter), findsOneWidget);
  });

  testWidgets('glass turns opaque for high contrast', (tester) async {
    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(highContrast: true),
        child: _app(MmVisualStyle.glass, const MmGlass(child: Text('Glass'))),
      ),
    );
    expect(find.byType(BackdropFilter), findsNothing);
    expect(find.text('Glass'), findsOneWidget);
  });

  testWidgets('glass controls respond to taps and the keyboard', (
    tester,
  ) async {
    var taps = 0;
    String? picked;
    await tester.pumpWidget(
      _app(
        MmVisualStyle.glass,
        Column(
          children: [
            MmButton(label: 'Today', onPressed: () => taps++),
            MmSegmented(
              segments: const {'m': 'Month', 'w': 'Week'},
              selected: 'm',
              onChanged: (v) => picked = v,
            ),
          ],
        ),
      ),
    );
    await tester.tap(find.text('Today'));
    await tester.tap(find.text('Week'));
    expect(taps, 1);
    expect(picked, 'w');

    // Tab to the button and press Enter.
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    expect(taps, 2);
  });

  testWidgets('glass icon button reads its tooltip as its label', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      _app(
        MmVisualStyle.glass,
        MmIconButton(
          icon: Icons.chevron_left,
          tooltip: 'Previous month',
          onPressed: () {},
        ),
      ),
    );
    expect(
      tester.getSemantics(find.byType(MmPressable)),
      matchesSemantics(
        label: 'Previous month',
        isButton: true,
        hasEnabledState: true,
        isEnabled: true,
        hasTapAction: true,
      ),
    );
    semantics.dispose();
  });

  for (final style in [
    MmVisualStyle.material,
    MmVisualStyle.cupertino,
    MmVisualStyle.glass,
  ]) {
    testWidgets('sheet keeps the scope (${style.name})', (tester) async {
      Language? seen;
      await tester.pumpWidget(
        MyanmarCalendarScope(
          style: style,
          language: Language.myanmar,
          child: MaterialApp(
            home: Builder(
              builder: (context) => Center(
                child: TextButton(
                  onPressed: () => showMmSheet<void>(
                    context: context,
                    builder: (ctx) {
                      seen = MyanmarCalendarScope.of(ctx).language;
                      return const SizedBox(height: 200, child: Text('Sheet'));
                    },
                  ),
                  child: const Text('Open'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      expect(find.text('Sheet'), findsOneWidget);
      expect(seen, Language.myanmar);
      expect(
        find.byType(MmGlass),
        style == MmVisualStyle.glass ? findsOneWidget : findsNothing,
      );
    });
  }

  testWidgets('popover opens below its anchor, or above near the bottom', (
    tester,
  ) async {
    Future<void> open(Alignment at) async {
      await tester.pumpWidget(
        _app(
          MmVisualStyle.material,
          Align(
            alignment: at,
            child: Builder(
              builder: (context) => TextButton(
                onPressed: () => showMmPopover<void>(
                  context: context,
                  builder: (_) =>
                      const SizedBox(height: 120, child: Text('Pop')),
                ),
                child: const Text('Anchor'),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Anchor'));
      await tester.pumpAndSettle();
    }

    await open(Alignment.topCenter);
    final anchor = tester.getRect(find.byType(TextButton));
    expect(tester.getTopLeft(find.text('Pop')).dy, greaterThan(anchor.bottom));
    await tester.tapAt(const Offset(5, 5));
    await tester.pumpAndSettle();
    expect(find.text('Pop'), findsNothing);

    await open(Alignment.bottomCenter);
    final low = tester.getRect(find.byType(TextButton));
    expect(tester.getBottomLeft(find.text('Pop')).dy, lessThan(low.top));
  });
}
