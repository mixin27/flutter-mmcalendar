// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../core/myanmar_calendar_theme.dart';
import 'internal/calendar_localization_utils.dart';

/// Compact summary card for a selected Myanmar date.
class MyanmarDateSummaryCard extends StatelessWidget {
  const MyanmarDateSummaryCard({
    super.key,
    required this.date,
    this.language = Language.english,
    this.theme,
    this.showHolidays = true,
    this.showAstrology = true,
  });

  final CompleteDate date;
  final Language language;
  final MyanmarCalendarTheme? theme;
  final bool showHolidays;
  final bool showAstrology;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? MyanmarCalendarTheme.defaultTheme();
    final myanmarText = MyanmarCalendar.formatMyanmar(
      date.myanmar,
      pattern: '&y &M &P &ff',
      language: language,
    );
    final westernText = MyanmarCalendar.formatWestern(
      date.western,
      pattern: '%MMM %dd, %yyyy',
      language: language,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: effectiveTheme.backgroundColor,
        border: Border.all(
          color: effectiveTheme.headerBackgroundColor.withValues(alpha: 0.22),
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.event,
                size: 16,
                color: effectiveTheme.headerBackgroundColor,
              ),
              const SizedBox(width: 6),
              Text(
                CalendarLocalizationUtils.selectDate(language),
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: effectiveTheme.headerBackgroundColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            myanmarText,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: effectiveTheme.dateCellTextColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            westernText,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: effectiveTheme.weekdayHeaderTextColor,
            ),
          ),
          if (showHolidays && date.hasHolidays) ...<Widget>[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: date.allHolidays
                  .take(3)
                  .map(
                    (holiday) => _InfoChip(label: holiday, color: Colors.red),
                  )
                  .toList(),
            ),
          ],
          if (showAstrology &&
              date.astro.astrologicalDays.isNotEmpty) ...<Widget>[
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: date.astro.astrologicalDays
                  .take(3)
                  .map(
                    (astro) => _InfoChip(
                      label: TranslationService.translateTo(astro, language),
                      color: Colors.indigo,
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.label, required this.color});

  final String label;
  final MaterialColor color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.shade50,
        border: Border.all(color: color.shade100),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: color.shade700,
        ),
      ),
    );
  }
}
