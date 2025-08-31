import 'package:example/utils/astro_utils.dart';
import 'package:example/widgets/date_info_notice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class AstroInfoPage extends StatefulWidget {
  const AstroInfoPage({super.key});

  @override
  State<AstroInfoPage> createState() => _AstroInfoPageState();
}

class _AstroInfoPageState extends State<AstroInfoPage> {
  DateTime _selectedDate = DateTime.now();
  late Astro _astro;

  @override
  void initState() {
    getData(_selectedDate);
    super.initState();
  }

  void getData(DateTime dateTime) {
    final astro = AstroUtils.getAstro(dateTime);
    setState(() {
      _astro = astro;
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
      appBar: AppBar(title: const Text('Astrological Information')),
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
                        getData(_selectedDate);
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
                        getData(_selectedDate);
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AstroInfoItem(
                label: 'Amyeittasote',
                value: _astro.getAmyeittasote(),
                backgroundColor: false,
              ),
              AstroInfoItem(
                label: 'AstrologicalDay',
                value: _astro.getAstrologicalDay(),
              ),
              AstroInfoItem(
                label: 'Mahabote',
                value: _astro.getMahabote(),
                backgroundColor: false,
              ),
              AstroInfoItem(
                label: 'Mahayatkyan',
                value: _astro.getMahayatkyan(),
              ),
              AstroInfoItem(
                label: 'Nagahle',
                value: _astro.getNagahle(),
                backgroundColor: false,
              ),
              AstroInfoItem(
                label: 'Nagapor',
                value: _astro.getNagapor(),
                backgroundColor: true,
              ),
              AstroInfoItem(
                label: 'Nakhat',
                value: _astro.getNakhat(),
                backgroundColor: false,
              ),
              AstroInfoItem(
                label: 'Sabbath',
                value: _astro.getSabbath(),
                backgroundColor: true,
              ),
              AstroInfoItem(
                label: 'Shanyat',
                value: _astro.getShanyat(),
                backgroundColor: false,
              ),
              AstroInfoItem(
                label: 'Thamanyo',
                value: _astro.getThamanyo(),
                backgroundColor: true,
              ),
              AstroInfoItem(
                label: 'Thamaphyu',
                value: _astro.getThamaphyu(),
                backgroundColor: false,
              ),
              AstroInfoItem(
                label: 'Warameittugyi',
                value: _astro.getWarameittugyi(),
                backgroundColor: true,
              ),
              AstroInfoItem(
                label: 'Warameittunge',
                value: _astro.getWarameittunge(),
                backgroundColor: false,
              ),
              AstroInfoItem(
                label: 'Yatpote',
                value: _astro.getYatpote(),
                backgroundColor: true,
              ),
              AstroInfoItem(
                label: 'Yatyotema',
                value: _astro.getYatyotema(),
                backgroundColor: false,
              ),
              AstroInfoItem(
                label: 'YearName',
                value: _astro.getYearName(),
                backgroundColor: true,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

class AstroInfoItem extends StatelessWidget {
  const AstroInfoItem({
    required this.label,
    required this.value,
    super.key,
    this.backgroundColor = true,
  });

  final String label;
  final String value;
  final bool backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: backgroundColor
            ? Theme.of(context).colorScheme.inversePrimary
            : Theme.of(
                context,
              ).colorScheme.inversePrimary.withValues(alpha: 0.6),
        border: Border(
          bottom: BorderSide(
            // color: backgroundColor
            //     ? Theme.of(context).colorScheme.primary
            //     : Theme.of(context).colorScheme.primary.withOpacity(0.5),
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: Theme.of(context).textTheme.labelLarge),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 4,
            child: Text(value, style: Theme.of(context).textTheme.labelLarge),
          ),
        ],
      ),
    );
  }
}
