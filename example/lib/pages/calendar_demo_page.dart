import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class CalendarDemoPage extends StatefulWidget {
  const CalendarDemoPage({super.key});

  @override
  State<CalendarDemoPage> createState() => _CalendarDemoPageState();
}

class _CalendarDemoPageState extends State<CalendarDemoPage> {
  CompleteDate? _selectedDate;
  Language _language = Language.english;
  bool _showHolidays = true;
  bool _showAstrology = true;
  bool _showWesternDates = true;
  bool _showMyanmarDates = true;
  MyanmarCalendarTheme _currentTheme = MyanmarCalendarTheme.defaultTheme();
  String _themeName = 'Default Light';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar Widget Demo'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: _showSettingsDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          // Calendar widget
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(16),
              child: MyanmarCalendarWidget(
                language: _language,
                theme: _currentTheme,
                showHolidays: _showHolidays,
                showAstrology: _showAstrology,
                showWesternDates: _showWesternDates,
                showMyanmarDates: _showMyanmarDates,
                isCompactWeekday: true,
                onDateSelected: (date) {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                highlightToday: true,
                highlightWeekends: true,
                enableSelection: true,
              ),
            ),
          ),

          // Selected date information
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.all(16),
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: _selectedDate != null
                      ? _buildSelectedDateInfo()
                      : Center(
                          child: Text(
                            'Select a date to see details',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),

          // Theme and settings info
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildInfoChip('Theme: $_themeName', Colors.blue),
                _buildInfoChip(
                  'Language: ${_getLanguageName(_language)}',
                  Colors.green,
                ),
                _buildInfoChip(
                  'Features: ${_getEnabledFeatures()}',
                  Colors.orange,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedDateInfo() {
    final date = _selectedDate!;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selected Date Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Divider(),

          // Basic date info
          _buildInfoRow('Sasana Year', date.formatMyanmar(pattern: '&Sy')),
          _buildInfoRow('Myanmar Date', date.formatMyanmar()),
          _buildInfoRow('Western Date', date.formatWestern()),
          _buildInfoRow('Julian Day', '${date.julianDayNumber}'),
          _buildInfoRow('Weekday', _getWeekdayName(date.weekday)),

          // Moon phase and astrological info
          if (date.moonPhase >= 0)
            _buildInfoRow('Moon Phase', _getMoonPhaseName(date.moonPhase)),

          if (date.fortnightDay > 0)
            _buildInfoRow('Fortnight Day', '${date.fortnightDay}'),

          if (date.isSabbath || date.isSabbathEve)
            _buildInfoRow(
              'Sabbath',
              date.isSabbath ? 'Sabbath Day' : 'Sabbath Eve',
            ),

          // Year information
          _buildInfoRow('Myanmar Year', '${date.myanmarYear}'),
          _buildInfoRow('Sasana Year', '${date.sasanaYear}'),
          _buildInfoRow('Year Type', _getYearTypeName(date.yearType)),

          // Holidays
          if (date.hasHolidays) ...[
            SizedBox(height: 8),
            Text('Holidays:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...date.allHolidays.map(
              (holiday) => Padding(
                padding: EdgeInsets.only(left: 8, top: 2),
                child: Text('• $holiday', style: TextStyle(color: Colors.red)),
              ),
            ),
          ],

          // Anniversary Days
          if (date.hasAnniversaryDays) ...[
            SizedBox(height: 8),
            Text(
              'Anniversary Days:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...date.allAnniversaryDays.map(
              (holiday) => Padding(
                padding: EdgeInsets.only(left: 8, top: 2),
                child: Text('• $holiday', style: TextStyle(color: Colors.red)),
              ),
            ),
          ],

          // Astrological information
          if (date.hasAstrologicalDays) ...[
            SizedBox(height: 8),
            Text(
              'Astrological Days:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...date.astrologicalDays.map(
              (day) => Padding(
                padding: EdgeInsets.only(left: 8, top: 2),
                child: Text('• $day', style: TextStyle(color: Colors.purple)),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
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

  void _showSettingsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Calendar Settings'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Language selection
              ListTile(
                title: Text('Language'),
                subtitle: DropdownButton<Language>(
                  value: _language,
                  isExpanded: true,
                  onChanged: (language) {
                    setState(() {
                      _language = language!;
                    });
                    MyanmarCalendar.setLanguage(language!);
                    Navigator.pop(context);
                  },
                  items: Language.values
                      .map(
                        (lang) => DropdownMenuItem(
                          value: lang,
                          child: Text(_getLanguageName(lang)),
                        ),
                      )
                      .toList(),
                ),
              ),

              // Theme selection
              ListTile(
                title: Text('Theme'),
                subtitle: DropdownButton<String>(
                  value: _themeName,
                  isExpanded: true,
                  onChanged: (themeName) {
                    setState(() {
                      _themeName = themeName!;
                      _currentTheme = _getThemeByName(themeName);
                    });
                    Navigator.pop(context);
                  },
                  items:
                      [
                            'Default Light',
                            'Dark Theme',
                            'Blue Theme',
                            'Green Theme',
                            'Red Theme',
                          ]
                          .map(
                            (name) => DropdownMenuItem(
                              value: name,
                              child: Text(name),
                            ),
                          )
                          .toList(),
                ),
              ),

              // Display options
              SwitchListTile(
                title: Text('Show Holidays'),
                value: _showHolidays,
                onChanged: (value) {
                  setState(() {
                    _showHolidays = value;
                  });
                },
              ),

              SwitchListTile(
                title: Text('Show Astrology'),
                value: _showAstrology,
                onChanged: (value) {
                  setState(() {
                    _showAstrology = value;
                  });
                },
              ),

              SwitchListTile(
                title: Text('Show Western Dates'),
                value: _showWesternDates,
                onChanged: (value) {
                  setState(() {
                    _showWesternDates = value;
                  });
                },
              ),

              SwitchListTile(
                title: Text('Show Myanmar Dates'),
                value: _showMyanmarDates,
                onChanged: (value) {
                  setState(() {
                    _showMyanmarDates = value;
                  });
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
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

  String _getMoonPhaseName(int phase) {
    switch (phase) {
      case 0:
        return 'Waxing';
      case 1:
        return 'Full Moon';
      case 2:
        return 'Waning';
      case 3:
        return 'New Moon';
      default:
        return 'Unknown';
    }
  }

  String _getWeekdayName(int weekday) {
    const weekdays = [
      'Saturday',
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
    ];
    return weekdays[weekday % 7];
  }

  String _getYearTypeName(int yearType) {
    switch (yearType) {
      case 0:
        return 'Common Year';
      case 1:
        return 'Little Watat Year';
      case 2:
        return 'Big Watat Year';
      default:
        return 'Unknown';
    }
  }

  String _getEnabledFeatures() {
    final features = <String>[];
    if (_showHolidays) features.add('H');
    if (_showAstrology) features.add('A');
    if (_showWesternDates) features.add('W');
    if (_showMyanmarDates) features.add('M');
    return features.join(', ');
  }

  MyanmarCalendarTheme _getThemeByName(String name) {
    switch (name) {
      case 'Dark Theme':
        return MyanmarCalendarTheme.darkTheme();
      case 'Blue Theme':
        return MyanmarCalendarTheme.fromColor(Colors.blue);
      case 'Green Theme':
        return MyanmarCalendarTheme.fromColor(Colors.green);
      case 'Red Theme':
        return MyanmarCalendarTheme.fromColor(Colors.red);
      default:
        return MyanmarCalendarTheme.defaultTheme();
    }
  }
}
