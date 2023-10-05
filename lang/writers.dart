// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'constants.dart';

Future<void> writeDynaties() async {
  String str = jsonEncode(dynasties);
  final file = File('dynasties.json');
  await file.writeAsString(str);
  print('dynasties.json write finished!');

  String str2 = jsonEncode(dynastyMap);
  final file2 = File('dynasty_map.json');
  await file2.writeAsString(str2);
  print('dynasty_map.json write finished!');
}

Future<void> writeLanguages() async {
  Map<String, String> engMap = {};
  Map<String, String> myanMap = {};
  Map<String, String> zawgyiMap = {};
  Map<String, String> monMap = {};
  Map<String, String> taiMap = {};
  Map<String, String> karenMap = {};

  for (var i = 0; i < languages.length; i++) {
    final element = languages[i];

    var eng = element[0];
    var myan = element[1];
    var zawgyi = element[2];
    var mon = element[2];
    var tai = element[2];
    var karen = element[2];

    engMap.putIfAbsent(eng, () => eng);
    myanMap.putIfAbsent(eng, () => myan);
    zawgyiMap.putIfAbsent(eng, () => zawgyi);
    monMap.putIfAbsent(eng, () => mon);
    taiMap.putIfAbsent(eng, () => tai);
    karenMap.putIfAbsent(eng, () => karen);
  }

  final engJson = File('lang_en.json');
  String engMapStr = "{\n";
  for (var i = 0; i < engMap.length; i++) {
    final map = engMap.entries.toList()[i];

    if (i == engMap.length - 1) {
      engMapStr += '  "${map.key}": "${map.value}"\n';
    } else {
      engMapStr += '  "${map.key}": "${map.value}",\n';
    }
  }
  engMapStr += "}";
  await engJson.writeAsString(engMapStr);
  print('lang_en.json write finished!');

  // lang_myan
  final myanJson = File('lang_my.json');
  String myanMapStr = "{\n";
  for (var i = 0; i < myanMap.length; i++) {
    final map = myanMap.entries.toList()[i];

    if (i == myanMap.length - 1) {
      myanMapStr += '  "${map.key}": "${map.value}"\n';
    } else {
      myanMapStr += '  "${map.key}": "${map.value}",\n';
    }
  }
  myanMapStr += "}";
  await myanJson.writeAsString(myanMapStr);
  print('lang_my.json write finished!');

  // lang_zawgyi
  final zawgyiJson = File('lang_zawgyi.json');
  String zawgyiMapStr = "{\n";
  for (var i = 0; i < zawgyiMap.length; i++) {
    final map = zawgyiMap.entries.toList()[i];

    if (i == zawgyiMap.length - 1) {
      zawgyiMapStr += '  "${map.key}": "${map.value}"\n';
    } else {
      zawgyiMapStr += '  "${map.key}": "${map.value}",\n';
    }
  }
  zawgyiMapStr += "}";
  await zawgyiJson.writeAsString(zawgyiMapStr);
  print('lang_zawgyi.json write finished!');

  // lang_mon
  final monJson = File('lang_mon.json');
  String monMapStr = "{\n";
  for (var i = 0; i < monMap.length; i++) {
    final map = monMap.entries.toList()[i];

    if (i == monMap.length - 1) {
      monMapStr += '  "${map.key}": "${map.value}"\n';
    } else {
      monMapStr += '  "${map.key}": "${map.value}",\n';
    }
  }
  monMapStr += "}";
  await monJson.writeAsString(monMapStr);
  print('lang_mon.json write finished!');

  // lang_tai
  final taiJson = File('lang_tai.json');
  String taiMapStr = "{\n";
  for (var i = 0; i < taiMap.length; i++) {
    final map = taiMap.entries.toList()[i];

    if (i == taiMap.length - 1) {
      taiMapStr += '  "${map.key}": "${map.value}"\n';
    } else {
      taiMapStr += '  "${map.key}": "${map.value}",\n';
    }
  }
  taiMapStr += "}";
  await taiJson.writeAsString(taiMapStr);
  print('lang_tai.json write finished!');

  // lang_karen
  final karenJson = File('lang_karen.json');
  String karenMapStr = "{\n";
  for (var i = 0; i < karenMap.length; i++) {
    final map = karenMap.entries.toList()[i];

    if (i == karenMap.length - 1) {
      karenMapStr += '  "${map.key}": "${map.value}"\n';
    } else {
      karenMapStr += '  "${map.key}": "${map.value}",\n';
    }
  }
  karenMapStr += "}";
  await karenJson.writeAsString(karenMapStr);
  print('lang_karen.json write finished!');
}
