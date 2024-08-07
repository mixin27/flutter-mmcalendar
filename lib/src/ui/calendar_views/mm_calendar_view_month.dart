import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

/// Myanmar calendar month view.
class MmCalendarViewMonth extends StatelessWidget {
  const MmCalendarViewMonth({
    super.key,
    this.viewHeaderHeight = 50,
    this.showDatePickerButton = false,
    this.showNavigationArrow = false,
    this.showTrailingAndLeadingDates = true,
    this.onTap,
    this.onLongPress,
    this.onSelectionChanged,
    this.onViewChanged,
  });

  /// The height of the view header to the layout within this in [MmCalendarViewMonth].
  final double viewHeaderHeight;

  /// Displays the date picker when the [MmCalendarViewMonth] header date is tapped.
  ///
  /// The date picker will be used for quick date navigation in [MmCalendarViewMonth].
  final bool showDatePickerButton;

  ///   Displays the navigation arrows on the header view of [MmCalendarViewMonth].
  ///
  /// If this property set as [true] the header view of [MmCalendarViewMonth] will display
  /// the navigation arrows which used to navigate to the previous/next views through
  /// the navigation icon buttons.
  final bool showNavigationArrow;

  /// Makes the leading and trailing dates visible for the [MmCalendarViewMonth] month view.
  final bool showTrailingAndLeadingDates;

  /// Called whenever the [MmCalendarViewMonth] elements tapped on view.
  ///
  /// The tapped date, appointments, and element details when the tap action performed
  /// on element available in the [CalendarTapDetails].
  final void Function(
    CalendarTapDetails calendarTapDetails,
    MyanmarDate? mmDate,
    Astro? astro,
    List<String>? holidays,
  )? onTap;

  /// Called whenever the [MmCalendarViewMonth] elements long pressed on view.
  ///
  /// The long-pressed date, appointments, and element details when the long-press action performed on element
  /// available in the [CalendarLongPressDetails].
  final void Function(
    CalendarLongPressDetails calendarLongPressDetails,
    MyanmarDate? mmDate,
    Astro? astro,
    List<String>? holidays,
  )? onLongPress;

  /// Called whenever a [MmCalendarViewMonth] cell is selected.
  ///
  /// The callback details argument contains the selected date and its resource details.
  final void Function(
    CalendarSelectionDetails calendarSelectionDetails,
    MyanmarDate? mmDate,
    Astro? astro,
    List<String>? holidays,
  )? onSelectionChanged;

  /// Called when the current visible date changes in [MmCalendarViewMonth].
  ///
  /// Called in the following scenarios when the visible dates were changed
  final void Function(
    ViewChangedDetails viewChangedDetails,
  )? onViewChanged;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (context, orientation) {
      final isLanscape = orientation == Orientation.landscape;

      return SfCalendar(
        view: CalendarView.month,
        showDatePickerButton: showDatePickerButton,
        showNavigationArrow: showNavigationArrow,
        monthViewSettings: MonthViewSettings(
          showTrailingAndLeadingDates: showTrailingAndLeadingDates,
        ),
        viewHeaderHeight: viewHeaderHeight,
        onTap: (details) {
          if (details.date == null) {
            return onTap?.call(details, null, null, null);
          }

          final mmDate = getDateMM(details.date!);
          final astro = AstroConverter.convert(mmDate);
          final holidays = HolidaysCalculator.getHolidays(mmDate);
          onTap?.call(details, mmDate, astro, holidays);
        },
        onLongPress: (details) {
          if (details.date == null) {
            return onLongPress?.call(details, null, null, null);
          }

          final mmDate = getDateMM(details.date!);
          final astro = AstroConverter.convert(mmDate);
          final holidays = HolidaysCalculator.getHolidays(mmDate);
          onLongPress?.call(details, mmDate, astro, holidays);
        },
        onSelectionChanged: (details) {
          if (details.date == null) {
            return onSelectionChanged?.call(details, null, null, null);
          }

          final mmDate = getDateMM(details.date!);
          final astro = AstroConverter.convert(mmDate);
          final holidays = HolidaysCalculator.getHolidays(mmDate);
          onSelectionChanged?.call(details, mmDate, astro, holidays);
        },
        onViewChanged: onViewChanged,
        monthCellBuilder: (context, details) {
          final mmDate = getDateMM(details.date);
          final mmMoonPhase = mmDate.getMoonPhase();
          final mmFortnightDay = mmDate.getFortnightDay();

          final isToday = DateFormat('dd-MM-yyyy').format(details.date) ==
              DateFormat('dd-MM-yyyy').format(DateTime.now());

          final isHoliday = HolidaysCalculator.getHolidays(mmDate).isNotEmpty;

          if (isLanscape) {
            return Container(
              height: 100,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border.all(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                  width: 0.5,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: isToday
                          ? const EdgeInsets.symmetric(vertical: 4)
                          : null,
                      decoration: isToday
                          ? BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            )
                          : null,
                      child: Center(
                        child: Text(
                          details.date.day.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: isToday
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          mmMoonPhase,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            mmFortnightDay,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                width: 0.5,
              ),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isHoliday) ...[
                    Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      child: Center(
                        child: Text(
                          'H',
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.onError,
                              ),
                        ),
                      ),
                    ),
                  ],
                  const SizedBox(height: 4),
                  Expanded(
                    child: Container(
                      margin: isToday ? const EdgeInsets.all(8) : null,
                      decoration: isToday
                          ? BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            )
                          : null,
                      child: Center(
                        child: Text(
                          details.date.day.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: isToday
                                      ? Theme.of(context).colorScheme.onPrimary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          mmMoonPhase,
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        const SizedBox(height: 4),
                        Expanded(
                          child: Text(
                            mmFortnightDay,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
