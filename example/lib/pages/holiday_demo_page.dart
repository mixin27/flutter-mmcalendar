import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class HolidayDemoPage extends StatefulWidget {
  const HolidayDemoPage({super.key});

  @override
  State<HolidayDemoPage> createState() => _HolidayDemoPageState();
}

class _HolidayDemoPageState extends State<HolidayDemoPage> {
  MyanmarDateTime _selectedDate = MyanmarCalendar.today();
  Language _language = Language.english;
  int _selectedYear = MyanmarCalendar.today().myanmarYear;
  final List<MyanmarDateTime> _holidaysInYear = [];
  bool _showPublicHolidays = true;
  bool _showReligiousHolidays = true;
  bool _showCulturalHolidays = true;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _loadHolidaysForYear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Holiday Information'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: Icon(Icons.calendar_today), onPressed: _selectDate),
          PopupMenuButton<Language>(
            icon: Icon(Icons.language),
            onSelected: (language) {
              setState(() {
                _language = language;
              });
              MyanmarCalendar.setLanguage(language);
            },
            itemBuilder: (context) => Language.values.map((lang) {
              return PopupMenuItem(
                value: lang,
                child: Text(_getLanguageName(lang)),
              );
            }).toList(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildControls(),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDateInfo(),
                  SizedBox(height: 20),
                  _buildHolidayFilters(),
                  SizedBox(height: 20),
                  _buildYearlyHolidays(),
                  SizedBox(height: 20),
                  _buildUpcomingHolidays(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToToday,
        backgroundColor: Colors.green,
        tooltip: 'Go to Today',
        child: Icon(Icons.today, color: Colors.white),
      ),
    );
  }

  Widget _buildControls() {
    return Container(
      padding: EdgeInsets.all(16),
      color: Colors.green.shade50,
      child: Column(
        children: [
          // Year selector
          Row(
            children: [
              Text(
                'Year: ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    _selectedYear--;
                    _loadHolidaysForYear();
                  });
                },
              ),
              Text(
                '$_selectedYear',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    _selectedYear++;
                    _loadHolidaysForYear();
                  });
                },
              ),
              Spacer(),
              Text(
                'Western: ${_getWesternYear(_selectedYear)}',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),

