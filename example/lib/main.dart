import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const seed = Color(0xFF0F766E);

    return MaterialApp(
      title: 'Myanmar Calendar Showcase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seed,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
      ),
      home: const ShowcaseHomePage(),
    );
  }
}

enum DemoSection { calendar, picker, insights }

class ShowcaseHomePage extends StatefulWidget {
  const ShowcaseHomePage({super.key});

  @override
  State<ShowcaseHomePage> createState() => _ShowcaseHomePageState();
}

class _ShowcaseHomePageState extends State<ShowcaseHomePage> {
  DemoSection _section = DemoSection.calendar;
  Language _language = Language.english;
  CalendarSelectionMode _selectionMode = CalendarSelectionMode.single;
  bool _showHolidays = true;
  bool _showAstrology = true;

  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  List<DateTime> _multiSelectedDates = <DateTime>[];
  MyanmarDateTime? _formDate;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late CompleteDate _selectedCompleteDate;
  late MyanmarCalendarTheme _calendarTheme;

  @override
  void initState() {
    super.initState();
    _selectedCompleteDate = MyanmarCalendar.getCompleteDate(DateTime.now());
    _calendarTheme = MyanmarCalendarTheme.fromColor(const Color(0xFF0F766E))
        .copyWith(
          backgroundColor: const Color(0xFFF8FAFC),
          borderColor: const Color(0xFFCBD5E1),
          weekdayHeaderBackgroundColor: const Color(0xFFE2E8F0),
          dateCellBackgroundColor: Colors.white,
          dateCellTextColor: const Color(0xFF0F172A),
          rangeBackgroundColor: const Color(0xFFCCFBF1),
          rangeTextColor: const Color(0xFF134E4A),
          holidayIndicatorColor: const Color(0xFFDC2626),
          astroIndicatorColor: const Color(0xFFF97316),
        );
  }

  void _updateSelectedDate(CompleteDate date) {
    setState(() {
      _selectedCompleteDate = date;
    });
  }

  Future<void> _openModalPicker() async {
    final result = await showMyanmarDatePicker(
      context: context,
      initialDate: _selectedCompleteDate.western.toDateTime(),
      language: _language,
      theme: _calendarTheme,
      showHolidays: _showHolidays,
      showAstrology: _showAstrology,
      showWesternDates: true,
      showMyanmarDates: true,
      firstDayOfWeek: 1,
    );

    if (result != null) {
      _updateSelectedDate(result);
    }
  }

