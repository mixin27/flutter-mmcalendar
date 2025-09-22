import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Myanmar Calendar")),
      body: Column(
        spacing: 10,
        children: [
          Expanded(child: MyanmarCalendarWidget(language: Language.myanmar)),
          ElevatedButton(
            onPressed: () async {
              final selectedDate = await showMyanmarDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
                language: Language.myanmar,
                theme: MyanmarDatePickerTheme.defaultTheme(),
                showHolidays: true,
                showAstrology: true,
              );

              if (selectedDate != null) {
                log('Selected: ${selectedDate.toCompactString()}');
              }
            },
            child: const Text("Show Picker"),
          ),
          ElevatedButton(
            onPressed: () async {
              final selectedDate = await showMyanmarDatePickerFullscreen(
                context: context,
                initialDate: DateTime.now(),
                language: Language.myanmar,
                title: 'ရက်စွဲရွေးချယ်ရန်',
              );

              if (selectedDate != null) {
                log('Selected: ${selectedDate.toCompactString()}');
              }
            },
            child: const Text("Show Picker Full"),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
