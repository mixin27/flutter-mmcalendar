import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class APIDemoPage extends StatefulWidget {
  const APIDemoPage({super.key});

  @override
  State<APIDemoPage> createState() => _APIDemoPageState();
}

class _APIDemoPageState extends State<APIDemoPage> {
  Language _language = Language.english;
  String _selectedAPI = 'MyanmarCalendar.today()';
  String _apiResult = '';
  bool _isLoading = false;

  bool _isCollapse = false;

  // Input controllers for parameterized APIs
  final _dateInputController = TextEditingController();
  final _yearController = TextEditingController(text: '1385');
  final _monthController = TextEditingController(text: '10');
  final _dayController = TextEditingController(text: '1');
  final _julianDayController = TextEditingController();
  final _timestampController = TextEditingController();

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
  }

  @override
  void dispose() {
    _dateInputController.dispose();
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    _julianDayController.dispose();
    _timestampController.dispose();
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
          Text(_getLanguageName(_language)),
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
        crossAxisAlignment: CrossAxisAlignment.start,
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
                  Expanded(child: _buildAPISelector()),
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
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: SingleChildScrollView(
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
            ..._apiCategories.entries.map((category) {
              return ExpansionTile(
                title: Text(
                  category.key,
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
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
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildParameterInputs() {
    final currentAPI = _getCurrentAPI();

    if (currentAPI == null || !currentAPI['hasParams']) {
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SingleChildScrollView(
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
      ),
    );
  }

  List<Widget> _buildParameterFields(String paramType) {
    switch (paramType) {
      case 'dateComponents':
        return [
          TextField(
            decoration: InputDecoration(labelText: 'Year', hintText: '2024'),
            keyboardType: TextInputType.number,
            onChanged: (value) => _yearController.text = value,
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(labelText: 'Month', hintText: '1-12'),
            keyboardType: TextInputType.number,
            onChanged: (value) => _monthController.text = value,
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(labelText: 'Day', hintText: '1-31'),
            keyboardType: TextInputType.number,
            onChanged: (value) => _dayController.text = value,
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
              labelText: 'Date (YYYY-MM-DD)',
              hintText: DateTime.now().toString().split(' ')[0],
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
            controller: _dateInputController,
            decoration: InputDecoration(
              labelText: 'Date String',
              hintText: _selectedAPI.contains('Myanmar')
                  ? '1385/10/1'
                  : '2024-01-01',
            ),
          ),
        ];

      default:
        return [];
    }
  }

  Widget _buildExecuteButton() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _isLoading
              ? null
              : () {
                  _executeAPI().then((res) {
                    setState(() {
                      _isCollapse = !_isCollapse;
                    });
                  });
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
          child: _isLoading
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text('Execute API'),
        ),
      ),
    );
  }

  Widget _buildResultPanel() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Result',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              IconButton(
                icon: Icon(Icons.copy),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: _apiResult));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Copied to clipboard')),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: SelectableText(
              _apiResult,
              style: TextStyle(
                color: Colors.grey[200],
                fontFamily: 'monospace',
                fontSize: 13,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentation() {
    final currentAPI = _getCurrentAPI();
    if (currentAPI == null) return SizedBox.shrink();

    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Documentation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.indigo,
            ),
          ),
          SizedBox(height: 16),

          // API description
          Text(currentAPI['description'], style: TextStyle(fontSize: 16)),
          SizedBox(height: 24),

          // Code example
          Text(
            'Example Usage:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(8),
            ),
            child: SelectableText(
              currentAPI['code'],
              style: TextStyle(
                color: Colors.grey[200],
                fontFamily: 'monospace',
                fontSize: 13,
              ),
            ),
          ),
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
    setState(() => _isLoading = true);

    try {
      final result = await _executeSelectedAPI();
      setState(() {
        _apiResult = result.toString();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _apiResult = 'Error: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<dynamic> _executeSelectedAPI() async {
    final api = _getCurrentAPI();
    if (api == null) return 'API not found';

    switch (_selectedAPI) {
      case 'MyanmarCalendar.today()':
        return MyanmarCalendar.today();
      case 'MyanmarCalendar.now()':
        return MyanmarCalendar.now();
      case 'MyanmarCalendar.fromWestern()':
        return MyanmarCalendar.fromWestern(
          int.parse(_yearController.text),
          int.parse(_monthController.text),
          int.parse(_dayController.text),
        );
      // Add more cases for other APIs
      default:
        return 'API not implemented';
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
}
