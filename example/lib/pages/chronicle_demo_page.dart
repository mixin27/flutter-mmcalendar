import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class ChronicleDemoPage extends StatelessWidget {
  const ChronicleDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final date = MyanmarCalendar.today();
    final chronicles = MyanmarCalendar.getChronicleForMyanmar(date.myanmarDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Chronicles Data'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          final chronicle = chronicles[index];
          final myanmarDate = MyanmarCalendar.fromJulianDay(chronicle.startJdn);

          return ListTile(
            title: Text(
              '${myanmarDate.formatWestern("%y %M %d")} (${myanmarDate.formatMyanmar(null, Language.myanmar)})',
            ),
            subtitle: Text(chronicle.title['my'] ?? ''),
          );
        },
        itemCount: chronicles.length,
      ),
    );
  }
}
