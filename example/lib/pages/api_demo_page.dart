import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class APIDemoPage extends StatefulWidget {
  const APIDemoPage({super.key});

  @override
  State<APIDemoPage> createState() => _APIDemoPageState();
}

class _APIDemoPageState extends State<APIDemoPage> {
  bool _isCollapse = false;

  Language _language = Language.english;
  String _selectedAPI = 'MyanmarCalendar.today()';
  String _apiResult = '';
  bool _isLoading = false;

  // Input controllers for parameterized APIs
  final _dateInputController = TextEditingController();
  final _yearController = TextEditingController(text: '1385');
  final _monthController = TextEditingController(text: '10');
  final _dayController = TextEditingController(text: '1');
  final _julianDayController = TextEditingController();
  final _timestampController = TextEditingController();
  final _dateStringController = TextEditingController();

  // API categories and methods
  final Map<String, List<Map<String, dynamic>>> _apiCategories = {
    'Factory Methods': [
      {
        'name': 'MyanmarCalendar.today()',
        'description': 'Get current Myanmar date',
        'hasParams': false,
        'code': 'MyanmarCalendar.today()',
      },
      {
        'name': 'MyanmarCalendar.now()',
        'description': 'Get current Myanmar date and time',
        'hasParams': false,
        'code': 'MyanmarCalendar.now()',
      },
      {
        'name': 'MyanmarCalendar.fromWestern()',
        'description': 'Convert Western date to Myanmar',
        'hasParams': true,
        'paramType': 'dateComponents',
        'code': 'MyanmarCalendar.fromWestern(year, month, day)',
      },
      {
        'name': 'MyanmarCalendar.fromMyanmar()',
        'description': 'Create from Myanmar date components',
        'hasParams': true,
        'paramType': 'myanmarComponents',
        'code': 'MyanmarCalendar.fromMyanmar(year, month, day)',
      },
      {
        'name': 'MyanmarCalendar.fromDateTime()',
        'description': 'Convert DateTime to Myanmar',
        'hasParams': true,
        'paramType': 'dateTime',
        'code': 'MyanmarCalendar.fromDateTime(dateTime)',
      },
      {
        'name': 'MyanmarCalendar.fromJulianDay()',
        'description': 'Convert Julian Day Number',
        'hasParams': true,
        'paramType': 'julianDay',
        'code': 'MyanmarCalendar.fromJulianDay(jdn)',
      },
      {
        'name': 'MyanmarCalendar.fromTimestamp()',
        'description': 'Convert Unix timestamp',
        'hasParams': true,
        'paramType': 'timestamp',
        'code': 'MyanmarCalendar.fromTimestamp(timestamp)',
      },
    ],
    'Information Methods': [
      {
        'name': 'getCompleteDate()',
        'description': 'Get complete date information',
        'hasParams': true,
        'paramType': 'dateTime',
        'code': 'MyanmarCalendar.getCompleteDate(DateTime.now())',
      },
      {
        'name': 'isWatatYear()',
        'description': 'Check if year is watat year',
        'hasParams': true,
        'paramType': 'year',
        'code': 'MyanmarCalendar.isWatatYear(year)',
      },
      {
        'name': 'getYearType()',
        'description': 'Get year type (0,1,2)',
        'hasParams': true,
        'paramType': 'year',
        'code': 'MyanmarCalendar.getYearType(year)',
      },
      {
        'name': 'getMyanmarMonth()',
        'description': 'Get all dates in Myanmar month',
        'hasParams': true,
        'paramType': 'yearMonth',
        'code': 'MyanmarCalendar.getMyanmarMonth(year, month)',
      },
      {
        'name': 'findSabbathDays()',
        'description': 'Find sabbath days in month',
        'hasParams': true,
        'paramType': 'yearMonth',
        'code': 'MyanmarCalendar.findSabbathDays(year, month)',
      },
    ],
    'Parsing Methods': [
      {
        'name': 'parseMyanmar()',
        'description': 'Parse Myanmar date string',
        'hasParams': true,
        'paramType': 'dateString',
        'code': 'MyanmarCalendar.parseMyanmar("1385/10/1")',
      },
      {
        'name': 'parseWestern()',
        'description': 'Parse Western date string',
        'hasParams': true,
        'paramType': 'dateString',
        'code': 'MyanmarCalendar.parseWestern("2024-01-01")',
      },
    ],
    'Validation Methods': [
      {
        'name': 'validateMyanmar()',
        'description': 'Validate Myanmar date components',
        'hasParams': true,
        'paramType': 'myanmarComponents',
        'code': 'MyanmarCalendar.validateMyanmar(year, month, day)',
      },
      {
        'name': 'isValidMyanmar()',
        'description': 'Check if Myanmar date is valid',
        'hasParams': true,
        'paramType': 'myanmarComponents',
        'code': 'MyanmarCalendar.isValidMyanmar(year, month, day)',
      },
    ],
    'Package Information': [
      {
        'name': 'version',
        'description': 'Get package version',
        'hasParams': false,
        'code': 'MyanmarCalendar.version',
      },
      {
        'name': 'packageInfo',
        'description': 'Get package information',
        'hasParams': false,
        'code': 'MyanmarCalendar.packageInfo',
      },
      {
        'name': 'supportedLanguages',
        'description': 'Get supported languages',
        'hasParams': false,
        'code': 'MyanmarCalendar.supportedLanguages',
      },
      {
        'name': 'getDiagnostics()',
        'description': 'Get diagnostic information',
        'hasParams': false,
        'code': 'MyanmarCalendar.getDiagnostics()',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _initializeInputs();
    _executeAPI();
  }

  void _initializeInputs() {
    final now = DateTime.now();
    _dateInputController.text = now.toString().split(' ')[0];
    _julianDayController.text = '2460000';
    _timestampController.text = (now.millisecondsSinceEpoch ~/ 1000).toString();
    _dateStringController.text = '1385/10/1';
  }

  @override
  void dispose() {
    _dateInputController.dispose();
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    _julianDayController.dispose();
    _timestampController.dispose();
    _dateStringController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API Documentation & Testing'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<Language>(
            icon: Icon(Icons.language),
            onSelected: (language) {
              setState(() {
                _language = language;
              });
              MyanmarCalendar.setLanguage(language);
              _executeAPI(); // Re-execute to show results in new language
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
      body: Row(
        children: [
          // Left panel - API explorer
          if (!_isCollapse)
            Container(
              width: 350,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(right: BorderSide(color: Colors.grey[300]!)),
              ),
              child: Column(
                children: [
                  _buildAPISelector(),
                  Expanded(child: _buildParameterInputs()),
                  _buildExecuteButton(),
                ],
              ),
            ),

          // Right panel - Results and documentation
          if (_isCollapse)
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _isCollapse = !_isCollapse;
                        });
                      },
                      icon: const Icon(Icons.menu_open),
                    ),
                  ),
                  _buildResultPanel(),
                  Expanded(child: _buildDocumentation()),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildAPISelector() {
    return Container(
      height: 300,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'API Explorer',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _isCollapse = !_isCollapse;
                  });
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: 12),

          // Category expansion tiles
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: _apiCategories.entries.map((category) {
                  return ExpansionTile(
                    title: Text(
                      category.key,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    children: category.value.map((api) {
                      final isSelected = _selectedAPI == api['name'];

                      return ListTile(
                        selected: isSelected,
                        selectedTileColor: Colors.indigo.withValues(alpha: 0.1),
                        dense: true,
                        title: Text(
                          api['name'],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        subtitle: Text(
                          api['description'],
                          style: TextStyle(fontSize: 10),
                        ),
                        onTap: () {
                          setState(() {
                            _selectedAPI = api['name'];
                          });
                          _executeAPI();
                        },
                      );
                    }).toList(),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildParameterInputs() {
    final currentAPI = _getCurrentAPI();

    if (currentAPI == null || !currentAPI['hasParams']) {
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline, size: 48, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(
              'No parameters required',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
          ],
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Parameters',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          SizedBox(height: 16),

          ..._buildParameterFields(currentAPI['paramType']),
        ],
      ),
    );
  }

  List<Widget> _buildParameterFields(String paramType) {
    switch (paramType) {
      case 'dateComponents':
        return [
          TextField(
            controller: _yearController,
            decoration: InputDecoration(labelText: 'Year', hintText: '2024'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 12),
          TextField(
            controller: _monthController,
            decoration: InputDecoration(labelText: 'Month', hintText: '1-12'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 12),
          TextField(
            controller: _dayController,
            decoration: InputDecoration(labelText: 'Day', hintText: '1-31'),
            keyboardType: TextInputType.number,
          ),
        ];

      case 'myanmarComponents':
        return [
          TextField(
            controller: _yearController,
            decoration: InputDecoration(
              labelText: 'Myanmar Year',
              hintText: '1385',
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 12),
          TextField(
            controller: _monthController,
            decoration: InputDecoration(
              labelText: 'Myanmar Month',
              hintText: '1-14',
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 12),
          TextField(
            controller: _dayController,
            decoration: InputDecoration(
              labelText: 'Myanmar Day',
              hintText: '1-30',
            ),
            keyboardType: TextInputType.number,
          ),
        ];

      case 'dateTime':
        return [
          TextField(
            controller: _dateInputController,
            decoration: InputDecoration(
              labelText: 'Date',
              hintText: 'YYYY-MM-DD',
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today),
                onPressed: () => _selectDate(_dateInputController),
              ),
            ),
          ),
        ];

      case 'julianDay':
        return [
          TextField(
            controller: _julianDayController,
            decoration: InputDecoration(
              labelText: 'Julian Day Number',
              hintText: '2460000',
            ),
            keyboardType: TextInputType.number,
          ),
        ];

      case 'timestamp':
        return [
          TextField(
            controller: _timestampController,
            decoration: InputDecoration(
              labelText: 'Unix Timestamp',
              hintText: '1704067200',
              suffixIcon: IconButton(
                icon: Icon(Icons.access_time),
                onPressed: () {
                  _timestampController.text =
                      (DateTime.now().millisecondsSinceEpoch ~/ 1000)
                          .toString();
                },
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ];

      case 'year':
        return [
          TextField(
            controller: _yearController,
            decoration: InputDecoration(
              labelText: 'Myanmar Year',
              hintText: '1385',
            ),
            keyboardType: TextInputType.number,
          ),
        ];

      case 'yearMonth':
        return [
          TextField(
            controller: _yearController,
            decoration: InputDecoration(
              labelText: 'Myanmar Year',
              hintText: '1385',
            ),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 12),
          TextField(
            controller: _monthController,
            decoration: InputDecoration(
              labelText: 'Myanmar Month',
              hintText: '1-14',
            ),
            keyboardType: TextInputType.number,
          ),
        ];

      case 'dateString':
        return [
          TextField(
            controller: _dateStringController,
            decoration: InputDecoration(
              labelText: 'Date String',
              hintText: _selectedAPI.contains('Myanmar')
                  ? '1385/10/1'
                  : '2024-01-01',
            ),
          ),
        ];

      default:
        return [
          Text(
            'Unknown parameter type: $paramType',
            style: TextStyle(color: Colors.red),
          ),
        ];
    }
  }

  Widget _buildExecuteButton() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: ElevatedButton.icon(
        onPressed: _isLoading ? null : _executeAPI,
        icon: _isLoading
            ? SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : Icon(Icons.play_arrow),
        label: Text(_isLoading ? 'Executing...' : 'Execute API'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildResultPanel() {
    return Container(
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              children: [
                Icon(Icons.code, color: Colors.indigo),
                SizedBox(width: 8),
                Text(
                  'Execution Result',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(Icons.copy),
                  onPressed: _apiResult.isNotEmpty
                      ? () {
                          Clipboard.setData(ClipboardData(text: _apiResult));
                          _showSnackBar('Result copied to clipboard');
                        }
                      : null,
                  tooltip: 'Copy result',
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: SelectableText(
                  _apiResult.isEmpty
                      ? 'Click "Execute API" to see results...'
                      : _apiResult,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: _apiResult.isEmpty
                        ? Colors.grey[600]
                        : Colors.black87,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentation() {
    final currentAPI = _getCurrentAPI();

    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.book, color: Colors.indigo),
              SizedBox(width: 8),
              Text(
                'Documentation',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
          Divider(),

          if (currentAPI != null) ...[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // API name and description
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.indigo.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.indigo.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentAPI['name'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigo[700],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            currentAPI['description'],
                            style: TextStyle(color: Colors.indigo[600]),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 16),

                    // Code example
                    Text(
                      'Code Example:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[300]!),
                      ),
                      child: SelectableText(
                        currentAPI['code'],
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                          color: Colors.green[800],
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // Detailed documentation
                    Text(
                      'Details:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(_getDetailedDocumentation(currentAPI['name'])),

                    SizedBox(height: 16),

                    // Usage tips
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.amber.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.lightbulb,
                                color: Colors.amber[700],
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Usage Tips:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber[700],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Text(
                            _getUsageTips(currentAPI['name']),
                            style: TextStyle(color: Colors.amber[800]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            Center(
              child: Text(
                'Select an API to view documentation',
                style: TextStyle(color: Colors.grey[600], fontSize: 14),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Helper methods
  Map<String, dynamic>? _getCurrentAPI() {
    for (final category in _apiCategories.values) {
      for (final api in category) {
        if (api['name'] == _selectedAPI) {
          return api;
        }
      }
    }
    return null;
  }

  Future<void> _executeAPI() async {
    setState(() {
      _isLoading = true;
      _apiResult = '';
    });

    try {
      String result = '';

      switch (_selectedAPI) {
        case 'MyanmarCalendar.today()':
          final date = MyanmarCalendar.today();
          result = _formatMyanmarDateTime(date);
          break;

        case 'MyanmarCalendar.now()':
          final date = MyanmarCalendar.now();
          result = _formatMyanmarDateTime(date);
          break;

        case 'MyanmarCalendar.fromWestern()':
          final year = int.tryParse(_yearController.text) ?? 2024;
          final month = int.tryParse(_monthController.text) ?? 1;
          final day = int.tryParse(_dayController.text) ?? 1;
          final date = MyanmarCalendar.fromWestern(year, month, day);
          result = _formatMyanmarDateTime(date);
          break;

        case 'MyanmarCalendar.fromMyanmar()':
          final year = int.tryParse(_yearController.text) ?? 1385;
          final month = int.tryParse(_monthController.text) ?? 10;
          final day = int.tryParse(_dayController.text) ?? 1;
          final date = MyanmarCalendar.fromMyanmar(year, month, day);
          result = _formatMyanmarDateTime(date);
          break;

        case 'MyanmarCalendar.fromDateTime()':
          final dateTime =
              DateTime.tryParse(_dateInputController.text) ?? DateTime.now();
          final date = MyanmarCalendar.fromDateTime(dateTime);
          result = _formatMyanmarDateTime(date);
          break;

        case 'MyanmarCalendar.fromJulianDay()':
          final jdn = double.tryParse(_julianDayController.text) ?? 2460000;
          final date = MyanmarCalendar.fromJulianDay(jdn);
          result = _formatMyanmarDateTime(date);
          break;

        case 'MyanmarCalendar.fromTimestamp()':
          final timestamp =
              int.tryParse(_timestampController.text) ?? 1704067200;
          final date = MyanmarCalendar.fromTimestamp(timestamp);
          result = _formatMyanmarDateTime(date);
          break;

        case 'getCompleteDate()':
          final dateTime =
              DateTime.tryParse(_dateInputController.text) ?? DateTime.now();
          final complete = MyanmarCalendar.getCompleteDate(dateTime);
          result = _formatCompleteDate(complete);
          break;

        case 'isWatatYear()':
          final year = int.tryParse(_yearController.text) ?? 1385;
          final isWatat = MyanmarCalendar.isWatatYear(year);
          result =
              '''
Year: $year
Is Watat Year: $isWatat
Year Type: ${MyanmarCalendar.getYearType(year)}
          ''';
          break;

        case 'getYearType()':
          final year = int.tryParse(_yearController.text) ?? 1385;
          final yearType = MyanmarCalendar.getYearType(year);
          result =
              '''
Year: $year
Year Type: $yearType
${yearType == 0
                  ? 'Common Year'
                  : yearType == 1
                  ? 'Little Watat Year'
                  : 'Big Watat Year'}
          ''';
          break;

        case 'getMyanmarMonth()':
          final year = int.tryParse(_yearController.text) ?? 1385;
          final month = int.tryParse(_monthController.text) ?? 10;
          final dates = MyanmarCalendar.getMyanmarMonth(year, month);
          result =
              '''
Myanmar Year: $year, Month: $month
Total Days: ${dates.length}

Dates in month:
${dates.take(10).map((d) => 'Day ${d.day} - ${MyanmarDateTime.fromMyanmarDate(d).formatWestern()}').join('\n')}
${dates.length > 10 ? '... and ${dates.length - 10} more dates' : ''}
          ''';
          break;

        case 'findSabbathDays()':
          final year = int.tryParse(_yearController.text) ?? 1385;
          final month = int.tryParse(_monthController.text) ?? 10;
          final sabbathDays = MyanmarCalendar.findSabbathDays(year, month);
          result =
              '''
Myanmar Year: $year, Month: $month
Sabbath Days: ${sabbathDays.length}

${sabbathDays.map((d) => 'Day ${d.myanmarDay} - ${d.formatWestern()}').join('\n')}
          ''';
          break;

        case 'parseMyanmar()':
          final dateStr = _dateStringController.text.trim();
          final parsed = MyanmarCalendar.parseMyanmar(
            dateStr.isNotEmpty ? dateStr : '1385/10/1',
          );
          result = parsed != null
              ? _formatMyanmarDateTime(parsed)
              : 'Failed to parse Myanmar date string';
          break;

        case 'parseWestern()':
          final dateStr = _dateStringController.text.trim();
          final parsed = MyanmarCalendar.parseWestern(
            dateStr.isNotEmpty ? dateStr : '2024-01-01',
          );
          result = parsed != null
              ? _formatMyanmarDateTime(parsed)
              : 'Failed to parse Western date string';
          break;

        case 'validateMyanmar()':
          final year = int.tryParse(_yearController.text) ?? 1385;
          final month = int.tryParse(_monthController.text) ?? 10;
          final day = int.tryParse(_dayController.text) ?? 1;
          final validation = MyanmarCalendar.validateMyanmar(year, month, day);
          result =
              '''
Year: $year, Month: $month, Day: $day
Valid: ${validation.isValid}
${validation.error != null ? 'Error: ${validation.error}' : ''}
          ''';
          break;

        case 'isValidMyanmar()':
          final year = int.tryParse(_yearController.text) ?? 1385;
          final month = int.tryParse(_monthController.text) ?? 10;
          final day = int.tryParse(_dayController.text) ?? 1;
          final isValid = MyanmarCalendar.isValidMyanmar(year, month, day);
          result =
              '''
Year: $year, Month: $month, Day: $day
Is Valid: $isValid
          ''';
          break;

        case 'version':
          result = 'Package Version: ${MyanmarCalendar.version}';
          break;

        case 'packageInfo':
          final info = MyanmarCalendar.packageInfo;
          result =
              '''
Package Information:
${info.entries.map((e) => '${e.key}: ${e.value}').join('\n')}
          ''';
          break;

        case 'supportedLanguages':
          final languages = MyanmarCalendar.supportedLanguages;
          result =
              '''
Supported Languages (${languages.length}):
${languages.map((lang) => '${lang.name} (${lang.code})').join('\n')}
          ''';
          break;

        case 'getDiagnostics()':
          final diagnostics = MyanmarCalendar.getDiagnostics();
          result = _formatDiagnostics(diagnostics);
          break;

        default:
          result = 'API not implemented in demo';
      }

      setState(() {
        _apiResult = result.trim();
      });
    } catch (e) {
      setState(() {
        _apiResult = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String _formatMyanmarDateTime(MyanmarDateTime date) {
    return '''
Myanmar Date: ${date.formatMyanmar()}
Western Date: ${date.formatWestern()}
Julian Day: ${date.julianDay}

Myanmar Components:
- Year: ${date.myanmarYear}
- Month: ${date.myanmarMonth}
- Day: ${date.myanmarDay}
- Year Type: ${date.yearType} (${date.isWatatYear ? 'Watat' : 'Common'})
- Month Length: ${date.monthLength} days
- Moon Phase: ${date.moonPhase} (${_getMoonPhaseName(date.moonPhase)})
- Fortnight Day: ${date.fortnightDay}
- Sasana Year: ${date.sasanaYear}

Western Components:
- Year: ${date.westernYear}
- Month: ${date.westernMonth}
- Day: ${date.westernDay}
- Weekday: ${date.weekday}

Astrological Info:
- Sabbath: ${date.sabbath}
- Yatyaza: ${date.yatyaza}
- Pyathada: ${date.pyathada}

Holidays: ${date.hasHolidays ? date.allHolidays.join(', ') : 'None'}
    ''';
  }

  String _formatCompleteDate(CompleteDate complete) {
    return '''
=== COMPLETE DATE INFORMATION ===

${_formatMyanmarDateTime(MyanmarDateTime.fromWesternDate(complete.western))}

=== DETAILED ASTROLOGICAL ===
${complete.astro.astrologicalDays.isNotEmpty ? complete.astro.astrologicalDays.join(', ') : 'None'}

=== ALL HOLIDAYS ===
Public: ${complete.holidays.publicHolidays.join(', ')}
Religious: ${complete.holidays.religiousHolidays.join(', ')}
Cultural: ${complete.holidays.culturalHolidays.join(', ')}
    ''';
  }

  String _formatDiagnostics(Map<String, dynamic> diagnostics) {
    final buffer = StringBuffer();
    buffer.writeln('=== PACKAGE DIAGNOSTICS ===\n');

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

  Future<void> _selectDate(TextEditingController controller) async {
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

  String _getDetailedDocumentation(String apiName) {
    final docs = {
      'MyanmarCalendar.today()':
          'Returns the current date as a MyanmarDateTime object. Uses the system\'s current date and time, converted to Myanmar calendar format.',
      'MyanmarCalendar.now()':
          'Alias for today(). Returns the current Myanmar date and time.',
      'MyanmarCalendar.fromWestern()':
          'Converts a Western (Gregorian) date to Myanmar calendar. Takes year, month, and day as parameters.',
      'MyanmarCalendar.fromMyanmar()':
          'Creates a MyanmarDateTime from Myanmar calendar components. Useful when you have Myanmar year, month, and day.',
      'MyanmarCalendar.fromDateTime()':
          'Converts a Dart DateTime object to MyanmarDateTime. Preserves time information.',
      'MyanmarCalendar.fromJulianDay()':
          'Creates a Myanmar date from Julian Day Number. Useful for astronomical calculations.',
      'MyanmarCalendar.fromTimestamp()':
          'Converts Unix timestamp (seconds since epoch) to Myanmar date.',
      'getCompleteDate()':
          'Returns comprehensive information including Myanmar date, Western date, astrological info, and holidays.',
      'isWatatYear()':
          'Checks if a Myanmar year is a watat (intercalary) year. Returns true if the year has 13 months.',
      'getYearType()':
          'Returns the type of Myanmar year: 0 (common), 1 (little watat), or 2 (big watat).',
      'getMyanmarMonth()':
          'Returns all dates in a specific Myanmar month as a list of MyanmarDate objects.',
      'findSabbathDays()':
          'Finds all sabbath days in a Myanmar month. Returns a list of MyanmarDateTime objects.',
      'parseMyanmar()':
          'Parses a Myanmar date string. Supports formats like "1385/10/1", "1385-10-1".',
      'parseWestern()':
          'Parses a Western date string using standard formats like "2024-01-01".',
      'validateMyanmar()':
          'Validates Myanmar date components and returns detailed validation result.',
      'isValidMyanmar()': 'Simple boolean check for Myanmar date validity.',
      'version': 'Returns the current package version string.',
      'packageInfo': 'Returns detailed package information as a map.',
      'supportedLanguages': 'Returns list of all supported languages.',
      'getDiagnostics()':
          'Returns comprehensive diagnostic information for debugging.',
    };

    return docs[apiName] ?? 'Documentation not available for this API.';
  }

  String _getUsageTips(String apiName) {
    final tips = {
      'MyanmarCalendar.today()':
          'Use this as the starting point for most date operations. The returned object has many useful properties.',
      'MyanmarCalendar.fromWestern()':
          'Remember that month parameter is 1-based (1-12), not 0-based like some systems.',
      'MyanmarCalendar.fromMyanmar()':
          'Myanmar months can go up to 14 in watat years. Always validate inputs first.',
      'getCompleteDate()':
          'This is the most comprehensive method - use it when you need all available information.',
      'isWatatYear()':
          'Useful for calendar layouts and month calculations. Watat years have an extra month.',
      'getMyanmarMonth()':
          'Great for building calendar views. The returned dates are in chronological order.',
      'parseMyanmar()':
          'Always check for null return value - parsing can fail with invalid formats.',
      'validateMyanmar()':
          'Use this before creating dates programmatically to avoid exceptions.',
      'getDiagnostics()':
          'Helpful for troubleshooting configuration issues and understanding current settings.',
    };

    return tips[apiName] ??
        'No specific tips available. Check the documentation for general usage guidelines.';
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), duration: Duration(seconds: 2)),
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
}
