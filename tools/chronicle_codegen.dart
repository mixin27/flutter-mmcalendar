// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';

// Standalone codegen; avoid importing Flutter/package libs to run with plain Dart.

void main(List<String> args) async {
  final argMap = _parseArgs(args);
  final input = argMap['--input'];
  final outDir = argMap['--out'] ?? 'lib/src/utils';
  if (input == null) {
    stderr.writeln(
      'Usage: dart run tool/chronicle_codegen.dart --input chronicles.json [--out lib/src/utils]',
    );
    exit(1);
  }

  final jsonStr = await File(input).readAsString();
  final decoded = json.decode(jsonStr);
  // Support two schemas:
  // 1) Map-based with keys: dynasties, rulers, entries (original plan)
  // 2) List-based array of objects (your current misc/lang/chronicle.json),
  //    each containing fields like "Julian Day Number" and "description".
  final Map<String, dynamic> data;
  if (decoded is List) {
    // Convert array into entries list for emission.
    data = {
      'entries': decoded,
      'dynasties': const <dynamic>[],
      'rulers': const <dynamic>[],
    };
  } else {
    data = decoded as Map<String, dynamic>;
  }

  // Expected schema:
  // {
  //   "dynasties": [{ "id": "...", "name": {"en":"...","my":"..."}, "start": {"my": {"y":1385,"m":1,"d":1}}, "end": {...} }],
  //   "rulers": [{ "id":"...", "dynastyId":"...", "name":{"en":"...","my":"..."}, "start": {...}, "end": {...} }],
  //   "entries": [{
  //     "id":"...",
  //     "start": {"my": {"y":1385,"m":1,"d":1}},
  //     "end": {"my": {"y":1385,"m":2,"d":15}}, // optional
  //     "title":{"en":"...","my":"..."},
  //     "summary":{"en":"...","my":"..."},
  //     "tags":["..."],
  //     "dynastyId":"...", "rulerId":"..."
  //   }]
  // }
  //
  // If your JSON already contains JDN (e.g., startJdn/endJdn), this script will use those directly and skip conversion.

  double _toJdn(Map<String, dynamic> dateNode) {
    if (dateNode.containsKey('jdn')) return (dateNode['jdn'] as num).toDouble();
    // Minimal support: if other date formats appear, require explicit jdn in JSON.
    throw ArgumentError('Unsupported date format: $dateNode');
  }

  String _emitMapString(Map<String, dynamic> m) {
    final entries = m.entries
        .map((e) {
          final k = e.key.replaceAll("'", r"\'");
          final v = (e.value as String).replaceAll("'", r"\'");
          return "'$k': '$v'";
        })
        .join(', ');
    return '{$entries}';
  }

  String _emitDynasties() {
    final list = (data['dynasties'] as List? ?? const []);
    final buf = StringBuffer()
      ..writeln("import '../models/chronicle_models.dart';")
      ..writeln()
      ..writeln('const List<DynastyData> kDynasties = [');
    for (final raw in list) {
      final d = raw as Map<String, dynamic>;
      final id = d['id'] as String;
      final name = _emitMapString(Map<String, dynamic>.from(d['name'] as Map));
      final startJdn = _toJdn(Map<String, dynamic>.from(d['start'] as Map));
      final endJdn = _toJdn(Map<String, dynamic>.from(d['end'] as Map));
      buf.writeln(
        '  DynastyData(id: \'$id\', name: $name, startJdn: $startJdn, endJdn: $endJdn),',
      );
    }
    buf.writeln('];');
    return buf.toString();
  }

  String _emitEntries() {
    final list = (data['entries'] as List? ?? const []);
    final buf = StringBuffer()
      ..writeln("import '../models/chronicle_models.dart';")
      ..writeln()
      ..writeln('const List<ChronicleEntryData> kChronicleEntries = [');
    for (final raw in list) {
      final e = raw as Map<String, dynamic>;

      // Handle list-style schema (e.g., from misc/lang/chronicle.json)
      if (e.containsKey('Julian Day Number')) {
        final jdnInt = (e['Julian Day Number'] as num).toInt();
        final jdn =
            jdnInt.toDouble() + 0.5; // normalize to noon-based JDN convention
        final descRaw = (e['description'] ?? '').toString();
        final safeDesc = descRaw.replaceAll("'", r"\'");
        final id = 'jdn_$jdnInt';
        // Build bilingual title map using the same description for now
        final title = "{'en': '$safeDesc', 'my': '$safeDesc'}";

        buf.writeln('  ChronicleEntryData(');
        buf.writeln("    id: '$id',");
        buf.writeln('    startJdn: $jdn,');
        buf.writeln('    title: $title,');
        // tags/dynasty/ruler unavailable in this schema; omit.
        buf.writeln('  ),');
        continue;
      }

      // Handle map-style schema
      final id = e['id'] as String;
      final title = _emitMapString(
        Map<String, dynamic>.from(e['title'] as Map),
      );
      final summary = e['summary'] == null
          ? null
          : _emitMapString(Map<String, dynamic>.from(e['summary'] as Map));
      final tags = (e['tags'] as List? ?? const [])
          .map((t) => "'${(t as String).replaceAll("'", r"\'")}'")
          .join(', ');
      final dynastyId = e['dynastyId'] == null
          ? null
          : "'${(e['dynastyId'] as String)}'";
      final rulerId = e['rulerId'] == null
          ? null
          : "'${(e['rulerId'] as String)}'";

      double startJdn;
      double? endJdn;

      if (e.containsKey('startJdn')) {
        startJdn = (e['startJdn'] as num).toDouble();
        endJdn = e['endJdn'] == null ? null : (e['endJdn'] as num).toDouble();
      } else {
        startJdn = _toJdn(Map<String, dynamic>.from(e['start'] as Map));
        endJdn = e['end'] == null
            ? null
            : _toJdn(Map<String, dynamic>.from(e['end'] as Map));
      }

      buf.writeln('  ChronicleEntryData(');
      buf.writeln("    id: '$id',");
      buf.writeln('    startJdn: $startJdn,');
      if (endJdn != null) buf.writeln('    endJdn: $endJdn,');
      buf.writeln('    title: $title,');
      if (summary != null) buf.writeln('    summary: $summary,');
      if (tags.isNotEmpty) buf.writeln('    tags: [$tags],');
      if (dynastyId != null) buf.writeln('    dynastyId: $dynastyId,');
      if (rulerId != null) buf.writeln('    rulerId: $rulerId,');
      buf.writeln('  ),');
    }
    buf.writeln('];');
    return buf.toString();
  }

  // Optional rulers if your JSON has them.
  String? _emitRulers() {
    if (!data.containsKey('rulers')) return null;
    final list = data['rulers'] as List;
    final buf = StringBuffer()
      ..writeln("import '../models/chronicle_models.dart';")
      ..writeln()
      ..writeln('const List<RulerData> kRulers = [');
    for (final raw in list) {
      final r = raw as Map<String, dynamic>;
      final id = r['id'] as String;
      final dynastyId = r['dynastyId'] as String;
      final name = _emitMapString(Map<String, dynamic>.from(r['name'] as Map));
      final startJdn = _toJdn(Map<String, dynamic>.from(r['start'] as Map));
      final endJdn = _toJdn(Map<String, dynamic>.from(r['end'] as Map));
      buf.writeln(
        "  RulerData(id: '$id', dynastyId: '$dynastyId', name: $name, startJdn: $startJdn, endJdn: $endJdn),",
      );
    }
    buf.writeln('];');
    return buf.toString();
  }

  await Directory(outDir).create(recursive: true);
  await File(
    '$outDir/chronicle_dynasties.dart',
  ).writeAsString(_emitDynasties());
  await File('$outDir/chronicle_entries.dart').writeAsString(_emitEntries());
  final rulers = _emitRulers();
  if (rulers != null) {
    await File('$outDir/chronicle_rulers.dart').writeAsString(rulers);
  }

  stdout.writeln('Generated chronicle constants in $outDir');
}

Map<String, String> _parseArgs(List<String> args) {
  final map = <String, String>{};
  for (var i = 0; i < args.length - 1; i++) {
    if (args[i].startsWith('--')) map[args[i]] = args[i + 1];
  }
  return map;
}
