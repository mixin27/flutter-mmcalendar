import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// The converter, date arithmetic, AI prompts and chronicles.
class ToolsPage extends StatefulWidget {
  const ToolsPage({super.key});

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  DateTime _historyDate = DateTime(1850);

  @override
  Widget build(BuildContext context) {
    final strings = MmStrings.of(MyanmarCalendarScope.of(context).language);
    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 110),
      children: [
        const MyanmarDateConverter(title: 'Converter'),
        const SizedBox(height: 12),
        DateDifferenceCard(to: DateTime.now().add(const Duration(days: 30))),
        const SizedBox(height: 12),
        AIPromptAction(
          onPrompt: (type, prompt) async {
            await Clipboard.setData(ClipboardData(text: prompt));
            if (!context.mounted) return;
            ScaffoldMessenger.maybeOf(context)?.showSnackBar(
              SnackBar(content: Text('Copied the ${type.name} prompt')),
            );
          },
        ),
        const SizedBox(height: 12),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: MmButton(
            label: '${strings.history}: ${_historyDate.year}',
            icon: Icons.history_edu,
            variant: MmButtonVariant.tonal,
            onPressed: () async {
              final d = await showMyanmarDatePicker(
                context: context,
                initialDate: _historyDate,
                firstDate: DateTime(1100),
                lastDate: DateTime.now(),
              );
              if (d != null) {
                setState(
                  () => _historyDate = DateTime(
                    d.western.year,
                    d.western.month,
                    d.western.day,
                  ),
                );
              }
            },
          ),
        ),
        const SizedBox(height: 8),
        ChronicleCard(date: _historyDate),
      ],
    );
  }
}
