import 'package:example/utils/astro_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:intl/intl.dart';

class AstroInfoPage extends StatefulWidget {
  const AstroInfoPage({super.key});

  @override
  State<AstroInfoPage> createState() => _AstroInfoPageState();
}

class _AstroInfoPageState extends State<AstroInfoPage> {
  DateTime _selectedDate = DateTime.now();
  String _astroInfo = '';

  @override
  void initState() {
    getData(_selectedDate);
    super.initState();
  }

  void getData(DateTime dateTime) {
    final astroInfo = AstroUtils.getAstroInfo(dateTime);
    setState(() {
      _astroInfo = astroInfo;
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

      getData(_selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Astrological Information'),
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              _astroInfo,
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }
}
