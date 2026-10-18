import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_mmcalendar_example/gallery_settings.dart';
import 'package:flutter_mmcalendar_example/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  for (final (style, size) in [
    (MmVisualStyle.material, const Size(400, 860)),
    (MmVisualStyle.glass, const Size(400, 860)),
    (MmVisualStyle.cupertino, const Size(900, 800)),
    (MmVisualStyle.material, const Size(1400, 900)),
  ]) {
    testWidgets('every section builds (${style.name}, ${size.width})', (
      tester,
    ) async {
      tester.view
        ..physicalSize = size
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(
        GalleryApp(initialSettings: GallerySettings(style: style)),
      );
      await tester.pumpAndSettle();
      for (final section in gallerySections) {
        await tester.tap(find.text(section.label).last);
        await tester.pumpAndSettle();
        expect(tester.takeException(), isNull, reason: section.label);
      }
    });
  }

  testWidgets('settings change the style and language', (tester) async {
    tester.view
      ..physicalSize = const Size(400, 860)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const GalleryApp());
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Gallery settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Glass'));
    await tester.tap(find.text('မြန်မာ'));
    await tester.pumpAndSettle();
    Navigator.of(tester.element(find.byType(GallerySettingsPanel))).pop();
    await tester.pumpAndSettle();
    expect(find.byType(GalleryWallpaper), findsOneWidget);
    expect(find.byType(MmGlass), findsWidgets);
  });
}
