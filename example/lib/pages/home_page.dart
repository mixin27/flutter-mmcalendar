import 'package:example/pages/chronicle_demo_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

import 'api_demo_page.dart';
import 'astrological_demo_page.dart';
import 'cache_demo_page.dart';
import 'calendar_demo_page.dart';
import 'converter_demo_page.dart';
import 'holiday_demo_page.dart';
import 'theme_demo_page.dart';
import 'utilities_demo_page.dart';
import 'selection_demo_page.dart';
import 'horoscope_demo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Language _currentLanguage = Language.english;
  MyanmarDateTime _selectedDate = MyanmarCalendar.today();
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Myanmar Calendar Demo'),
        backgroundColor: _isDarkMode ? Colors.grey[900] : Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          // Language selector
          PopupMenuButton<Language>(
            icon: Icon(Icons.language),
            onSelected: _changeLanguage,
            itemBuilder: (context) => Language.values.map((lang) {
              return PopupMenuItem(
                value: lang,
                child: Text(_getLanguageName(lang)),
              );
            }).toList(),
          ),

          // Dark mode toggle
          IconButton(
            icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              setState(() {
                _isDarkMode = !_isDarkMode;
              });
            },
          ),
        ],
      ),
      body: Container(
        color: _isDarkMode ? Colors.grey[850] : Colors.grey[50],
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildWelcomeCard(),
            SizedBox(height: 16),
            _buildQuickInfoCard(),
            SizedBox(height: 16),
            _buildFeatureGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: LinearGradient(
            colors: _isDarkMode
                ? [Colors.grey[800]!, Colors.grey[700]!]
                : [Colors.indigo[400]!, Colors.indigo[600]!],
          ),
        ),
        child: Column(
          children: [
            Icon(Icons.calendar_today, size: 48, color: Colors.white),
            SizedBox(height: 16),
            Text(
              'Myanmar Calendar Flutter',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Text(
              'Complete Myanmar calendar system with astrological calculations',
              style: TextStyle(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickInfoCard() {
    final today = _selectedDate;

    return Card(
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.today, color: Colors.indigo),
                SizedBox(width: 8),
                Text(
                  'Today\'s Information',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Divider(),

            // Date information
            _buildInfoRow('Myanmar Date', today.formatMyanmar()),
            _buildInfoRow('Western Date', today.formatWestern()),
            _buildInfoRow('Sasana Year', '${today.sasanaYear}'),
            _buildInfoRow('Moon Phase', _getMoonPhaseName(today.moonPhase)),

            if (today.isSabbath) _buildInfoChip('Sabbath Day', Colors.orange),

            if (today.hasHolidays)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Holidays:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    children: today.allHolidays
                        .map((holiday) => _buildInfoChip(holiday, Colors.red))
                        .toList(),
                  ),
                ],
              ),

            if (today.hasAstrologicalDays)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Text(
                    'Astrological:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    children: today.astrologicalDays
                        .map((day) => _buildInfoChip(day, Colors.purple))
                        .toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureGrid() {
    final features = [
      FeatureItem(
        title: 'Calendar Widget',
        description: 'Interactive calendar with Myanmar dates',
        icon: Icons.calendar_month,
        onTap: () => _navigateToCalendarDemo(),
      ),
      FeatureItem(
        title: 'Date Picker',
        description: 'Beautiful date picker dialogs',
        icon: Icons.date_range,
        onTap: () => _showDatePickerDemo(),
      ),
      FeatureItem(
        title: 'Date Converter',
        description: 'Convert between calendar systems',
        icon: Icons.transform,
        onTap: () => _navigateToConverterDemo(),
      ),
      FeatureItem(
        title: 'Astrological Info',
        description: 'Buddhist calendar calculations',
        icon: Icons.star,
        onTap: () => _navigateToAstroDemo(),
      ),
      FeatureItem(
        title: 'Holiday Calendar',
        description: 'Myanmar holidays and festivals',
        icon: Icons.celebration,
        onTap: () => _navigateToHolidayDemo(),
      ),
      FeatureItem(
        title: 'Theme Examples',
        description: 'Different theme variations',
        icon: Icons.palette,
        onTap: () => _navigateToThemeDemo(),
      ),
      FeatureItem(
        title: 'Date Utilities',
        description: 'Date calculations and utilities',
        icon: Icons.calculate,
        onTap: () => _navigateToUtilsDemo(),
      ),
      FeatureItem(
        title: 'Chronicle',
        description: 'Chronicle of Myanmar',
        icon: Icons.history,
        onTap: () => _navigateToChronicleDemo(),
      ),
      FeatureItem(
        title: 'Cache',
        description: 'Cache system',
        icon: Icons.memory,
        onTap: () => _navigateToCacheDemo(),
      ),
      FeatureItem(
        title: 'API Examples',
        description: 'Code examples and usage',
        icon: Icons.code,
        onTap: () => _navigateToAPIDemo(),
      ),
      FeatureItem(
        title: 'Selection & Astro',
        description: 'Range selection and astrology',
        icon: Icons.auto_awesome,
        onTap: () => _navigateToSelectionDemo(),
      ),
      FeatureItem(
        title: 'Horoscope & AI',
        description: 'Traditional horoscope and AI prompts',
        icon: Icons.auto_awesome,
        onTap: () => _navigateToHoroscopeDemo(),
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.0,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return Card(
          elevation: 3,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: feature.onTap,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(feature.icon, size: 36, color: Colors.indigo),
                  SizedBox(height: 12),
                  Text(
                    feature.title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    feature.description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(String label, Color color) {
    return Container(
      margin: EdgeInsets.only(right: 8, top: 4),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
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

  void _changeLanguage(Language language) {
    setState(() {
      _currentLanguage = language;
    });
    MyanmarCalendar.setLanguage(language);
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

  void _navigateToCalendarDemo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CalendarDemoPage()),
    );
  }

  void _navigateToConverterDemo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConverterDemoPage()),
    );
  }

  void _navigateToAstroDemo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AstrologicalDemoPage()),
    );
  }

  void _navigateToHolidayDemo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HolidayDemoPage()),
    );
  }

  void _navigateToThemeDemo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ThemeDemoPage()),
    );
  }

  void _navigateToUtilsDemo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UtilitiesDemoPage()),
    );
  }

  void _navigateToChronicleDemo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChronicleDemoPage()),
    );
  }

  void _navigateToCacheDemo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CacheDemoPage()),
    );
  }

  void _navigateToAPIDemo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => APIDemoPage()),
    );
  }

  void _navigateToSelectionDemo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionDemoPage()),
    );
  }

  void _navigateToHoroscopeDemo() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HoroscopeDemoPage()),
    );
  }

  Future<void> _showDatePickerDemo() async {
    final selectedDate = await showMyanmarDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      language: _currentLanguage,
      showHolidays: true,
      showAstrology: true,
    );

    if (selectedDate != null) {
      setState(() {
        _selectedDate = MyanmarDateTime.fromDateTime(
          selectedDate.western.toDateTime(),
        );
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Selected: ${selectedDate.toDetailedString()}'),
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }
}

class FeatureItem {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onTap;

  FeatureItem({
    required this.title,
    required this.description,
    required this.icon,
    required this.onTap,
  });
}
