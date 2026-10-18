import 'package:flutter/material.dart';

import '../adaptive/mm_buttons.dart';
import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';

/// A calendar's title row: a title, a subtitle under it (the Myanmar months
/// it spans), previous and next buttons, and an optional [trailing] widget.
class MyanmarCalendarHeader extends StatelessWidget {
  /// Creates a header.
  const MyanmarCalendarHeader({
    required this.title,
    super.key,
    this.subtitle,
    this.onPrevious,
    this.onNext,
    this.showNavigation = true,
    this.previousTooltip = 'Previous',
    this.nextTooltip = 'Next',
    this.trailing,
    this.style,
  });

  /// The main title, e.g. "October 2026".
  final String title;

  /// The line under it, e.g. "Tawthalin – Thadingyut 1388".
  final String? subtitle;

  /// Goes back; `null` disables the button (e.g. at the first month).
  final VoidCallback? onPrevious;

  /// Goes forward; `null` disables the button.
  final VoidCallback? onNext;

  /// Whether to show the previous and next buttons.
  final bool showNavigation;

  /// The previous button's tooltip and accessible label.
  final String previousTooltip;

  /// The next button's tooltip and accessible label.
  final String nextTooltip;

  /// A widget after the buttons, such as a "Today" button.
  final Widget? trailing;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  @override
  Widget build(BuildContext context) {
    final style = MyanmarCalendarScope.styleOf(context, this.style);
    final theme = MyanmarCalendarScope.themeOf(context);
    final language = MyanmarCalendarScope.of(context).language;
    final bold = style != MmVisualStyle.material;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 0, 4),
      child: Row(
        children: [
          Expanded(
            child: Semantics(
              header: true,
              liveRegion: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textStyle(
                      TextStyle(
                        color: theme.ink,
                        fontSize: bold ? 21 : 19,
                        fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
                        letterSpacing: -0.2,
                      ),
                      language,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textStyle(
                        TextStyle(color: theme.muted, fontSize: 13),
                        language,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (showNavigation)
            MmIconButton(
              icon: Icons.chevron_left,
              tooltip: previousTooltip,
              onPressed: onPrevious,
              style: this.style,
            ),
          if (showNavigation) ...[
            const SizedBox(width: 4),
            MmIconButton(
              icon: Icons.chevron_right,
              tooltip: nextTooltip,
              onPressed: onNext,
              style: this.style,
            ),
          ],
          if (trailing != null) ...[const SizedBox(width: 6), trailing!],
        ],
      ),
    );
  }
}
