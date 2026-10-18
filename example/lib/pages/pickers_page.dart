import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// Every picker, and what each one returned.
class PickersPage extends StatefulWidget {
  const PickersPage({super.key});

  @override
  State<PickersPage> createState() => _PickersPageState();
}

class _PickersPageState extends State<PickersPage> {
  final _form = GlobalKey<FormState>();
  final _inline = MyanmarCalendarController(
    selection: SingleSelection(DateTime.now()),
  );
  String _result = 'Nothing picked yet';

  @override
  void dispose() {
    _inline.dispose();
    super.dispose();
  }

  String _describe(CompleteDate d) {
    final scope = MyanmarCalendarScope.of(context);
    final s = MmStrings.of(scope.language);
    final w = DateTime(d.western.year, d.western.month, d.western.day);
    return '${s.westernDate(w)} · ${s.myanmarDate(d.myanmar)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyanmarCalendarScope.themeOf(context);
    return ListView(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 110),
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            MmButton(
              label: 'Date',
              icon: Icons.today,
              onPressed: () async {
                final d = await showMyanmarDatePicker(context: context);
                if (d != null) setState(() => _result = _describe(d));
              },
            ),
            MmButton(
              label: 'Myanmar wheels',
              icon: Icons.tune,
              variant: MmButtonVariant.tonal,
              onPressed: () async {
                final d = await showMyanmarDatePicker(
                  context: context,
                  inputMode: MyanmarPickerInput.wheels,
                );
                if (d != null) setState(() => _result = _describe(d));
              },
            ),
            MmButton(
              label: 'Range',
              icon: Icons.date_range,
              variant: MmButtonVariant.tonal,
              onPressed: () async {
                final r = await showMyanmarDateRangePicker(context: context);
                if (r != null) {
                  setState(
                    () => _result =
                        '${_describe(r.start)} → ${_describe(r.end)} '
                        '(${r.dayCount} days)',
                  );
                }
              },
            ),
            MmButton(
              label: 'Several days',
              icon: Icons.event_note,
              variant: MmButtonVariant.tonal,
              onPressed: () async {
                final days = await showMyanmarMultiDatePicker(context: context);
                if (days != null) {
                  setState(() => _result = days.map(_describe).join('\n'));
                }
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Semantics(
          liveRegion: true,
          child: Text(_result, style: TextStyle(color: theme.muted)),
        ),
        const SizedBox(height: 16),
        MmSurface(
          padding: const EdgeInsets.all(14),
          child: MyanmarDatePicker(controller: _inline),
        ),
        const SizedBox(height: 16),
        MmSurface(
          padding: const EdgeInsets.all(14),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyanmarDateFormField(
                  label: 'Ordination date',
                  hint: 'Choose a day',
                  validator: (d) => d == null ? 'Pick a date' : null,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: MmButton(
                    label: 'Check',
                    onPressed: () => _form.currentState!.validate(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
