import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

import 'calendar_page.dart';

/// The year, the Myanmar month by fortnight, and the agenda.
class ViewsPage extends StatefulWidget {
  const ViewsPage({super.key});

  @override
  State<ViewsPage> createState() => _ViewsPageState();
}

enum _View { year, lunar, agenda }

class _ViewsPageState extends State<ViewsPage> {
  _View _view = _View.lunar;

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final Widget body = switch (_view) {
      _View.year => ListView(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 110),
        children: [MyanmarYearCalendar(year: today.year)],
      ),
      _View.lunar => ListView(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 110),
        children: [
          MyanmarLunarMonthCalendar.forDay(context, today),
          const SizedBox(height: 12),
          Builder(
            builder: (context) {
              final m = MyanmarCalendarScope.of(context).day(today).myanmar;
              return MoonPhaseStrip(year: m.year, month: m.month);
            },
          ),
        ],
      ),
      _View.agenda => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: MmSurface(
          child: MyanmarAgenda(
            eventLoader: loadSampleEvents,
            padding: const EdgeInsets.only(bottom: 110),
          ),
        ),
      ),
    };
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: MmSegmented<_View>(
            segments: const {
              _View.year: 'Year',
              _View.lunar: 'Lunar',
              _View.agenda: 'Agenda',
            },
            selected: _view,
            onChanged: (v) => setState(() => _view = v),
          ),
        ),
        Expanded(child: body),
      ],
    );
  }
}