          // Search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search holidays...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onChanged: (value) {
              setState(() {
                _searchText = value.toLowerCase();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDateInfo() {
    final holidayInfo = _selectedDate.holidayInfo;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.event, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Selected Date Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),

            // Date display
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Myanmar: ${_selectedDate.formatMyanmar()}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'Western: ${_selectedDate.formatWestern()}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Holiday information for selected date
            if (holidayInfo.hasHolidays) ...[
              Text(
                'Holidays on this date:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
              SizedBox(height: 8),

              if (holidayInfo.publicHolidays.isNotEmpty) ...[
                _buildHolidaySection(
                  'Public Holidays',
                  holidayInfo.publicHolidays,
                  Colors.red,
                ),
              ],

              if (holidayInfo.religiousHolidays.isNotEmpty) ...[
                _buildHolidaySection(
                  'Religious Holidays',
                  holidayInfo.religiousHolidays,
                  Colors.orange,
                ),
              ],

              if (holidayInfo.culturalHolidays.isNotEmpty) ...[
                _buildHolidaySection(
                  'Cultural Holidays',
                  holidayInfo.culturalHolidays,
                  Colors.blue,
                ),
              ],
            ] else ...[
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'No holidays on this date',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],

            SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _selectDate,
              icon: Icon(Icons.edit_calendar),
              label: Text('Change Date'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHolidaySection(
    String title,
    List<String> holidays,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
        SizedBox(height: 4),
        ...holidays.map(
          (holiday) => Container(
            margin: EdgeInsets.only(bottom: 4),
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Text(
              TranslationService.translate(holiday),
              style: TextStyle(color: color),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHolidayFilters() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.filter_list, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Holiday Filters',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),

            CheckboxListTile(
              title: Text('Public Holidays'),
              subtitle: Text('Government declared holidays'),
              value: _showPublicHolidays,
              onChanged: (value) {
                setState(() {
                  _showPublicHolidays = value ?? true;
                  _loadHolidaysForYear();
                });
              },
              activeColor: Colors.red,
              controlAffinity: ListTileControlAffinity.leading,
            ),

            CheckboxListTile(
              title: Text('Religious Holidays'),
              subtitle: Text('Buddhist and traditional holidays'),
              value: _showReligiousHolidays,
              onChanged: (value) {
                setState(() {
                  _showReligiousHolidays = value ?? true;
                  _loadHolidaysForYear();
                });
              },
              activeColor: Colors.orange,
              controlAffinity: ListTileControlAffinity.leading,
            ),

            CheckboxListTile(
              title: Text('Cultural Holidays'),
              subtitle: Text('Festivals and cultural events'),
              value: _showCulturalHolidays,
              onChanged: (value) {
                setState(() {
                  _showCulturalHolidays = value ?? true;
                  _loadHolidaysForYear();
                });
              },
              activeColor: Colors.blue,
              controlAffinity: ListTileControlAffinity.leading,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearlyHolidays() {
    final filteredHolidays = _getFilteredHolidays();

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.event_note, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Holidays in $_selectedYear',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Text(
                  '${filteredHolidays.length} holidays',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
              ],
            ),
            Divider(),

            if (filteredHolidays.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'No holidays found for the selected filters',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ] else ...[
              ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredHolidays.length,
                separatorBuilder: (context, index) => Divider(height: 1),
                itemBuilder: (context, index) {
                  final holiday = filteredHolidays[index];
                  return _buildHolidayTile(holiday);
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHolidayTile(MyanmarDateTime holiday) {
    final holidayInfo = holiday.holidayInfo;
    final isToday = holiday.isSameDay(MyanmarCalendar.today());
    final isPast = holiday.isBefore(MyanmarCalendar.today());

    return ListTile(
      leading: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 4,
          children: [
            Text(
              CalendarUtils.convertNumberToLanguage(
                holiday.myanmarDay.toDouble(),
              ),
              // '${holiday.myanmarDay}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isToday
                    ? Colors.green
                    : (isPast ? Colors.grey : Colors.black),
              ),
            ),
            FittedBox(
              child: Text(
                TranslationService.getMonthName(holiday.myanmarMonth),
                // _getMonthAbbreviation(holiday.myanmarMonth),
                style: TextStyle(
                  fontSize: 12,

                  color: isToday
                      ? Colors.green
                      : (isPast ? Colors.grey : Colors.black54),
                ),
              ),
            ),
          ],
        ),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...holidayInfo.allHolidays.map(
            (h) => Text(
              TranslationService.translate(h),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isToday
                    ? Colors.green
                    : (isPast ? Colors.grey : Colors.black87),
              ),
            ),
          ),
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${holiday.formatMyanmar()} • ${holiday.formatWestern()}',
            style: TextStyle(
              fontSize: 12,
              color: isToday
                  ? Colors.green[600]
                  : (isPast ? Colors.grey : Colors.grey[600]),
            ),
          ),
          SizedBox(height: 4),
          Wrap(
            spacing: 4,
            children: [
              if (holidayInfo.publicHolidays.isNotEmpty && _showPublicHolidays)
                _buildHolidayTypeChip('Public', Colors.red),
              if (holidayInfo.religiousHolidays.isNotEmpty &&
                  _showReligiousHolidays)
                _buildHolidayTypeChip('Religious', Colors.orange),
              if (holidayInfo.culturalHolidays.isNotEmpty &&
                  _showCulturalHolidays)
                _buildHolidayTypeChip('Cultural', Colors.blue),
            ],
          ),
        ],
      ),
      trailing: isToday
          ? Icon(Icons.today, color: Colors.green)
          : isPast
          ? Icon(Icons.history, color: Colors.grey)
          : Icon(Icons.event, color: Colors.grey),
      onTap: () {
        setState(() {
          _selectedDate = holiday;
        });
      },
    );
  }

  Widget _buildHolidayTypeChip(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 0.5),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildUpcomingHolidays() {
    final upcomingHolidays = _getUpcomingHolidays(5);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.upcoming, color: Colors.green),
                SizedBox(width: 8),
                Text(
                  'Upcoming Holidays',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),

            if (upcomingHolidays.isEmpty) ...[
              Container(
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'No upcoming holidays in the next few months',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ] else ...[
              ...upcomingHolidays.map((holiday) {
                final daysUntil = holiday.differenceInDays(
                  MyanmarCalendar.today(),
                );
                return Container(
                  margin: EdgeInsets.only(bottom: 12),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.green.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: holiday.holidayInfo.allHolidays
                                  .map(
                                    (h) => Text(
                                      TranslationService.translate(h),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '$daysUntil days',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4),
                      Text(
                        '${holiday.formatMyanmar()} • ${holiday.formatWestern()}',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ],
        ),
      ),
    );
  }

  // Helper methods
  void _loadHolidaysForYear() {
    _holidaysInYear.clear();

    // Load holidays for all months in the year
    for (int month = 1; month <= 14; month++) {
      try {
        final monthDates = MyanmarCalendar.getMyanmarMonth(
          _selectedYear,
          month,
        );
        for (final date in monthDates) {
          final myanmarDateTime = MyanmarDateTime.fromMyanmarDate(date);
          if (myanmarDateTime.hasHolidays) {
            _holidaysInYear.add(myanmarDateTime);
          }
        }
      } catch (e) {
        // Handle invalid months (e.g., month 14 in non-watat years)
        continue;
      }
    }

    // Sort holidays by date
    _holidaysInYear.sort((a, b) => a.compareTo(b));
  }

  List<MyanmarDateTime> _getFilteredHolidays() {
    return _holidaysInYear.where((holiday) {
      final holidayInfo = holiday.holidayInfo;

      // Apply type filters
      bool matchesFilter = false;
      if (_showPublicHolidays && holidayInfo.publicHolidays.isNotEmpty) {
        matchesFilter = true;
      }
      if (_showReligiousHolidays && holidayInfo.religiousHolidays.isNotEmpty) {
        matchesFilter = true;
      }
      if (_showCulturalHolidays && holidayInfo.culturalHolidays.isNotEmpty) {
        matchesFilter = true;
      }

      if (!matchesFilter) return false;

      // Apply search filter
      if (_searchText.isNotEmpty) {
        final allHolidayNames = holidayInfo.allHolidays.join(' ').toLowerCase();
        return allHolidayNames.contains(_searchText);
      }

      return true;
    }).toList();
  }

  List<MyanmarDateTime> _getUpcomingHolidays(int count) {
    final today = MyanmarCalendar.today();
    final upcoming = _holidaysInYear
        .where((holiday) => holiday.isAfter(today))
        .take(count)
        .toList();

    // If we don't have enough in current year, look at next year
    if (upcoming.length < count) {
      final nextYearHolidays = <MyanmarDateTime>[];
      final nextYear = _selectedYear + 1;

      for (int month = 1; month <= 14; month++) {
        try {
          final monthDates = MyanmarCalendar.getMyanmarMonth(nextYear, month);
          for (final date in monthDates) {
            final myanmarDateTime = MyanmarDateTime.fromMyanmarDate(date);
            if (myanmarDateTime.hasHolidays) {
              nextYearHolidays.add(myanmarDateTime);
            }
          }
        } catch (e) {
          continue;
        }
      }

      nextYearHolidays.sort((a, b) => a.compareTo(b));
      upcoming.addAll(nextYearHolidays.take(count - upcoming.length));
    }

    return upcoming;
  }

  Future<void> _selectDate() async {
    final selected = await showMyanmarDatePicker(
      context: context,
      initialDate: _selectedDate.toDateTime(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      language: _language,
    );

    if (selected != null) {
      setState(() {
        _selectedDate = MyanmarDateTime.fromDateTime(
          selected.western.toDateTime(),
        );
        _selectedYear = _selectedDate.myanmarYear;
        _loadHolidaysForYear();
      });
    }
  }

  void _goToToday() {
    final today = MyanmarCalendar.today();
    setState(() {
      _selectedDate = today;
      _selectedYear = today.myanmarYear;
      _loadHolidaysForYear();
    });
  }

  String _getLanguageName(Language language) {
    switch (language) {
      case Language.myanmar:
        return 'မြန်မာ';
      case Language.english:
        return 'English';
      case Language.zawgyi:
        return 'Zawgyi';
      case Language.mon:
        return 'Mon';
      case Language.shan:
        return 'Shan';
      case Language.karen:
        return 'Karen';
    }
  }

  int _getWesternYear(int myanmarYear) {
    // Approximate conversion - Myanmar year starts around March/April
    return myanmarYear + 638;
  }
}
