import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class ThemeDemoPage extends StatefulWidget {
  const ThemeDemoPage({super.key});

  @override
  State<ThemeDemoPage> createState() => _ThemeDemoPageState();
}

class _ThemeDemoPageState extends State<ThemeDemoPage> {
  Language _language = Language.english;
  MyanmarCalendarTheme _currentTheme = MyanmarCalendarTheme.defaultTheme();
  String _selectedThemeName = 'Default';
  DateTime _selectedDate = DateTime.now();

  bool _toolbarCollapse = false;

  // Theme presets
  final Map<String, MyanmarCalendarTheme> _themePresets = {
    'Default': MyanmarCalendarTheme.defaultTheme(),
    'Dark': MyanmarCalendarTheme.darkTheme(),
    'Traditional': MyanmarCalendarTheme.fromColor(
      const Color(0xFF8B4513), // Saddle brown
      isDark: false,
    ),
    'Royal': MyanmarCalendarTheme.fromColor(
      const Color(0xFF4B0082), // Indigo
      isDark: false,
    ),
    'Emerald': MyanmarCalendarTheme.fromColor(
      const Color(0xFF50C878), // Emerald green
      isDark: false,
    ),
    'Crimson': MyanmarCalendarTheme.fromColor(
      const Color(0xFFDC143C), // Crimson
      isDark: false,
    ),
    'Ocean': MyanmarCalendarTheme.fromColor(
      const Color(0xFF006994), // Ocean blue
      isDark: false,
    ),
    'Sunset': MyanmarCalendarTheme.fromColor(
      const Color(0xFFFF4500), // Orange red
      isDark: false,
    ),
  };

