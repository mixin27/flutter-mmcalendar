import 'dart:io';

import 'package:flutter/services.dart';

bool _loaded = false;

/// Loads Roboto and the Material icon font from the Flutter SDK, so goldens
/// show real text instead of the test font's boxes.
///
/// Roboto is also registered under the Cupertino system font names, so the
/// Cupertino style draws text too. Goldens are therefore not pixel-true to
/// iOS typography; they check layout, colour and shape.
Future<void> loadTestFonts() async {
  if (_loaded) return;
  _loaded = true;
  final fonts = _materialFontsDir();
  Future<ByteData> read(String name) async =>
      ByteData.sublistView(await File('${fonts.path}/$name').readAsBytes());

  final roboto = ['Roboto-Regular.ttf', 'Roboto-Medium.ttf', 'Roboto-Bold.ttf'];
  for (final family in [
    'Roboto',
    'CupertinoSystemText',
    'CupertinoSystemDisplay',
    '.SF Pro Text',
    '.SF Pro Display',
    '.SF UI Text',
    '.SF UI Display',
  ]) {
    final loader = FontLoader(family);
    for (final file in roboto) {
      loader.addFont(read(file));
    }
    await loader.load();
  }
  await (FontLoader(
    'MaterialIcons',
  )..addFont(read('MaterialIcons-Regular.otf'))).load();
}

/// `<flutter>/bin/cache/artifacts/material_fonts`, found from the test
/// runner's own path.
Directory _materialFontsDir() {
  var dir = File(Platform.resolvedExecutable).parent;
  while (dir.path != dir.parent.path) {
    final candidate = Directory('${dir.path}/material_fonts');
    if (candidate.existsSync()) return candidate;
    final nested = Directory('${dir.path}/artifacts/material_fonts');
    if (nested.existsSync()) return nested;
    dir = dir.parent;
  }
  throw StateError('Flutter material_fonts not found; run flutter precache');
}
