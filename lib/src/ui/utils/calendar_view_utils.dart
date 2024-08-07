import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// Calendar view utilities.
MyanmarDate getDateMM(DateTime date) {
  return MyanmarDateConverter.fromDateTime(date);
}