  // Custom theme properties
  Color _headerBackgroundColor = Colors.blue.shade600;
  Color _backgroundColor = Colors.white;
  Color _selectedDateColor = Colors.blue.shade600;
  Color _todayColor = Colors.blue.shade100;
  Color _sabbathColor = Colors.orange.shade100;
  Color _fullMoonColor = Colors.amber.shade100;
  Color _newMoonColor = Colors.indigo.shade100;
  double _borderRadius = 8.0;
  double _elevation = 2.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Showcase'),
        backgroundColor: Colors.deepPurple,
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
      body: Row(
        children: [
          // Left panel - Theme controls
          if (_toolbarCollapse)
            Container(
              width: 320,
              decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border(right: BorderSide(color: Colors.grey[300]!)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildThemeSelector(),
                    _buildThemeCustomizer(),
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),

          // Right panel - Calendar preview
          if (!_toolbarCollapse)
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _toolbarCollapse = !_toolbarCollapse;
                            });
                          },
                          icon: const Icon(Icons.menu_open),
                        ),

                        Text(
                          'Calendar Preview',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Calendar preview
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildCalendarPreview(),
                            SizedBox(height: 20),
                            _buildDatePickerPreview(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildThemeSelector() {
    return Container(
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
                'Theme Presets',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _toolbarCollapse = !_toolbarCollapse;
                  });
                },
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          SizedBox(height: 12),

          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _themePresets.entries.map((entry) {
              final isSelected = _selectedThemeName == entry.key;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedThemeName = entry.key;
                    _currentTheme = entry.value;
                    _updateCustomProperties();
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.deepPurple : Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected ? Colors.deepPurple : Colors.grey[300]!,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: entry.value.headerBackgroundColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        entry.key,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black87,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeCustomizer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Custom Theme Builder',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(height: 16),

          _buildColorPicker('Header Background', _headerBackgroundColor, (
            color,
          ) {
            setState(() {
              _headerBackgroundColor = color;
              _updateCustomTheme();
            });
          }),

          _buildColorPicker('Background', _backgroundColor, (color) {
            setState(() {
              _backgroundColor = color;
              _updateCustomTheme();
            });
          }),

          _buildColorPicker('Selected Date', _selectedDateColor, (color) {
            setState(() {
              _selectedDateColor = color;
              _updateCustomTheme();
            });
          }),

          _buildColorPicker('Today Highlight', _todayColor, (color) {
            setState(() {
              _todayColor = color;
              _updateCustomTheme();
            });
          }),

          _buildColorPicker('Sabbath Days', _sabbathColor, (color) {
            setState(() {
              _sabbathColor = color;
              _updateCustomTheme();
            });
          }),

          _buildColorPicker('Full Moon', _fullMoonColor, (color) {
            setState(() {
              _fullMoonColor = color;
              _updateCustomTheme();
            });
          }),

          _buildColorPicker('New Moon', _newMoonColor, (color) {
            setState(() {
              _newMoonColor = color;
              _updateCustomTheme();
            });
          }),

          SizedBox(height: 20),

          _buildSlider('Border Radius', _borderRadius, 0, 20, (value) {
            setState(() {
              _borderRadius = value;
              _updateCustomTheme();
            });
          }),

          _buildSlider('Elevation', _elevation, 0, 10, (value) {
            setState(() {
              _elevation = value;
              _updateCustomTheme();
            });
          }),
        ],
      ),
    );
  }

  Widget _buildColorPicker(
    String label,
    Color color,
    Function(Color) onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
          ),
          GestureDetector(
            onTap: () => _showColorPicker(color, onChanged),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(
    String label,
    double value,
    double min,
    double max,
    Function(double) onChanged,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
              Text(
                value.toStringAsFixed(1),
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
          ),
          Slider(
            value: value,
            min: min,
            max: max,
            divisions: ((max - min) * 2).toInt(),
            onChanged: onChanged,
            activeColor: Colors.deepPurple,
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _exportTheme,
              icon: Icon(Icons.download),
              label: Text('Export Theme'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: _resetToDefault,
              icon: Icon(Icons.restore),
              label: Text('Reset to Default'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarPreview() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: MyanmarCalendarWidget(
          initialDate: _selectedDate,
          language: _language,
          theme: _currentTheme,
          showHolidays: true,
          showAstrology: true,
          onDateSelected: (date) {
            setState(() {
              _selectedDate = date.western.toDateTime();
            });
          },
          height: 400,
        ),
      ),
    );
  }

  Widget _buildDatePickerPreview() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.grey[50],
              child: Row(
                children: [
                  Icon(Icons.date_range, color: Colors.deepPurple),
                  SizedBox(width: 8),
                  Text(
                    'Date Picker Preview',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Selected Date:',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _currentTheme.headerBackgroundColor.withValues(
                        alpha: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: _currentTheme.headerBackgroundColor.withValues(
                          alpha: 0.3,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          MyanmarCalendar.fromDateTime(
                            _selectedDate,
                          ).formatMyanmar(),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: _currentTheme.headerBackgroundColor,
                          ),
                        ),
                        Text(
                          MyanmarCalendar.fromDateTime(
                            _selectedDate,
                          ).formatWestern(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _showDatePicker(),
                      icon: Icon(Icons.edit_calendar),
                      label: Text('Open Date Picker'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _currentTheme.headerBackgroundColor,
                        foregroundColor: _currentTheme.headerTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showColorPicker(Color currentColor, Function(Color) onChanged) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Pick a Color'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Predefined colors
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children:
                    [
                          Colors.red,
                          Colors.pink,
                          Colors.purple,
                          Colors.deepPurple,
                          Colors.indigo,
                          Colors.blue,
                          Colors.lightBlue,
                          Colors.cyan,
                          Colors.teal,
                          Colors.green,
                          Colors.lightGreen,
                          Colors.lime,
                          Colors.yellow,
                          Colors.amber,
                          Colors.orange,
                          Colors.deepOrange,
                          Colors.brown,
                          Colors.grey,
                          Colors.blueGrey,
                          Colors.black,
                        ]
                        .map(
                          (color) => GestureDetector(
                            onTap: () {
                              onChanged(color);
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: currentColor == color
                                      ? Colors.white
                                      : Colors.transparent,
                                  width: 3,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _updateCustomProperties() {
    _headerBackgroundColor = _currentTheme.headerBackgroundColor;
    _backgroundColor = _currentTheme.backgroundColor;
    _selectedDateColor = _currentTheme.selectedDateBackgroundColor;
    _todayColor = _currentTheme.todayBackgroundColor;
    _sabbathColor = _currentTheme.sabbathBackgroundColor;
    _fullMoonColor = _currentTheme.fullMoonBackgroundColor;
    _newMoonColor = _currentTheme.newMoonBackgroundColor;
    _borderRadius = _currentTheme.borderRadius;
    _elevation = _currentTheme.elevation;
  }

  void _updateCustomTheme() {
    _currentTheme = _currentTheme.copyWith(
      headerBackgroundColor: _headerBackgroundColor,
      backgroundColor: _backgroundColor,
      selectedDateBackgroundColor: _selectedDateColor,
      todayBackgroundColor: _todayColor,
      sabbathBackgroundColor: _sabbathColor,
      fullMoonBackgroundColor: _fullMoonColor,
      newMoonBackgroundColor: _newMoonColor,
      borderRadius: _borderRadius,
      elevation: _elevation,
    );
    _selectedThemeName = 'Custom';
  }

  void _showDatePicker() async {
    final result = await showMyanmarDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      language: _language,
      theme: _currentTheme,
    );

    if (result != null) {
      setState(() {
        _selectedDate = result.western.toDateTime();
      });
    }
  }

  void _exportTheme() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Export Theme'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Theme Code:',
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
                  _generateThemeCode(),
                  style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Copy this code and use it in your Flutter app to apply this theme.',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
            ],
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

  String _generateThemeCode() {
    return '''MyanmarCalendarTheme(
  backgroundColor: Color(0x${_backgroundColor.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}),
  headerBackgroundColor: Color(0x${_headerBackgroundColor.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}),
  selectedDateBackgroundColor: Color(0x${_selectedDateColor.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}),
  todayBackgroundColor: Color(0x${_todayColor.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}),
  sabbathBackgroundColor: Color(0x${_sabbathColor.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}),
  fullMoonBackgroundColor: Color(0x${_fullMoonColor.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}),
  newMoonBackgroundColor: Color(0x${_newMoonColor.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}),
  borderRadius: $_borderRadius,
  elevation: $_elevation,
  // ... other properties with default values
)''';
  }

  //   void _exportTheme() {
  //     // Generate theme code
  //     final themeCode =
  //         '''
  // final customTheme = MyanmarCalendarTheme(
  //   headerBackgroundColor: Color(0x${_headerBackgroundColor.toARGB32().toRadixString(16)}),
  //   backgroundColor: Color(0x${_backgroundColor.toARGB32().toRadixString(16)}),
  //   selectedDateBackgroundColor: Color(0x${_selectedDateColor.toARGB32().toRadixString(16)}),
  //   todayBackgroundColor: Color(0x${_todayColor.toARGB32().toRadixString(16)}),
  //   sabbathBackgroundColor: Color(0x${_sabbathColor.toARGB32().toRadixString(16)}),
  //   fullMoonBackgroundColor: Color(0x${_fullMoonColor.toARGB32().toRadixString(16)}),
  //   newMoonBackgroundColor: Color(0x${_newMoonColor.toARGB32().toRadixString(16)}),
  //   borderRadius: $_borderRadius,
  //   elevation: $_elevation,
  // );
  // ''';

  //     // Copy to clipboard
  //     Clipboard.setData(ClipboardData(text: themeCode));

  //     // Show snackbar
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Theme code copied to clipboard'),
  //         backgroundColor: Colors.deepPurple,
  //       ),
  //     );
  //   }

  void _resetToDefault() {
    setState(() {
      _selectedThemeName = 'Default';
      _currentTheme = MyanmarCalendarTheme.defaultTheme();
      _updateCustomProperties();
    });
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
