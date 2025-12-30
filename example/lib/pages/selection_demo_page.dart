import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class SelectionDemoPage extends StatefulWidget {
  const SelectionDemoPage({super.key});

  @override
  State<SelectionDemoPage> createState() => _SelectionDemoPageState();
}

class _SelectionDemoPageState extends State<SelectionDemoPage> {
  Language _language = Language.english;
  CalendarSelectionMode _selectionMode = CalendarSelectionMode.single;
  DateTime? _selectedDate;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  List<DateTime> _multiSelectedDates = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Selection Mode Demo')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SegmentedButton<CalendarSelectionMode>(
                segments: const [
                  ButtonSegment(
                    value: CalendarSelectionMode.single,
                    label: Text('Single'),
                  ),
                  ButtonSegment(
                    value: CalendarSelectionMode.range,
                    label: Text('Range'),
                  ),
                  ButtonSegment(
                    value: CalendarSelectionMode.multi,
                    label: Text('Multi'),
                  ),
                ],
                selected: {_selectionMode},
                onSelectionChanged: (value) {
                  setState(() {
                    _selectionMode = value.first;
                    _selectedDate = null;
                    _rangeStart = null;
                    _rangeEnd = null;
                    _multiSelectedDates = [];
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SegmentedButton<Language>(
                segments: const [
                  ButtonSegment(
                    value: Language.english,
                    label: Text('English'),
                  ),
                  ButtonSegment(value: Language.myanmar, label: Text('မြန်မာ')),
                  ButtonSegment(value: Language.zawgyi, label: Text('Zawgyi')),
                  ButtonSegment(value: Language.mon, label: Text('Mon')),
                  ButtonSegment(value: Language.shan, label: Text('Shan')),
                ],
                selected: {_language},
                onSelectionChanged: (value) {
                  setState(() {
                    _language = value.first;
                  });
                },
              ),
            ),
            MyanmarCalendarWidget(
              selectionMode: _selectionMode,
              onDateSelected: (date) {
                setState(() {
                  _selectedDate = date.western.toDateTime();
                });
              },
              onRangeSelected: (start, end) {
                setState(() {
                  _rangeStart = start;
                  _rangeEnd = end;
                });
              },
              onMultiSelected: (dates) {
                setState(() {
                  _multiSelectedDates = dates;
                });
              },
            ),
            const Divider(),
            _buildSelectionInfo(),
            const SizedBox(height: 20),
            if (_selectedDate != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: HoroscopeWidget(
                  date: MyanmarCalendar.getCompleteDate(_selectedDate!),
                  language: _language,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selection Info:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          if (_selectionMode == CalendarSelectionMode.single)
            Text('Selected: ${_selectedDate ?? 'None'}'),
          if (_selectionMode == CalendarSelectionMode.range)
            Text('Range: ${_rangeStart ?? 'None'} - ${_rangeEnd ?? 'None'}'),
          if (_selectionMode == CalendarSelectionMode.multi)
            Text('Selected Dates: ${_multiSelectedDates.length}'),
        ],
      ),
    );
  }
}
