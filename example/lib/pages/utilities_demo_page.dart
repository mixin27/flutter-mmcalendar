import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class UtilitiesDemoPage extends StatefulWidget {
  const UtilitiesDemoPage({super.key});

  @override
  State<UtilitiesDemoPage> createState() => _UtilitiesDemoPageState();
}

class _UtilitiesDemoPageState extends State<UtilitiesDemoPage> {
  Language _language = Language.english;

  // Date calculation
  final _date1Controller = TextEditingController();
  final _date2Controller = TextEditingController();
  String _dateDifferenceResult = '';

  // Date arithmetic
  final _baseDateController = TextEditingController();
  final _daysToAddController = TextEditingController(text: '0');
  final _monthsToAddController = TextEditingController(text: '0');
  String _arithmeticResult = '';

  // Batch operations
  final _batchDatesController = TextEditingController();
  List<MyanmarDateTime> _batchResults = [];

  // Find operations
  int _targetMoonPhase = 1; // Full moon
  final _searchStartDateController = TextEditingController();
  String _findResult = '';

  // Validation
  final _yearController = TextEditingController();
  final _monthController = TextEditingController();
  final _dayController = TextEditingController();
  String _validationResult = '';

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    final today = MyanmarCalendar.today();
    _date1Controller.text = today.formatWestern();
    _date2Controller.text = today.addDays(30).formatWestern();
    _baseDateController.text = today.formatWestern("%y-%mm-%dd");
    _searchStartDateController.text = today.formatWestern();
    _yearController.text = today.myanmarYear.toString();
    _monthController.text = today.myanmarMonth.toString();
    _dayController.text = today.myanmarDay.toString();
  }

  @override
  void dispose() {
    _date1Controller.dispose();
    _date2Controller.dispose();
    _baseDateController.dispose();
    _daysToAddController.dispose();
    _monthsToAddController.dispose();
    _batchDatesController.dispose();
    _searchStartDateController.dispose();
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Utility Functions'),
        backgroundColor: Colors.teal,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateCalculations(),
            SizedBox(height: 20),
            _buildDateArithmetic(),
            SizedBox(height: 20),
            _buildBatchOperations(),
            SizedBox(height: 20),
            _buildFindOperations(),
            SizedBox(height: 20),
            _buildValidationUtilities(),
            SizedBox(height: 20),
            _buildPackageInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateCalculations() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.calculate, color: Colors.teal),
                SizedBox(width: 8),
                Text(
                  'Date Calculations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),

            // Date inputs
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _date1Controller,
                    decoration: InputDecoration(
                      labelText: 'First Date',
                      hintText: 'YYYY-MM-DD',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDateForField(_date1Controller),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _date2Controller,
                    decoration: InputDecoration(
                      labelText: 'Second Date',
                      hintText: 'YYYY-MM-DD',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.calendar_today),
                        onPressed: () => _selectDateForField(_date2Controller),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Calculate button
            ElevatedButton.icon(
              onPressed: _calculateDateDifference,
              icon: Icon(Icons.calculate),
              label: Text('Calculate Difference'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),

            // Result
            if (_dateDifferenceResult.isNotEmpty) ...[
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Result:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[700],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(_dateDifferenceResult),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildDateArithmetic() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.add_circle_outline, color: Colors.teal),
                SizedBox(width: 8),
                Text(
                  'Date Arithmetic',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),

            // Base date input
            TextField(
              controller: _baseDateController,
              decoration: InputDecoration(
                labelText: 'Base Date',
                hintText: 'YYYY-MM-DD',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () => _selectDateForField(_baseDateController),
                ),
              ),
            ),

            SizedBox(height: 16),

            // Days and months to add
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _daysToAddController,
                    decoration: InputDecoration(
                      labelText: 'Days to Add',
                      hintText: '0',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _monthsToAddController,
                    decoration: InputDecoration(
                      labelText: 'Months to Add',
                      hintText: '0',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^-?\d*')),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Calculate button
            ElevatedButton.icon(
              onPressed: _performDateArithmetic,
              icon: Icon(Icons.add),
              label: Text('Calculate'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),

            // Result
            if (_arithmeticResult.isNotEmpty) ...[
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Result:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[700],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(_arithmeticResult),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildBatchOperations() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.batch_prediction, color: Colors.teal),
                SizedBox(width: 8),
                Text(
                  'Batch Operations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),

            // Batch dates input
            TextField(
              controller: _batchDatesController,
              decoration: InputDecoration(
                labelText: 'Dates (one per line)',
                hintText: '2024-01-01\n2024-02-15\n2024-03-30',
                helperText: 'Enter Western dates in YYYY-MM-DD format',
              ),
              maxLines: 5,
            ),

            SizedBox(height: 16),

            // Process button
            ElevatedButton.icon(
              onPressed: _processBatchDates,
              icon: Icon(Icons.batch_prediction),
              label: Text('Process Batch'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),

            // Results
            if (_batchResults.isNotEmpty) ...[
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Results (${_batchResults.length} dates):',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[700],
                      ),
                    ),
                    SizedBox(height: 8),
                    ..._batchResults.map(
                      (date) => Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(
                          '${date.formatWestern()} → ${date.formatMyanmar()}',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFindOperations() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.search, color: Colors.teal),
                SizedBox(width: 8),
                Text(
                  'Find Operations',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),

            // Moon phase selector
            Row(
              children: [
                Text('Find next: '),
                SizedBox(width: 8),
                DropdownButton<int>(
                  value: _targetMoonPhase,
                  items: [
                    DropdownMenuItem(value: 0, child: Text('🌒 Waxing Moon')),
                    DropdownMenuItem(value: 1, child: Text('🌕 Full Moon')),
                    DropdownMenuItem(value: 2, child: Text('🌘 Waning Moon')),
                    DropdownMenuItem(value: 3, child: Text('🌑 New Moon')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _targetMoonPhase = value ?? 1;
                    });
                  },
                ),
              ],
            ),

            SizedBox(height: 16),

            // Start date input
            TextField(
              controller: _searchStartDateController,
              decoration: InputDecoration(
                labelText: 'Start Date',
                hintText: 'YYYY-MM-DD',
                suffixIcon: IconButton(
                  icon: Icon(Icons.calendar_today),
                  onPressed: () =>
                      _selectDateForField(_searchStartDateController),
                ),
              ),
            ),

            SizedBox(height: 16),

            // Find button
            ElevatedButton.icon(
              onPressed: _findNextMoonPhase,
              icon: Icon(Icons.search),
              label: Text('Find Next'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),

            // Result
            if (_findResult.isNotEmpty) ...[
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.teal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Next ${_getMoonPhaseName(_targetMoonPhase)}:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[700],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(_findResult),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildValidationUtilities() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle_outline, color: Colors.teal),
                SizedBox(width: 8),
                Text(
                  'Date Validation',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),

            // Date components input
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _yearController,
                    decoration: InputDecoration(
                      labelText: 'Year',
                      hintText: '1385',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _monthController,
                    decoration: InputDecoration(
                      labelText: 'Month',
                      hintText: '1-14',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _dayController,
                    decoration: InputDecoration(
                      labelText: 'Day',
                      hintText: '1-30',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Validate button
            ElevatedButton.icon(
              onPressed: _validateMyanmarDate,
              icon: Icon(Icons.check),
              label: Text('Validate Date'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),

            // Result
            if (_validationResult.isNotEmpty) ...[
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _validationResult.startsWith('✅')
                      ? Colors.green.withValues(alpha: 0.1)
                      : Colors.red.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: _validationResult.startsWith('✅')
                        ? Colors.green.withValues(alpha: 0.3)
                        : Colors.red.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(_validationResult),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPackageInfo() {
    final packageInfo = MyanmarCalendar.packageInfo;
    final diagnostics = MyanmarCalendar.getDiagnostics();

    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.teal),
                SizedBox(width: 8),
                Text(
                  'Package Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),

            // Package info
            _buildInfoRow('Package Name', packageInfo['name'] ?? 'N/A'),
            _buildInfoRow('Version', MyanmarCalendar.version),
            _buildInfoRow(
              'Current Language',
              MyanmarCalendar.currentLanguage.name,
            ),
            _buildInfoRow(
              'Supported Languages',
              MyanmarCalendar.supportedLanguages.length.toString(),
            ),

            SizedBox(height: 16),

            // Configuration
            Text(
              'Configuration:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal[700],
              ),
            ),
            SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoRow(
                    'Sasana Year Type',
                    diagnostics['configuration']['sasanaYearType'].toString(),
                  ),
                  _buildInfoRow(
                    'Calendar Type',
                    diagnostics['configuration']['calendarType'].toString(),
                  ),
                  _buildInfoRow(
                    'Timezone Offset',
                    '${diagnostics['configuration']['timezoneOffset']} hours',
                  ),
                  _buildInfoRow(
                    'Gregorian Start',
                    diagnostics['configuration']['gregorianStart'].toString(),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Validation limits
            Text(
              'Validation Limits:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.teal[700],
              ),
            ),
            SizedBox(height: 8),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.teal.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: MyanmarCalendar.validationLimits.entries
                    .map(
                      (entry) =>
                          _buildInfoRow(entry.key, entry.value.toString()),
                    )
                    .toList(),
              ),
            ),

            SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _showDiagnostics,
                    icon: Icon(Icons.bug_report),
                    label: Text('Show Diagnostics'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _resetConfiguration,
                    icon: Icon(Icons.restore),
                    label: Text('Reset Config'),
                  ),
                ),
              ],
            ),
          ],
        ),
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
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  // Helper methods
  void _calculateDateDifference() {
    try {
      final date1Str = _date1Controller.text.trim();
      final date2Str = _date2Controller.text.trim();

      if (date1Str.isEmpty || date2Str.isEmpty) {
        _showSnackBar('Please enter both dates', isError: true);
        return;
      }

      final date1 = MyanmarDateTime.parseWestern(date1Str);
      final date2 = MyanmarDateTime.parseWestern(date2Str);

      if (date1 == null || date2 == null) {
        _showSnackBar('Invalid date format. Use YYYY-MM-DD', isError: true);
        return;
      }

      final daysDifference = MyanmarCalendar.daysBetween(date1, date2);
      final duration = date2.difference(date1);

      setState(() {
        _dateDifferenceResult =
            '''
Days between dates: $daysDifference days
Duration: ${duration.inDays} days, ${duration.inHours % 24} hours, ${duration.inMinutes % 60} minutes

Date 1: ${date1.formatComplete()}
Date 2: ${date2.formatComplete()}

${date2.isAfter(date1)
                ? 'Date 2 is after Date 1'
                : date2.isBefore(date1)
                ? 'Date 2 is before Date 1'
                : 'Dates are the same'}''';
      });
    } catch (e) {
      _showSnackBar(
        'Error calculating difference: ${e.toString()}',
        isError: true,
      );
    }
  }

  void _performDateArithmetic() {
    try {
      final baseDateStr = _baseDateController.text.trim();
      final daysStr = _daysToAddController.text.trim();
      final monthsStr = _monthsToAddController.text.trim();

      if (baseDateStr.isEmpty) {
        _showSnackBar('Please enter a base date', isError: true);
        return;
      }

      final baseDate = MyanmarDateTime.parseWestern(baseDateStr);
      if (baseDate == null) {
        _showSnackBar('Invalid date format. Use YYYY-MM-DD', isError: true);
        return;
      }

      final daysToAdd = int.tryParse(daysStr) ?? 0;
      final monthsToAdd = int.tryParse(monthsStr) ?? 0;

      var result = baseDate;

      if (daysToAdd != 0) {
        result = MyanmarCalendar.addDays(result, daysToAdd);
      }

      if (monthsToAdd != 0) {
        result = MyanmarCalendar.addMonths(result, monthsToAdd);
      }

      setState(() {
        _arithmeticResult =
            '''
Original Date: ${baseDate.formatComplete()}
${daysToAdd != 0 ? 'Added $daysToAdd days\n' : ''}${monthsToAdd != 0 ? 'Added $monthsToAdd months\n' : ''}
Final Date: ${result.formatComplete()}

Total change: ${result.differenceInDays(baseDate)} days''';
      });
    } catch (e) {
      _showSnackBar('Error in date arithmetic: ${e.toString()}', isError: true);
    }
  }

  void _processBatchDates() {
    try {
      final datesText = _batchDatesController.text.trim();
      if (datesText.isEmpty) {
        _showSnackBar('Please enter dates to process', isError: true);
        return;
      }

      final dateStrings = datesText
          .split('\n')
          .where((s) => s.trim().isNotEmpty)
          .toList();
      final results = <MyanmarDateTime>[];

      for (final dateStr in dateStrings) {
        final date = MyanmarDateTime.parseWestern(dateStr.trim());
        if (date != null) {
          results.add(date);
        }
      }

      if (results.isEmpty) {
        _showSnackBar('No valid dates found', isError: true);
        return;
      }

      setState(() {
        _batchResults = results;
      });

      _showSnackBar('Successfully processed ${results.length} dates');
    } catch (e) {
      _showSnackBar('Error processing batch: ${e.toString()}', isError: true);
    }
  }

  void _findNextMoonPhase() {
    try {
      final startDateStr = _searchStartDateController.text.trim();
      if (startDateStr.isEmpty) {
        _showSnackBar('Please enter a start date', isError: true);
        return;
      }

      final startDate = MyanmarDateTime.parseWestern(startDateStr);
      if (startDate == null) {
        _showSnackBar('Invalid date format. Use YYYY-MM-DD', isError: true);
        return;
      }

      final nextDate = MyanmarCalendar.findNextMoonPhase(
        startDate,
        _targetMoonPhase,
      );
      final daysDifference = nextDate.differenceInDays(startDate);

      setState(() {
        _findResult =
            '''
${nextDate.formatComplete()}

Days from start date: $daysDifference days
Moon phase: ${_getMoonPhaseName(_targetMoonPhase)}
Fortnight day: ${nextDate.fortnightDay}''';
      });
    } catch (e) {
      _showSnackBar('Error finding moon phase: ${e.toString()}', isError: true);
    }
  }

  void _validateMyanmarDate() {
    try {
      final yearStr = _yearController.text.trim();
      final monthStr = _monthController.text.trim();
      final dayStr = _dayController.text.trim();

      if (yearStr.isEmpty || monthStr.isEmpty || dayStr.isEmpty) {
        _showSnackBar('Please enter year, month, and day', isError: true);
        return;
      }

      final year = int.tryParse(yearStr);
      final month = int.tryParse(monthStr);
      final day = int.tryParse(dayStr);

      if (year == null || month == null || day == null) {
        _showSnackBar('Please enter valid numbers', isError: true);
        return;
      }

      final validation = MyanmarCalendar.validateMyanmar(year, month, day);
      // ignore: unused_local_variable
      final isValid = MyanmarCalendar.isValidMyanmar(year, month, day);

      setState(() {
        if (validation.isValid) {
          final date = MyanmarCalendar.fromMyanmar(year, month, day);
          _validationResult =
              '''
✅ Valid Myanmar Date

Myanmar: ${date.formatMyanmar()}
Western: ${date.formatWestern()}
Year Type: ${_getYearTypeName(date.yearType)}
Month Length: ${date.monthLength} days
Moon Phase: ${_getMoonPhaseName(date.moonPhase)}''';
        } else {
          _validationResult =
              '''
❌ Invalid Myanmar Date

Error: ${validation.error ?? 'Unknown error'}
Year: $year
Month: $month
Day: $day''';
        }
      });
    } catch (e) {
      setState(() {
        _validationResult = '❌ Error during validation: ${e.toString()}';
      });
    }
  }

  Future<void> _selectDateForField(TextEditingController controller) async {
    final selected = await showMyanmarDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
      language: _language,
    );

    if (selected != null) {
      controller.text = selected.western.toDateTime().toString().split(' ')[0];
    }
  }

  void _showDiagnostics() {
    final diagnostics = MyanmarCalendar.getDiagnostics();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Package Diagnostics'),
        content: SingleChildScrollView(
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Full diagnostic information:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SelectableText(
                    _formatDiagnostics(diagnostics),
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  String _formatDiagnostics(Map<String, dynamic> diagnostics) {
    final buffer = StringBuffer();

    void formatMap(Map<String, dynamic> map, [int indent = 0]) {
      final spaces = '  ' * indent;
      map.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          buffer.writeln('$spaces$key:');
          formatMap(value, indent + 1);
        } else if (value is List) {
          buffer.writeln('$spaces$key: [${value.join(', ')}]');
        } else {
          buffer.writeln('$spaces$key: $value');
        }
      });
    }

    formatMap(diagnostics);
    return buffer.toString();
  }

  void _resetConfiguration() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Reset Configuration'),
        content: Text(
          'This will reset all Myanmar Calendar configuration to default values. Continue?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              MyanmarCalendar.reset();
              Navigator.of(context).pop();
              _showSnackBar('Configuration reset to defaults');
              setState(() {
                _language = Language.english;
              });
            },
            child: Text('Reset'),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        duration: Duration(seconds: isError ? 4 : 2),
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
}
