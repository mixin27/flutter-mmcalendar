import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class CalendarLanguageListTile extends StatelessWidget {
  const CalendarLanguageListTile({super.key});

  @override
  Widget build(BuildContext context) {
    void changeCalendarLanguage(Language lang) {
      GlobalCalendarConfig().setLanguage(lang);
      Navigator.of(context).pop();
    }

    void handleTap() {
      showAdaptiveDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Change calendar language"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () => changeCalendarLanguage(Language.myanmar),
                  title: const Text('Myanmar (Unicode)'),
                  trailing:
                      GlobalCalendarConfig().config.language == Language.myanmar
                      ? const Icon(Icons.check_outlined, color: Colors.green)
                      : null,
                ),
                ListTile(
                  onTap: () => changeCalendarLanguage(Language.zawgyi),
                  title: const Text('Myanmar (Zawgyi)'),
                  trailing:
                      GlobalCalendarConfig().config.language == Language.zawgyi
                      ? const Icon(Icons.check_outlined, color: Colors.green)
                      : null,
                ),
                ListTile(
                  onTap: () => changeCalendarLanguage(Language.english),
                  title: const Text('English'),
                  trailing:
                      GlobalCalendarConfig().config.language == Language.english
                      ? const Icon(Icons.check_outlined, color: Colors.green)
                      : null,
                ),
                ListTile(
                  onTap: () => changeCalendarLanguage(Language.karen),
                  title: const Text('Karen'),
                  trailing:
                      GlobalCalendarConfig().config.language == Language.karen
                      ? const Icon(Icons.check_outlined, color: Colors.green)
                      : null,
                ),
                ListTile(
                  onTap: () => changeCalendarLanguage(Language.mon),
                  title: const Text('Mon'),
                  trailing:
                      GlobalCalendarConfig().config.language == Language.mon
                      ? const Icon(Icons.check_outlined, color: Colors.green)
                      : null,
                ),
                ListTile(
                  onTap: () => changeCalendarLanguage(Language.tai),
                  title: const Text('Tai'),
                  trailing:
                      GlobalCalendarConfig().config.language == Language.tai
                      ? const Icon(Icons.check_outlined, color: Colors.green)
                      : null,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final lang = switch (GlobalCalendarConfig().config.language) {
      Language.myanmar => 'Myanmar (Unicode)',
      Language.karen => 'Karen',
      Language.mon => 'Mon',
      Language.zawgyi => 'Myanmar (Zawgyi)',
      Language.tai => 'Tai',
      _ => 'English',
    };

    return ListTile(
      onTap: handleTap,
      leading: const Icon(Icons.calendar_month_outlined),
      title: const Text('Calendar Language'),
      subtitle: Text(lang),
    );
  }
}
