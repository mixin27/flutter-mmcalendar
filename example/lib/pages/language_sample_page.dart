import 'package:example/widgets/date_info_notice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class LanguageSamplePage extends StatefulWidget {
  const LanguageSamplePage({super.key});

  @override
  State<LanguageSamplePage> createState() => _LanguageSamplePageState();
}

class _LanguageSamplePageState extends State<LanguageSamplePage> {
  DateTime _selectedDate = DateTime.now();

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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language'),
      ),
      body: ListView(
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
                      },
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 35,
                      ),
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
                      },
                      icon: const Icon(
                        Icons.chevron_right,
                        size: 35,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                DateInfoNotice(date: _selectedDate),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Default Config',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  FlutterMmcalendar.getDateByLanguage(_selectedDate),
                ),
                const SizedBox(height: 20),
                Text(
                  'English',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  FlutterMmcalendar.getDateByLanguage(
                    _selectedDate,
                    language: Language.english,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Myanmar',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  FlutterMmcalendar.getDateByLanguage(
                    _selectedDate,
                    language: Language.myanmar,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Zawgyi',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  FlutterMmcalendar.getDateByLanguage(
                    _selectedDate,
                    language: Language.zawgyi,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Mon',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  FlutterMmcalendar.getDateByLanguage(
                    _selectedDate,
                    language: Language.mon,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Tai',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  FlutterMmcalendar.getDateByLanguage(
                    _selectedDate,
                    language: Language.tai,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "S'Karen",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 10),
                Text(
                  FlutterMmcalendar.getDateByLanguage(
                    _selectedDate,
                    language: Language.karen,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
