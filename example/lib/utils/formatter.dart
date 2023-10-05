import 'package:intl/intl.dart';

String formattedDateString(
  DateTime date, {
  String pattern = 'yyyy-MM-dd',
}) =>
    DateFormat(pattern).format(date);
