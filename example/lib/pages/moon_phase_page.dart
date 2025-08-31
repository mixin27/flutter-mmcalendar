import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:intl/intl.dart';

class MoonPhasePage extends StatefulWidget {
  const MoonPhasePage({super.key});

  @override
  State<MoonPhasePage> createState() => _MoonPhasePageState();
}

class _MoonPhasePageState extends State<MoonPhasePage> {
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MoonPhase Widget')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.icon(
              onPressed: () async {
                final selectedDate = await showDatePicker(
                  context: context,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(3000),
                  initialDate: _date,
                );

                if (selectedDate != null) {
                  setState(() {
                    _date = selectedDate;
                  });
                }
              },
              icon: const Icon(Icons.calendar_month_outlined),
              label: const Text('Select Date'),
            ),
            const SizedBox(height: 20),
            Text(
              DateFormat().add_yMMMEd().format(_date),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            MoonPhaseWidget(date: _date, size: 90),
          ],
        ),
      ),
    );
  }
}
