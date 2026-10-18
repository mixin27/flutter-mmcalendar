import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

/// Sample events, so the event dots and agenda have something to show.
final Map<DateTime, List<String>> sampleEvents = () {
  final now = DateTime.now();
  DateTime d(int offset) => DateTime(now.year, now.month, now.day + offset);
  return {
    d(2): ['Pagoda visit with Grandma'],
    d(5): ['Dinner with the family'],
    d(9): ['Monastery donation', 'Call Ma Ma'],
    d(16): ['Robe offering'],
  };
}();

List<Object?> loadSampleEvents(DateTime day) =>
    sampleEvents[DateUtils.dateOnly(day)] ?? const [];

/// The month calendar, with the selected day beside or under it.
class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final _controller = MyanmarCalendarController(
    selection: SingleSelection(DateTime.now()),
  );
  MyanmarDayCellStyle _cellStyle = MyanmarDayCellStyle.dual;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DateTime get _selected =>
      _controller.selection.days.firstOrNull ??
      DateUtils.dateOnly(DateTime.now());

  Widget _cellStyles() => SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: MmSegmented<MyanmarDayCellStyle>(
      segments: const {
        MyanmarDayCellStyle.dual: 'Dual',
        MyanmarDayCellStyle.westernFirst: 'Western',
        MyanmarDayCellStyle.lunarFirst: 'Lunar',
        MyanmarDayCellStyle.minimal: 'Minimal',
        MyanmarDayCellStyle.moon: 'Moon',
      },
      selected: _cellStyle,
      onChanged: (s) => setState(() => _cellStyle = s),
    ),
  );

  Widget _calendar() => MyanmarMonthCalendar(
    controller: _controller,
    cellStyle: _cellStyle,
    eventLoader: loadSampleEvents,
    headerTrailing: MmButton(
      label: MmStrings.of(MyanmarCalendarScope.of(context).language).today,
      variant: MmButtonVariant.tonal,
      onPressed: () {
        final today = DateTime.now();
        _controller
          ..jumpTo(today)
          ..select(today);
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    if (width >= 1180) {
      // Desktop: sidebar, a large calendar, and an inspector.
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 250,
              child: ListView(
                children: [
                  MmSurface(
                    padding: const EdgeInsets.all(12),
                    child: MyanmarMiniMonth(
                      month: _controller.visibleMonth,
                      selection: _controller.selection,
                      onDayTapped: (d) => _controller.select(
                        DateTime(
                          d.western.year,
                          d.western.month,
                          d.western.day,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const HolidayList.upcoming(days: 90, limit: 6),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  _cellStyles(),
                  const SizedBox(height: 12),
                  Expanded(child: _calendar()),
                ],
              ),
            ),
            const SizedBox(width: 16),
            SizedBox(
              width: 340,
              child: ListView(
                children: [
                  MyanmarTodayCard(date: _selected),
                  const SizedBox(height: 12),
                  MyanmarDayDetails(date: _selected),
                ],
              ),
            ),
          ],
        ),
      );
    }

    if (width >= 700) {
      // Tablet: the calendar and the day side by side.
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: Column(
                children: [
                  _cellStyles(),
                  const SizedBox(height: 12),
                  Expanded(child: _calendar()),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 4,
              child: ListView(
                children: [
                  MyanmarTodayCard(date: _selected),
                  const SizedBox(height: 12),
                  MyanmarDayDetails(
                    date: _selected,
                    sections: const [
                      DaySection.dates,
                      DaySection.holidays,
                      DaySection.astrology,
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Phone: everything in one scroll, room left for the floating tab bar.
    return ListView(
      padding: const EdgeInsets.fromLTRB(0, 12, 0, 110),
      children: [
        _cellStyles(),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: _calendar(),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: MyanmarTodayCard(date: _selected),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: MyanmarWeekStrip(controller: _controller),
        ),
      ],
    );
  }
}
