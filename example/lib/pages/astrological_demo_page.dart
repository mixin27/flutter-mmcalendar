import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class AstrologicalDemoPage extends StatefulWidget {
  const AstrologicalDemoPage({super.key});

  @override
  State<AstrologicalDemoPage> createState() => _AstrologicalDemoPageState();
}

class _AstrologicalDemoPageState extends State<AstrologicalDemoPage> {
  MyanmarDateTime _selectedDate = MyanmarCalendar.today();
  Language _language = Language.english;
  // int _currentYear = DateTime.now().year;
  // int _currentMyanmarYear = MyanmarCalendar.today().myanmarYear;
  int _selectedMonth = MyanmarCalendar.today().myanmarMonth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Astrological Information'),
        backgroundColor: Colors.purple,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateSelector(),
            SizedBox(height: 20),
            _buildAstrologicalInfo(),
            SizedBox(height: 20),
            _buildMoonPhaseInfo(),
            SizedBox(height: 20),
            _buildSabbathInfo(),
            SizedBox(height: 20),
            _buildYearInfo(),
            SizedBox(height: 20),
            _buildMonthView(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.date_range, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  'Selected Date',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),

            Text(
              'Myanmar: ${_selectedDate.formatMyanmar()}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              'Western: ${_selectedDate.formatWestern()}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            Text(
              'Julian Day: ${_selectedDate.julianDay}',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _selectDate,
              icon: Icon(Icons.edit_calendar),
              label: Text('Change Date'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAstrologicalInfo() {
    final astroInfo = _selectedDate.astroInfo;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.star, color: Colors.purple),
                SizedBox(width: 8),
                Text(
                  'Astrological Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),

            _buildAstroItem('Yatyaza', astroInfo.yatyaza, Colors.red),
            _buildAstroItem('Pyathada', astroInfo.pyathada, Colors.orange),
            _buildAstroItem('Naga Head', astroInfo.nagahle, Colors.green),
            _buildAstroItem('Mahabote', astroInfo.mahabote, Colors.blue),
            _buildAstroItem('Nakhat', astroInfo.nakhat, Colors.indigo),
            _buildAstroItem('Year Name', astroInfo.yearName, Colors.purple),

            if (astroInfo.astrologicalDays.isNotEmpty) ...[
              SizedBox(height: 12),
              Text(
                'Astrological Days:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Wrap(
                children: astroInfo.astrologicalDays
                    .map((day) => _buildChip(day, Colors.purple))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAstroItem(String label, String value, Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.w500, color: color),
            ),
          ),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : 'None',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: value.isNotEmpty ? Colors.black87 : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMoonPhaseInfo() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getMoonPhaseIcon(_selectedDate.moonPhase),
                  color: Colors.amber,
                ),
                SizedBox(width: 8),
                Text(
                  'Moon Phase Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),

            Row(
              children: [
                Icon(
                  _getMoonPhaseIcon(_selectedDate.moonPhase),
                  size: 48,
                  color: Colors.amber,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getMoonPhaseName(_selectedDate.moonPhase),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Fortnight Day: ${_selectedDate.fortnightDay}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Month Length: ${_selectedDate.monthLength} days',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Moon phase indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildMoonPhaseIndicator(
                  0,
                  'Waxing',
                  _selectedDate.moonPhase == 0,
                ),
                _buildMoonPhaseIndicator(
                  1,
                  'Full',
                  _selectedDate.moonPhase == 1,
                ),
                _buildMoonPhaseIndicator(
                  2,
                  'Waning',
                  _selectedDate.moonPhase == 2,
                ),
                _buildMoonPhaseIndicator(
                  3,
                  'New',
                  _selectedDate.moonPhase == 3,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMoonPhaseIndicator(int phase, String name, bool isActive) {
    return Column(
      children: [
        Icon(
          _getMoonPhaseIcon(phase),
          size: 32,
          color: isActive ? Colors.amber : Colors.grey[400],
        ),
        SizedBox(height: 4),
        Text(
          name,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? Colors.amber[800] : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSabbathInfo() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.brightness_6, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  'Sabbath Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),

            if (_selectedDate.isSabbath) ...[
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.orange.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.brightness_high, color: Colors.orange),
                    SizedBox(width: 8),
                    Text(
                      'Today is a Sabbath Day',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange[800],
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (_selectedDate.isSabbathEve) ...[
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.orange.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.brightness_6, color: Colors.orange),
                    SizedBox(width: 8),
                    Text(
                      'Today is Sabbath Eve',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange[700],
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Text(
                'This is not a Sabbath day',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ],

            SizedBox(height: 12),
            Text(
              'Sabbath Status: ${_selectedDate.sabbath}',
              style: TextStyle(fontSize: 14),
            ),

            // Show next sabbath days
            SizedBox(height: 16),
            Text(
              'Upcoming Sabbath Days in ${_getMonthName(_selectedDate.myanmarMonth)}:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            FutureBuilder<List<MyanmarDateTime>>(
              future: _getSabbathDaysInMonth(
                _selectedDate.myanmarYear,
                _selectedDate.myanmarMonth,
              ),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final sabbathDays = snapshot.data!;
                  return Wrap(
                    children: sabbathDays
                        .map(
                          (date) => _buildDateChip(
                            '${date.myanmarDay}',
                            Colors.orange,
                            date.isSameDay(_selectedDate),
                          ),
                        )
                        .toList(),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildYearInfo() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.indigo),
                SizedBox(width: 8),
                Text(
                  'Year Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Myanmar Year: ${_selectedDate.myanmarYear}'),
                      Text('Sasana Year: ${_selectedDate.sasanaYear}'),
                      Text(
                        'Year Type: ${_getYearTypeName(_selectedDate.yearType)}',
                      ),
                    ],
                  ),
                ),
                Icon(
                  _selectedDate.isWatatYear ? Icons.star : Icons.star_border,
                  size: 48,
                  color: _selectedDate.isWatatYear ? Colors.amber : Colors.grey,
                ),
              ],
            ),

            if (_selectedDate.isWatatYear) ...[
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.amber.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  '${_selectedDate.myanmarYear} is a ${_selectedDate.isBigWatatYear ? 'Big' : 'Little'} Watat Year\n'
                  'This year has an intercalary month.',
                  style: TextStyle(
                    color: Colors.amber[800],
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMonthView() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_month, color: Colors.teal),
                SizedBox(width: 8),
                Text(
                  '${_getMonthName(_selectedMonth)} ${_selectedDate.myanmarYear}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      _selectedMonth = (_selectedMonth - 1 + 15) % 15;
                      if (_selectedMonth == 0) {
                        _selectedMonth = 14; // Handle 0 case
                      }
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      _selectedMonth = (_selectedMonth % 14) + 1;
                    });
                  },
                ),
              ],
            ),
            Divider(),

            FutureBuilder<List<MyanmarDateTime>>(
              future: _getMonthDates(_selectedDate.myanmarYear, _selectedMonth),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final monthDates = snapshot.data!;
                  return _buildMonthGrid(monthDates);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthGrid(List<MyanmarDateTime> dates) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1.0,
      ),
      itemCount: dates.length,
      itemBuilder: (context, index) {
        final date = dates[index];
        final isSelected = date.isSameDay(_selectedDate);
        final isToday = date.isSameDay(MyanmarCalendar.today());

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = date;
            });
          },
          child: Container(
            margin: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: isSelected
                  ? Colors.purple
                  : isToday
                  ? Colors.purple.withValues(alpha: 0.3)
                  : date.isSabbath
                  ? Colors.orange.withValues(alpha: 0.2)
                  : date.isFullMoon
                  ? Colors.amber.withValues(alpha: 0.2)
                  : date.isNewMoon
                  ? Colors.indigo.withValues(alpha: 0.2)
                  : null,
              borderRadius: BorderRadius.circular(4),
              border: isToday && !isSelected
                  ? Border.all(color: Colors.purple, width: 2)
                  : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${date.myanmarDay}',
                  style: TextStyle(
                    fontWeight: isSelected || isToday
                        ? FontWeight.bold
                        : FontWeight.normal,
                    color: isSelected ? Colors.white : Colors.black87,
                    fontSize: 12,
                  ),
                ),
                if (date.isSabbath)
                  Icon(Icons.brightness_6, size: 8, color: Colors.orange),
                if (date.isFullMoon)
                  Icon(Icons.brightness_1, size: 8, color: Colors.amber),
                if (date.isNewMoon)
                  Icon(Icons.brightness_2, size: 8, color: Colors.indigo),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      margin: EdgeInsets.only(right: 8, top: 4),
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
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildDateChip(String label, Color color, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(right: 4, top: 4),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected ? color : color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? color : color.withValues(alpha: 0.3),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : color,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
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
        // _selectedDate = MyanmarDateTime.fromMyanmarDate(selected.myanmar);

        // todo(mixin27): there is a slight miss calculation
        // Expected:
        //  MyanmarDate(year: 1387, month: 7, day: 15, yearType: 0,
        //    moonPhase: 1, fortnightDay: 15, weekday: 2, julianDayNumber: 2460955.0,
        //    sasanaYear: 2569, monthLength: 29)
        // Result:
        // MyanmarDate(year: 1387, month: 7, day: 14, yearType: 0,
        //  moonPhase: 0, fortnightDay: 14, weekday: 1, julianDayNumber: 2460954.2291666665,
        //  sasanaYear: 2569, monthLength: 29)
        _selectedDate = MyanmarDateTime.fromDateTime(
          selected.western.toDateTime(),
        );
      });
    }
  }

