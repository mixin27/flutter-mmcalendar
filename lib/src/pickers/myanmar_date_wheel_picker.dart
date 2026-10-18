import 'package:flutter/cupertino.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../calendars/myanmar_lunar_month_calendar.dart';
import '../foundation/language_locale.dart';
import '../foundation/mm_strings.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';

/// Picks a Myanmar date the way it is said: year, month, then the day of
/// the waxing or waning fortnight.
///
/// The wheels only offer what exists: First and Second Waso appear only in
/// watat years, Late Tagu and Late Kason only where the year has them, and
/// a 29-day month's waning fortnight ends on its new moon at 14. Changing the
/// year or month keeps the nearest valid choice.
class MyanmarDateWheelPicker extends StatefulWidget {
  /// Creates a wheel picker starting on [initialDate].
  const MyanmarDateWheelPicker({
    required this.initialDate,
    required this.onChanged,
    super.key,
    this.firstYear,
    this.lastYear,
    this.itemExtent = 38,
    this.height = 200,
    this.style,
  });

  /// The Western day to start on.
  final DateTime initialDate;

  /// Called with each day the wheels settle on.
  final ValueChanged<CompleteDate> onChanged;

  /// The earliest Myanmar year offered; 100 years back by default.
  final int? firstYear;

  /// The latest Myanmar year offered; 100 years ahead by default.
  final int? lastYear;

  /// The height of one row.
  final double itemExtent;

  /// The wheels' height.
  final double height;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  @override
  State<MyanmarDateWheelPicker> createState() => _MyanmarDateWheelPickerState();
}

class _MyanmarDateWheelPickerState extends State<MyanmarDateWheelPicker> {
  late int _year;
  late int _month;
  late int _dayIndex;
  late int _firstYear;
  late int _lastYear;

  late List<int> _months;
  late List<MyanmarDate> _days;

  FixedExtentScrollController? _yearWheel;
  FixedExtentScrollController? _monthWheel;
  FixedExtentScrollController? _dayWheel;

  MyanmarCalendarClient? _client;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final scope = MyanmarCalendarScope.of(context);
    if (_client == null) {
      _client = scope.client;
      final start = scope.day(widget.initialDate).myanmar;
      _year = start.year;
      _month = start.month;
      _firstYear = widget.firstYear ?? start.year - 100;
      _lastYear = widget.lastYear ?? start.year + 100;
      _load();
      _dayIndex = _days
          .indexWhere((d) => d.day == start.day)
          .clamp(0, _days.length - 1);
      _yearWheel = FixedExtentScrollController(initialItem: _year - _firstYear);
      _monthWheel = FixedExtentScrollController(
        initialItem: _months.indexOf(_month),
      );
      _dayWheel = FixedExtentScrollController(initialItem: _dayIndex);
    }
  }

  @override
  void dispose() {
    _yearWheel?.dispose();
    _monthWheel?.dispose();
    _dayWheel?.dispose();
    super.dispose();
  }

  void _load() {
    _months = MyanmarLunarMonthCalendar.monthsOf(_client!, _year);
    if (!_months.contains(_month)) _month = _nearestMonth(_month);
    _days = _client!.getMyanmarMonth(_year, _month);
  }

  // A month the year lacks maps to its neighbour: First Waso to Waso, a
  // late month to its ordinary one, else the first month.
  int _nearestMonth(int month) {
    const fallback = {0: 4, 4: 0, 13: 1, 1: 13, 14: 2, 2: 14};
    final alt = fallback[month];
    if (alt != null && _months.contains(alt)) return alt;
    return _months.first;
  }

  // After the lists change, move the wheels to the kept choice once they
  // have rebuilt with the new item counts.
  void _jump(FixedExtentScrollController? wheel, int item) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || wheel == null || !wheel.hasClients) return;
      if (wheel.selectedItem != item) wheel.jumpToItem(item);
    });
  }

  void _changed() {
    _dayIndex = _dayIndex.clamp(0, _days.length - 1);
    final date = _days[_dayIndex];
    widget.onChanged(
      MyanmarCalendarScope.of(
        context,
      ).day(MyanmarLunarMonthCalendar.westernOf(date)),
    );
  }

  void _onYear(int index) {
    setState(() {
      _year = _firstYear + index;
      _load();
    });
    _jump(_monthWheel, _months.indexOf(_month));
    _jump(_dayWheel, _dayIndex.clamp(0, _days.length - 1));
    _changed();
  }

  void _onMonth(int index) {
    setState(() {
      _month = _months[index];
      _days = _client!.getMyanmarMonth(_year, _month);
    });
    _jump(_dayWheel, _dayIndex.clamp(0, _days.length - 1));
    _changed();
  }

  void _onDay(int index) {
    setState(() => _dayIndex = index);
    _changed();
  }

  @override
  Widget build(BuildContext context) {
    final scope = MyanmarCalendarScope.of(context);
    final theme = MyanmarCalendarScope.themeOf(context);
    final style = MyanmarCalendarScope.styleOf(context, widget.style);
    final strings = MmStrings.of(scope.language);
    final language = scope.language;
    final yearType = _days.isEmpty ? 0 : _days.first.yearType;

    final text = theme
        .textStyle(TextStyle(color: theme.ink, fontSize: 17), language)
        .copyWith(height: 1.2);

    Widget overlay() => style == MmVisualStyle.material
        ? DecoratedBox(
            decoration: BoxDecoration(
              border: Border.symmetric(
                horizontal: BorderSide(color: theme.accent, width: 1.2),
              ),
            ),
          )
        : CupertinoPickerDefaultSelectionOverlay(
            background: theme.ink.withValues(alpha: 0.07),
          );

    Widget wheel({
      required String label,
      required FixedExtentScrollController? controller,
      required int count,
      required String Function(int) itemLabel,
      required ValueChanged<int> onSelected,
      int flex = 1,
    }) => Expanded(
      flex: flex,
      child: Semantics(
        label: label,
        child: CupertinoPicker.builder(
          scrollController: controller,
          itemExtent: widget.itemExtent,
          selectionOverlay: overlay(),
          onSelectedItemChanged: onSelected,
          childCount: count,
          itemBuilder: (context, i) => Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(itemLabel(i), style: text, maxLines: 1),
              ),
            ),
          ),
        ),
      ),
    );

    return SizedBox(
      height: widget.height,
      child: DefaultTextStyle(
        style: text,
        child: Row(
          children: [
            wheel(
              label: TranslationService.translateTo('Myanmar Year', language),
              controller: _yearWheel,
              count: _lastYear - _firstYear + 1,
              itemLabel: (i) => language.digits(_firstYear + i),
              onSelected: _onYear,
              flex: 4,
            ),
            wheel(
              label: strings.month,
              controller: _monthWheel,
              count: _months.length,
              itemLabel: (i) => strings.myanmarMonth(_months[i], yearType),
              onSelected: _onMonth,
              flex: 6,
            ),
            wheel(
              label: strings.day,
              controller: _dayWheel,
              count: _days.length,
              itemLabel: (i) => strings.fortnightDay(_days[i]),
              onSelected: _onDay,
              flex: 6,
            ),
          ],
        ),
      ),
    );
  }
}
