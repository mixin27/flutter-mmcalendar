import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class HoroscopeDemoPage extends StatefulWidget {
  const HoroscopeDemoPage({super.key});

  @override
  State<HoroscopeDemoPage> createState() => _HoroscopeDemoPageState();
}

class _HoroscopeDemoPageState extends State<HoroscopeDemoPage> {
  DateTime _selectedDate = DateTime.now();
  Language _language = Language.english;

  @override
  Widget build(BuildContext context) {
    // Get the complete date for the selected western date
    final completeDate = MyanmarCalendar.getCompleteDate(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Horoscope & AI Prompt'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton<Language>(
            icon: const Icon(Icons.language),
            onSelected: (lang) {
              setState(() {
                _language = lang;
              });
              MyanmarCalendar.setLanguage(lang);
            },
            itemBuilder: (context) => Language.values.map((lang) {
              return PopupMenuItem(
                value: lang,
                child: Text(lang.name.toUpperCase()),
              );
            }).toList(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildDateHeader(),
            const SizedBox(height: 24),
            Text(
              'Traditional Horoscope',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 12),
            HoroscopeWidget(date: completeDate, language: _language),
            const SizedBox(height: 32),
            _buildAIPromptSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDateHeader() {
    return Card(
      elevation: 0,
      color: Colors.deepPurple.withValues(alpha: 0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.deepPurple.withValues(alpha: 0.1)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.event_note, size: 40, color: Colors.deepPurple),
            const SizedBox(height: 12),
            Text(
              'Daily Astrological Profile',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple[800],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Select a date to see detailed astrological calculations and generate AI-ready prompts.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.calendar_month),
              label: Text(_selectedDate.toString().split(' ').first),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAIPromptSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.amber.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.amber),
              const SizedBox(width: 8),
              Text(
                'AI Prompt Feature',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.amber[900],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'The AI Prompt feature generates a highly structured text that you can copy and paste into AI platforms like Gemini, ChatGPT, or Claude to get a professional astrological reading inspired by traditional Burmese knowledge.',
          ),
          const SizedBox(height: 16),
          const Text(
            'Try clicking the "Generate AI Prompt" button in the horoscope card above to see the available reading types!',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
