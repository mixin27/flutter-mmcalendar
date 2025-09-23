import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class ConverterDemoPage extends StatefulWidget {
  const ConverterDemoPage({super.key});

  @override
  State<ConverterDemoPage> createState() => _ConverterDemoPageState();
}

class _ConverterDemoPageState extends State<ConverterDemoPage> {
  final _westernYearController = TextEditingController();
  final _westernMonthController = TextEditingController();
  final _westernDayController = TextEditingController();

  final _myanmarYearController = TextEditingController();
  final _myanmarMonthController = TextEditingController();
  final _myanmarDayController = TextEditingController();

  final _dateStringController = TextEditingController();

  MyanmarDateTime? _convertedDate;
  String? _errorMessage;
  Language _language = Language.english;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _initializeWithToday();
  }

  void _initializeWithToday() {
    final today = MyanmarCalendar.today();
    _westernYearController.text = today.westernYear.toString();
    _westernMonthController.text = today.westernMonth.toString();
    _westernDayController.text = today.westernDay.toString();

    _myanmarYearController.text = today.myanmarYear.toString();
    _myanmarMonthController.text = today.myanmarMonth.toString();
    _myanmarDayController.text = today.myanmarDay.toString();

    _convertedDate = today;
  }

  @override
  void dispose() {
    _westernYearController.dispose();
    _westernMonthController.dispose();
    _westernDayController.dispose();
    _myanmarYearController.dispose();
    _myanmarMonthController.dispose();
    _myanmarDayController.dispose();
    _dateStringController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Converter'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          Text(_getLanguageName(_language)),
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
          // Tab selector
          Container(
            color: Colors.grey[100],
            child: Row(
              children: [
                Expanded(child: _buildTabButton('Western → Myanmar', 0)),
                Expanded(child: _buildTabButton('Myanmar → Western', 1)),
                Expanded(child: _buildTabButton('Parse Strings', 2)),
              ],
            ),
          ),

          // Input section
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: _buildInputSection(),
            ),
          ),

          // Result section
          if (_convertedDate != null || _errorMessage != null)
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.all(16),
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: _buildResultSection(),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String text, int index) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
          _clearResults();
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.indigo : Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.indigo : Colors.grey[300]!,
              width: 2,
            ),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildInputSection() {
    switch (_selectedTab) {
      case 0:
        return _buildWesternToMyanmarInput();
      case 1:
        return _buildMyanmarToWesternInput();
      case 2:
        return _buildStringParsingInput();
      default:
        return Container();
    }
  }

  Widget _buildWesternToMyanmarInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Western Date',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _westernYearController,
                decoration: InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(),
                  hintText: '2024',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _westernMonthController,
                decoration: InputDecoration(
                  labelText: 'Month',
                  border: OutlineInputBorder(),
                  hintText: '1-12',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _westernDayController,
                decoration: InputDecoration(
                  labelText: 'Day',
                  border: OutlineInputBorder(),
                  hintText: '1-31',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        ),

        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _convertWesternToMyanmar,
                child: Text('Convert to Myanmar'),
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(onPressed: _setToday, child: Text('Today')),
          ],
        ),
      ],
    );
  }

  Widget _buildMyanmarToWesternInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Enter Myanmar Date',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _myanmarYearController,
                decoration: InputDecoration(
                  labelText: 'Year',
                  border: OutlineInputBorder(),
                  hintText: '1385',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _myanmarMonthController,
                decoration: InputDecoration(
                  labelText: 'Month',
                  border: OutlineInputBorder(),
                  hintText: '0-14',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _myanmarDayController,
                decoration: InputDecoration(
                  labelText: 'Day',
                  border: OutlineInputBorder(),
                  hintText: '1-30',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
          ],
        ),

        SizedBox(height: 8),
        Text(
          'Note: Month 0-14 (0=Tagu, 1=Kason, etc., 13-14=Watat months)',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),

        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _convertMyanmarToWestern,
                child: Text('Convert to Western'),
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(onPressed: _setToday, child: Text('Today')),
          ],
        ),
      ],
    );
  }

  Widget _buildStringParsingInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Parse Date Strings',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),

        TextField(
          controller: _dateStringController,
          decoration: InputDecoration(
            labelText: 'Date String',
            border: OutlineInputBorder(),
            hintText: 'e.g., "1385/10/1" or "2024-01-01"',
          ),
        ),

        SizedBox(height: 8),
        Text(
          'Supported formats:\n'
          '• Myanmar: "1385/10/1", "1385-10-1", "1.10.1385"\n'
          '• Western: "2024-01-01", "01/01/2024", etc.',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),

        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _parseAsMyanmar,
                child: Text('Parse as Myanmar'),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: _parseAsWestern,
                child: Text('Parse as Western'),
              ),
            ),
          ],
        ),

        SizedBox(height: 8),
        ElevatedButton(
          onPressed: _clearAll,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey[300],
            foregroundColor: Colors.black87,
          ),
          child: Text('Clear All'),
        ),
      ],
    );
  }

  Widget _buildResultSection() {
    if (_errorMessage != null) {
      return Column(
        children: [
          Icon(Icons.error, color: Colors.red, size: 48),
          SizedBox(height: 16),
          Text(
            'Error',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
          SizedBox(height: 8),
          Text(
            _errorMessage!,
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
        ],
      );
    }

    if (_convertedDate == null) {
      return Center(child: Text('No date to display'));
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green),
              SizedBox(width: 8),
              Text(
                'Conversion Result',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Divider(),

          // Basic information
          _buildResultCard('Date Information', [
            'Myanmar Date: ${_convertedDate!.formatMyanmar()}',
            'Western Date: ${_convertedDate!.formatWestern()}',
            'Julian Day: ${_convertedDate!.julianDay}',
            'Weekday: ${_getWeekdayName(_convertedDate!.weekday)}',
          ], Colors.blue),

          SizedBox(height: 16),

          // Calendar information
          _buildResultCard('Calendar Information', [
            'Myanmar Year: ${_convertedDate!.myanmarYear}',
            'Sasana Year: ${_convertedDate!.sasanaYear}',
            'Year Type: ${_getYearTypeName(_convertedDate!.yearType)}',
            'Moon Phase: ${_getMoonPhaseName(_convertedDate!.moonPhase)}',
            'Fortnight Day: ${_convertedDate!.fortnightDay}',
            'Month Length: ${_convertedDate!.monthLength} days',
          ], Colors.indigo),

          if (_convertedDate!.hasHolidays || _convertedDate!.isSabbath) ...[
            SizedBox(height: 16),
            _buildResultCard('Special Days', [
              if (_convertedDate!.isSabbath) 'Sabbath Day',
              if (_convertedDate!.isSabbathEve) 'Sabbath Eve',
              ..._convertedDate!.allHolidays,
            ], Colors.red),
          ],

          if (_convertedDate!.hasAstrologicalDays) ...[
            SizedBox(height: 16),
            _buildResultCard(
              'Astrological Information',
              _convertedDate!.astrologicalDays,
              Colors.purple,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildResultCard(String title, List<String> items, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info, color: color, size: 20),
                SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
              ],
            ),
            SizedBox(height: 8),
            ...items.map(
              (item) => Padding(
                padding: EdgeInsets.symmetric(vertical: 2),
                child: Text('• $item', style: TextStyle(fontSize: 13)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _convertWesternToMyanmar() {
    try {
      final year = int.tryParse(_westernYearController.text);
      final month = int.tryParse(_westernMonthController.text);
      final day = int.tryParse(_westernDayController.text);

      if (year == null || month == null || day == null) {
        _setError('Please enter valid numbers for year, month, and day');
        return;
      }

      if (year < 1 || year > 9999) {
        _setError('Year must be between 1 and 9999');
        return;
      }

      if (month < 1 || month > 12) {
        _setError('Month must be between 1 and 12');
        return;
      }

      if (day < 1 || day > 31) {
        _setError('Day must be between 1 and 31');
        return;
      }

      final myanmarDate = MyanmarCalendar.fromWestern(year, month, day);

      // Update Myanmar inputs
      _myanmarYearController.text = myanmarDate.myanmarYear.toString();
      _myanmarMonthController.text = myanmarDate.myanmarMonth.toString();
      _myanmarDayController.text = myanmarDate.myanmarDay.toString();

      setState(() {
        _convertedDate = myanmarDate;
        _errorMessage = null;
      });
    } catch (e) {
      _setError('Conversion failed: ${e.toString()}');
    }
  }

  void _convertMyanmarToWestern() {
    try {
      final year = int.tryParse(_myanmarYearController.text);
      final month = int.tryParse(_myanmarMonthController.text);
      final day = int.tryParse(_myanmarDayController.text);

      if (year == null || month == null || day == null) {
        _setError('Please enter valid numbers for year, month, and day');
        return;
      }

      // Validate Myanmar date
      final validation = MyanmarCalendar.validateMyanmar(year, month, day);
      if (!validation.isValid) {
        _setError('Invalid Myanmar date: ${validation.error}');
        return;
      }

      final myanmarDate = MyanmarCalendar.fromMyanmar(year, month, day);

      // Update Western inputs
      _westernYearController.text = myanmarDate.westernYear.toString();
      _westernMonthController.text = myanmarDate.westernMonth.toString();
      _westernDayController.text = myanmarDate.westernDay.toString();

      setState(() {
        _convertedDate = myanmarDate;
        _errorMessage = null;
      });
    } catch (e) {
      _setError('Conversion failed: ${e.toString()}');
    }
  }

  void _parseAsMyanmar() {
    final dateString = _dateStringController.text.trim();
    if (dateString.isEmpty) {
      _setError('Please enter a date string');
      return;
    }

    try {
      final myanmarDate = MyanmarCalendar.parseMyanmar(dateString);
      if (myanmarDate == null) {
        _setError(
          'Unable to parse "$dateString" as Myanmar date.\n\nSupported formats:\n• 1385/10/1\n• 1385-10-1\n• 1.10.1385',
        );
        return;
      }

      // Update all inputs
      _myanmarYearController.text = myanmarDate.myanmarYear.toString();
      _myanmarMonthController.text = myanmarDate.myanmarMonth.toString();
      _myanmarDayController.text = myanmarDate.myanmarDay.toString();

      _westernYearController.text = myanmarDate.westernYear.toString();
      _westernMonthController.text = myanmarDate.westernMonth.toString();
      _westernDayController.text = myanmarDate.westernDay.toString();

      setState(() {
        _convertedDate = myanmarDate;
        _errorMessage = null;
      });
    } catch (e) {
      _setError('Parsing failed: ${e.toString()}');
    }
  }

  void _parseAsWestern() {
    final dateString = _dateStringController.text.trim();
    if (dateString.isEmpty) {
      _setError('Please enter a date string');
      return;
    }

    try {
      final westernDate = MyanmarCalendar.parseWestern(dateString);
      if (westernDate == null) {
        _setError(
          'Unable to parse "$dateString" as Western date.\n\nSupported formats:\n• 2024-01-01\n• 01/01/2024\n• 2024-1-1',
        );
        return;
      }

      // Update all inputs
      _westernYearController.text = westernDate.westernYear.toString();
      _westernMonthController.text = westernDate.westernMonth.toString();
      _westernDayController.text = westernDate.westernDay.toString();

      _myanmarYearController.text = westernDate.myanmarYear.toString();
      _myanmarMonthController.text = westernDate.myanmarMonth.toString();
      _myanmarDayController.text = westernDate.myanmarDay.toString();

      setState(() {
        _convertedDate = westernDate;
        _errorMessage = null;
      });
    } catch (e) {
      _setError('Parsing failed: ${e.toString()}');
    }
  }

  void _setToday() {
    _initializeWithToday();
    setState(() {
      _errorMessage = null;
    });
  }

  void _clearAll() {
    _westernYearController.clear();
    _westernMonthController.clear();
    _westernDayController.clear();
    _myanmarYearController.clear();
    _myanmarMonthController.clear();
    _myanmarDayController.clear();
    _dateStringController.clear();

    setState(() {
      _convertedDate = null;
      _errorMessage = null;
    });
  }

  void _clearResults() {
    setState(() {
      _convertedDate = null;
      _errorMessage = null;
    });
  }

  void _setError(String message) {
    setState(() {
      _errorMessage = message;
      _convertedDate = null;
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
}