  Future<void> _openFullscreenPicker() async {
    final result = await showMyanmarDatePickerFullscreen(
      context: context,
      initialDate: _selectedCompleteDate.western.toDateTime(),
      language: _language,
      theme: _calendarTheme,
      showHolidays: _showHolidays,
      showAstrology: _showAstrology,
      showWesternDates: true,
      showMyanmarDates: true,
      firstDayOfWeek: 1,
    );

    if (result != null) {
      _updateSelectedDate(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F766E),
        foregroundColor: Colors.white,
        title: const Text('Myanmar Calendar Showcase'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _buildControlPanel(),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: _buildCurrentSection(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: DemoSection.values.indexOf(_section),
        onDestinationSelected: (int index) {
          setState(() {
            _section = DemoSection.values[index];
          });
        },
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_calendar_outlined),
            selectedIcon: Icon(Icons.edit_calendar),
            label: 'Picker',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome),
            label: 'Insights',
          ),
        ],
      ),
    );
  }

  Widget _buildControlPanel() {
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            const Text(
              'Language:',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(width: 8),
            SegmentedButton<Language>(
              segments: const <ButtonSegment<Language>>[
                ButtonSegment<Language>(
                  value: Language.english,
                  label: Text('EN'),
                ),
                ButtonSegment<Language>(
                  value: Language.myanmar,
                  label: Text('MM'),
                ),
                ButtonSegment<Language>(
                  value: Language.shan,
                  label: Text('Shan'),
                ),
              ],
              selected: <Language>{_language},
              showSelectedIcon: false,
              onSelectionChanged: (Set<Language> values) {
                setState(() {
                  _language = values.first;
                });
              },
            ),
            const SizedBox(width: 12),
            const VerticalDivider(width: 1),
            const SizedBox(width: 12),
            if (_section == DemoSection.calendar) ...<Widget>[
              const Text(
                'Selection:',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 8),
              SegmentedButton<CalendarSelectionMode>(
                segments: const <ButtonSegment<CalendarSelectionMode>>[
                  ButtonSegment<CalendarSelectionMode>(
                    value: CalendarSelectionMode.single,
                    label: Text('Single'),
                  ),
                  ButtonSegment<CalendarSelectionMode>(
                    value: CalendarSelectionMode.range,
                    label: Text('Range'),
                  ),
                  ButtonSegment<CalendarSelectionMode>(
                    value: CalendarSelectionMode.multi,
                    label: Text('Multi'),
                  ),
                ],
                selected: <CalendarSelectionMode>{_selectionMode},
                showSelectedIcon: false,
                onSelectionChanged: (Set<CalendarSelectionMode> values) {
                  setState(() {
                    _selectionMode = values.first;
                    _rangeStart = null;
                    _rangeEnd = null;
                    _multiSelectedDates = <DateTime>[];
                  });
                },
              ),
              const SizedBox(width: 12),
            ],
            FilterChip(
              label: const Text('Holidays'),
              selected: _showHolidays,
              onSelected: (bool value) {
                setState(() {
                  _showHolidays = value;
                });
              },
            ),
            const SizedBox(width: 8),
            FilterChip(
              label: const Text('Astrology'),
              selected: _showAstrology,
              onSelected: (bool value) {
                setState(() {
                  _showAstrology = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentSection() {
    switch (_section) {
      case DemoSection.calendar:
        return _buildCalendarSection();
      case DemoSection.picker:
        return _buildPickerSection();
      case DemoSection.insights:
        return _buildInsightsSection();
    }
  }

  Widget _buildCalendarSection() {
    return LayoutBuilder(
      key: const ValueKey<String>('calendar'),
      builder: (BuildContext context, BoxConstraints constraints) {
        final double calendarHeight = constraints.maxHeight > 700 ? 560 : 460;

        return ListView(
          padding: const EdgeInsets.all(12),
          children: <Widget>[
            Text(
              'Interactive calendar with selection modes',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                height: calendarHeight,
                child: MyanmarCalendarWidget(
                  initialDate: _selectedCompleteDate.western.toDateTime(),
                  language: _language,
                  theme: _calendarTheme,
                  selectionMode: _selectionMode,
                  showHolidays: _showHolidays,
                  showAstrology: _showAstrology,
                  showWesternDates: true,
                  showMyanmarDates: true,
                  onDateSelected: _updateSelectedDate,
                  onRangeSelected: (DateTime? start, DateTime? end) {
                    setState(() {
                      _rangeStart = start;
                      _rangeEnd = end;
                    });
                  },
                  onMultiSelected: (List<DateTime> dates) {
                    setState(() {
                      _multiSelectedDates = dates;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildSelectionMeta(),
            const SizedBox(height: 12),
            MyanmarDateSummaryCard(
              date: _selectedCompleteDate,
              language: _language,
              theme: _calendarTheme,
              showHolidays: _showHolidays,
              showAstrology: _showAstrology,
            ),
          ],
        );
      },
    );
  }

  Widget _buildSelectionMeta() {
    String message;
    switch (_selectionMode) {
      case CalendarSelectionMode.single:
        message =
            'Selected: ${_selectedCompleteDate.western.year}-${_selectedCompleteDate.western.month.toString().padLeft(2, '0')}-${_selectedCompleteDate.western.day.toString().padLeft(2, '0')}';
        break;
      case CalendarSelectionMode.range:
        if (_rangeStart == null) {
          message = 'Tap a start day, then tap an end day.';
        } else if (_rangeEnd == null) {
          message =
              'Range start: ${_rangeStart!.year}-${_rangeStart!.month.toString().padLeft(2, '0')}-${_rangeStart!.day.toString().padLeft(2, '0')}';
        } else {
          message =
              'Range: ${_rangeStart!.year}-${_rangeStart!.month.toString().padLeft(2, '0')}-${_rangeStart!.day.toString().padLeft(2, '0')}  ->  ${_rangeEnd!.year}-${_rangeEnd!.month.toString().padLeft(2, '0')}-${_rangeEnd!.day.toString().padLeft(2, '0')}';
        }
        break;
      case CalendarSelectionMode.multi:
        message = 'Selected ${_multiSelectedDates.length} date(s).';
        break;
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFECFEFF),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFA5F3FC)),
      ),
      child: Text(
        message,
        style: const TextStyle(
          color: Color(0xFF0F766E),
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildPickerSection() {
    return LayoutBuilder(
      key: const ValueKey<String>('picker'),
      builder: (BuildContext context, BoxConstraints constraints) {
        final double pickerHeight = constraints.maxHeight > 760 ? 620 : 500;

        return ListView(
          padding: const EdgeInsets.all(12),
          children: <Widget>[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: <Widget>[
                FilledButton.icon(
                  onPressed: _openModalPicker,
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('Open Dialog Picker'),
                ),
                OutlinedButton.icon(
                  onPressed: _openFullscreenPicker,
                  icon: const Icon(Icons.fullscreen),
                  label: const Text('Open Fullscreen Picker'),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE2E8F0)),
              ),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                height: pickerHeight,
                child: MyanmarDatePickerWidget(
                  initialDate: _selectedCompleteDate.western.toDateTime(),
                  language: _language,
                  theme: _calendarTheme,
                  showHolidays: _showHolidays,
                  showAstrology: _showAstrology,
                  showWesternDates: true,
                  showMyanmarDates: true,
                  onDateChanged: _updateSelectedDate,
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildFormFieldDemo(context),
          ],
        );
      },
    );
  }

  Widget _buildFormFieldDemo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Form field integration',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            MyanmarDatePickerFormField(
              value: _formDate,
              language: _language,
              theme: _calendarTheme,
              labelText: 'Reminder Date',
              showWesternDates: true,
              showHolidays: _showHolidays,
              onChanged: (MyanmarDateTime? value) {
                setState(() {
                  _formDate = value;
                });
              },
              validator: (MyanmarDateTime? value) {
                if (value == null) {
                  return 'Please pick a date';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Form date is valid and saved.'),
                        ),
                      );
                    }
                  },
                  child: const Text('Validate Form'),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _formDate = null;
                    });
                  },
                  child: const Text('Clear'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInsightsSection() {
    return ListView(
      key: const ValueKey<String>('insights'),
      padding: const EdgeInsets.all(12),
      children: <Widget>[
        MyanmarCalendarToolbar(
          month: _selectedCompleteDate.western.toDateTime(),
          language: _language,
          theme: _calendarTheme,
          title:
              '${TranslationService.getWesternMonthName(_selectedCompleteDate.western.month, _language)} ${_selectedCompleteDate.western.year}',
          subtitle: MyanmarCalendar.formatMyanmar(
            _selectedCompleteDate.myanmar,
            pattern: '&M &y',
            language: _language,
          ),
          showNavigation: false,
        ),
        const SizedBox(height: 12),
        MyanmarDateSummaryCard(
          date: _selectedCompleteDate,
          language: _language,
          theme: _calendarTheme,
          showHolidays: _showHolidays,
          showAstrology: _showAstrology,
        ),
        const SizedBox(height: 12),
        HoroscopeWidget(
          date: _selectedCompleteDate,
          language: _language,
          primaryColor: _calendarTheme.headerBackgroundColor,
          backgroundColor: Colors.white,
        ),
      ],
    );
  }
}
