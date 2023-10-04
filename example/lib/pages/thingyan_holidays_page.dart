import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:intl/intl.dart';

class ThingyanHolidaysPage extends StatefulWidget {
  const ThingyanHolidaysPage({super.key});

  @override
  State<ThingyanHolidaysPage> createState() => _ThingyanHolidaysPageState();
}

class _ThingyanHolidaysPageState extends State<ThingyanHolidaysPage> {
  List<MyanmarThingyan> _holidays = List.empty();

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    getHolidays(_selectedDate);
    super.initState();
  }

  void getHolidays(DateTime dateTime) {
    final myanmarDate = MyanmarDateConverter.fromDateTime(dateTime);
    final thingyanHolidays =
        ThingyanCalculator.getMyanmarThingyanDays(myanmarDate);
    setState(() {
      _holidays = thingyanHolidays;
    });
  }

  void selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (selectedDate != null) {
      setState(() {
        _selectedDate = selectedDate;
      });

      getHolidays(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thingyan Holidays for ${_selectedDate.year}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: FilledButton.icon(
                    onPressed: selectDate,
                    icon: const Icon(Icons.calendar_month),
                    label: const Text('Choose Date'),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.inversePrimary,
                    border: Border.all(
                      color: Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Date - ${DateFormat('yyyy-MM-dd').format(_selectedDate)}',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        MyanmarDateConverter.fromDateTime(_selectedDate)
                            .format(),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                final holiday = _holidays[index];

                return ListTile(
                  title: Text(holiday.label),
                  subtitle: Text(
                    holiday.date.formatByPatternAndLanguage(
                      languageCatalog: LanguageCatalog(),
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => const Divider(),
              itemCount: _holidays.length,
            ),
          ),
        ],
      ),
    );
  }
}
