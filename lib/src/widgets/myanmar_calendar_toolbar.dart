// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:myanmar_calendar_dart/myanmar_calendar_dart.dart';

import '../core/myanmar_calendar_theme.dart';
import 'internal/calendar_localization_utils.dart';

/// Reusable polished toolbar for month-based calendar UIs.
class MyanmarCalendarToolbar extends StatelessWidget {
  const MyanmarCalendarToolbar({
    super.key,
    required this.month,
    required this.language,
    this.theme,
    this.title,
    this.subtitle,
    this.onPrevious,
    this.onNext,
    this.trailing,
    this.showNavigation = true,
  });

  final DateTime month;
  final Language language;
  final MyanmarCalendarTheme? theme;
  final String? title;
  final String? subtitle;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final Widget? trailing;
  final bool showNavigation;

  @override
  Widget build(BuildContext context) {
    final effectiveTheme = theme ?? MyanmarCalendarTheme.defaultTheme();
    final titleText =
        title ??
        '${CalendarLocalizationUtils.westernMonth(month.month, language)} ${month.year}';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            effectiveTheme.headerBackgroundColor,
            effectiveTheme.headerBackgroundColor.withValues(alpha: 0.82),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: <Widget>[
          if (showNavigation)
            _NavButton(
              icon: Icons.chevron_left,
              color: effectiveTheme.headerTextColor,
              onPressed: onPrevious,
              tooltip: CalendarLocalizationUtils.tr(
                'previousMonth',
                language,
                fallback: 'Previous Month',
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  titleText,
                  textAlign: TextAlign.center,
                  style: effectiveTheme.headerTextStyle.copyWith(
                    color: effectiveTheme.headerTextColor,
                  ),
                ),
                if (subtitle != null && subtitle!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subtitle!,
                      textAlign: TextAlign.center,
                      style:
                          (effectiveTheme.headerSubtitleStyle ??
                                  const TextStyle(fontSize: 12))
                              .copyWith(
                                color: effectiveTheme.headerTextColor
                                    .withValues(alpha: 0.86),
                              ),
                    ),
                  ),
              ],
            ),
          ),
          if (trailing != null) ...<Widget>[
            const SizedBox(width: 8),
            trailing!,
          ] else if (showNavigation)
            _NavButton(
              icon: Icons.chevron_right,
              color: effectiveTheme.headerTextColor,
              onPressed: onNext,
              tooltip: CalendarLocalizationUtils.tr(
                'nextMonth',
                language,
                fallback: 'Next Month',
              ),
            ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.color,
    required this.onPressed,
    required this.tooltip,
  });

  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: tooltip,
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: color.withValues(alpha: 0.15),
        foregroundColor: color,
      ),
      icon: Icon(icon),
    );
  }
}
