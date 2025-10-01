// A small generator to extract dynasty JDN ranges from ceMmDateTime.js
// It parses the InitRulers() array, aggregates Beginning_JDN/Ending_JDN per dynasty,
// and emits lib/src/utils/chronicle_dynasties.dart constants. It also uses
// lib/src/utils/chronicle_dynasty_meta.dart to derive readable names (en/my) when possible.

import 'dart:convert';
import 'dart:io';

final _dynastyIdMap = <String, String>{
  'Konbaung': 'konbaung',
  'Restored_Hanthawaddy': 'restored_hanthawaddy',
  'Taungoo': 'taungoo',
  'Mrauk_U': 'mrauk_u',
  'Hanthawaddy': 'hanthawaddy',
  'Prome': 'prome',
  'Ava': 'ava',
  'Sagaing': 'sagaing',
  'Pinya': 'pinya',
  'Myinsaing': 'myinsaing',
  'Pagan': 'pagan',
  'Early_Pagan': 'early_pagan',
  'British_Colonial_Period': 'british_colonial_period',
  'Japanese_Occupation': 'japanese_occupation',
  'Union_of_Burma': 'union_of_burma',
  'Socialist_Republic': 'socialist_republic',
  'Union_of_Myanmar': 'union_of_myanmar',
  'Republic_Myanmar': 'republic_myanmar',
};

Future<void> main(List<String> args) async {
  final jsPath = args.isNotEmpty ? args.first : 'misc/lang/ceMmDateTime.js';
  final outPath = 'lib/src/utils/chronicle_dynasties.dart';
  final metaPath = 'lib/src/utils/chronicle_dynasty_meta.dart';

  final js = await File(jsPath).readAsString();
  final meta = await File(metaPath).readAsString();

  // Extract InitRulers array content
  final startIdx = js.indexOf('static InitRulers()');
  if (startIdx < 0) {
    stderr.writeln('InitRulers not found in $jsPath');
    exit(1);
  }
  final arrayStart = js.indexOf('[', startIdx);
  final arrayEnd = js.indexOf(
    '\n  }',
    arrayStart,
  ); // end of function before next block
  if (arrayStart < 0 || arrayEnd < 0) {
    stderr.writeln('Could not locate rulers array in $jsPath');
    exit(1);
  }
  final rulersBlock = js.substring(arrayStart, arrayEnd);

  // Regex to capture object blocks
  final objRegex = RegExp(r"\{[\s\S]*?\}", multiLine: true);
  final nameRegex = RegExp(r'Dynasty:\s*"([^"]+)"');
  final beginRegex = RegExp(r'Beginning_JDN:\s*(\d+)');
  final endRegex = RegExp(r'Ending_JDN:\s*(\d+)');

  final dynastyToRange = <String, List<int>>{}; // id -> [minStart, maxEnd]

  for (final m in objRegex.allMatches(rulersBlock)) {
    final obj = rulersBlock.substring(m.start, m.end);
    final nameM = nameRegex.firstMatch(obj);
    final bM = beginRegex.firstMatch(obj);
    final eM = endRegex.firstMatch(obj);
    if (nameM == null || bM == null || eM == null) continue;
    final jsDyn = nameM.group(1)!;
    final id = _dynastyIdMap[jsDyn];
    if (id == null) continue; // skip unknown
    final b = int.parse(bM.group(1)!);
    final e = int.parse(eM.group(1)!);
    final range = dynastyToRange.putIfAbsent(id, () => [b, e]);
    if (b < range[0]) range[0] = b;
    if (e > range[1]) range[1] = e;
  }

  if (dynastyToRange.isEmpty) {
    stderr.writeln('No dynasty ranges parsed.');
    exit(1);
  }

  // Parse metadata to derive names (en/my) from description: "English (Myanmar)"
  final metaMap = <String, Map<String, String>>{};
  final metaEntryRegex = RegExp(
    r"'([a-zA-Z0-9_]+)':\s*\{\s*'description':\s*'([^']+)'[\s\S]*?\}",
    multiLine: true,
  );
  for (final m in metaEntryRegex.allMatches(meta)) {
    final id = m.group(1)!;
    final desc = m.group(2)!; // e.g., Konbaung (ကုန်းဘောင်ခေတ်)
    String en = desc;
    String my = '';
    final p = desc.indexOf('(');
    final q = desc.indexOf(')', p + 1);
    if (p > 0 && q > p) {
      en = desc.substring(0, p).trim();
      my = desc.substring(p + 1, q).trim();
    }
    metaMap[id] = {'en': en, if (my.isNotEmpty) 'my': my};
  }

  // Emit file
  final buf = StringBuffer()
    ..writeln("import '../models/chronicle_models.dart';")
    ..writeln()
    ..writeln('const List<DynastyData> kDynasties = [');

  final sorted = dynastyToRange.entries.toList()
    ..sort((a, b) => a.value[0].compareTo(b.value[0]));

  for (final e in sorted) {
    final id = e.key;
    final start = e.value[0];
    final end = e.value[1];
    final nameMap = metaMap[id] ?? {'en': id};
    final nameJson = jsonEncode(nameMap).replaceAll('"', "'");
    buf.writeln(
      "  DynastyData(id: '$id', name: $nameJson, startJdn: ${start.toDouble()}, endJdn: ${end.toDouble()}),",
    );
  }

  buf.writeln('];');

  await File(outPath).writeAsString(buf.toString());
  stdout.writeln('Wrote dynasty ranges to $outPath');
}
