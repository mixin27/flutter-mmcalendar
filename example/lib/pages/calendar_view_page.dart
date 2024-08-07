import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:intl/intl.dart';

class CalendarViewPage extends StatelessWidget {
  const CalendarViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Views'),
      ),
      body: MmCalendarViewMonth(
        onTap: (details, mmDate, astro, holidays) {
          if (details.date == null) return;

          showAdaptiveDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(DateFormat().add_yMMMEd().format(details.date!)),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(mmDate?.format() ?? ''),
                  const SizedBox(height: 20),
                  Text(astro?.getAstrologicalDay() ?? ''),
                  const SizedBox(height: 20),
                  Text(
                    holidays?.join(', ') ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(color: Theme.of(context).colorScheme.error),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
