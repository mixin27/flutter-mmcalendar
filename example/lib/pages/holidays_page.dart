import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class HolidaysPage extends StatefulWidget {
  const HolidaysPage({super.key});

  @override
  State<HolidaysPage> createState() => _HolidaysPageState();
}

class _HolidaysPageState extends State<HolidaysPage> {
  List<String> _holidays = List.empty();

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() {
    final myanmarDate = MyanmarDateConverter.fromDateTime(DateTime.now());
    final holidays = HolidaysCalculator.getHolidays(myanmarDate);
    setState(() {
      _holidays = holidays;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Holidays of 2023/12/25'),
      ),
      body: ListView.separated(
        itemCount: _holidays.length,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final holiday = _holidays[index];
          return ListTile(
            title: Text(holiday),
          );
        },
      ),
    );
  }
}