  // Helper methods
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

  IconData _getMoonPhaseIcon(int moonPhase) {
    switch (moonPhase) {
      case 0: // Waxing
        return Icons.brightness_3;
      case 1: // Full moon
        return Icons.brightness_1;
      case 2: // Waning
        return Icons.brightness_4;
      case 3: // New moon
        return Icons.brightness_2;
      default:
        return Icons.brightness_6;
    }
  }

  String _getMoonPhaseName(int moonPhase) {
    switch (moonPhase) {
      case 0:
        return 'Waxing Moon';
      case 1:
        return 'Full Moon';
      case 2:
        return 'Waning Moon';
      case 3:
        return 'New Moon';
      default:
        return 'Unknown';
    }
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

  String _getMonthName(int month) {
    const monthNames = [
      'Tagu',
      'Kason',
      'Nayon',
      'Waso',
      'Wagaung',
      'Tawthalin',
      'Thadingyut',
      'Tazaungmon',
      'Nadaw',
      'Pyatho',
      'Tabodwe',
      'Tabaung',
      'Late Tagu',
      'Late Kason',
      'Late Nayon',
    ];
    return month >= 1 && month <= monthNames.length
        ? monthNames[month - 1]
        : 'Unknown';
  }

  Future<List<MyanmarDateTime>> _getSabbathDaysInMonth(
    int year,
    int month,
  ) async {
    return MyanmarCalendar.findSabbathDays(year, month);
  }

  Future<List<MyanmarDateTime>> _getMonthDates(int year, int month) async {
    final myanmarDates = MyanmarCalendar.getMyanmarMonth(year, month);
    return myanmarDates
        .map((date) => MyanmarDateTime.fromMyanmarDate(date))
        .toList();
  }
}
