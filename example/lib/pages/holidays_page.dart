import 'package:example/utils/formatter.dart';
import 'package:example/widgets/date_info_notice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class HolidaysPage extends StatefulWidget {
  const HolidaysPage({super.key});

  @override
  State<HolidaysPage> createState() => _HolidaysPageState();
}

class _HolidaysPageState extends State<HolidaysPage> {
  List<String> _holidays = List.empty();

  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    getHolidays(_selectedDate);
    super.initState();
  }

  void getHolidays(DateTime dateTime) {
    final mmCalendar = MmCalendar();

    final myanmarDate = mmCalendar.fromDateTime(dateTime);
    final holidays = myanmarDate.holidays;
    setState(() {
      _holidays = holidays;
    });
  }

  void selectDate() async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
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
      appBar: AppBar(title: const Text('Holidays')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedDate = _selectedDate.subtract(
                            const Duration(days: 1),
                          );
                        });
                        getHolidays(_selectedDate);
                      },
                      icon: const Icon(Icons.chevron_left, size: 35),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        onPressed: selectDate,
                        icon: const Icon(Icons.calendar_month),
                        label: const Text('Choose Date'),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _selectedDate = _selectedDate.add(
                            const Duration(days: 1),
                          );
                        });
                        getHolidays(_selectedDate);
                      },
                      icon: const Icon(Icons.chevron_right, size: 35),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                DateInfoNotice(date: _selectedDate),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: _holidays.isEmpty
                ? ListTile(
                    title: Text(
                      'Your selected date ${formattedDateString(_selectedDate)} does not include in holiday list',
                    ),
                  )
                : ListView.separated(
                    itemCount: _holidays.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final holiday = _holidays[index];
                      return ListTile(title: Text(holiday));
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
