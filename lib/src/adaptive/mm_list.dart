import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import 'mm_glass.dart';

/// A titled group of [MmListRow]s: a tonal card in Material, an inset
/// grouped section in Cupertino, a glass panel in Glass.
class MmListGroup extends StatelessWidget {
  /// Creates a group.
  const MmListGroup({
    required this.children,
    super.key,
    this.header,
    this.footer,
    this.style,
  });

  /// The rows.
  final List<Widget> children;

  /// The group's title.
  final String? header;

  /// A note under the group.
  final String? footer;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  @override
  Widget build(BuildContext context) {
    final style = MyanmarCalendarScope.styleOf(context, this.style);
    final theme = MyanmarCalendarScope.themeOf(context);
    final radius = BorderRadius.circular(
      theme.cardRadius ??
          (style == MmVisualStyle.glass ? 24 : style.cardRadius),
    );
    final divider = Divider(
      height: 1,
      thickness: style == MmVisualStyle.cupertino ? 0.5 : 1,
      indent: 16,
      color: style == MmVisualStyle.glass
          ? Colors.white.withValues(alpha: 0.22)
          : theme.outline,
    );
    final rows = <Widget>[
      for (var i = 0; i < children.length; i++) ...[
        if (i > 0 && style != MmVisualStyle.material) divider,
        children[i],
      ],
    ];
    final body = Column(mainAxisSize: MainAxisSize.min, children: rows);

    final Widget panel = switch (style) {
      MmVisualStyle.glass => MmGlass(borderRadius: radius, child: body),
      MmVisualStyle.cupertino => ClipRRect(
        borderRadius: radius,
        child: ColoredBox(color: theme.surface, child: body),
      ),
      _ => Material(
        color: Color.alphaBlend(
          theme.accent.withValues(alpha: 0.05),
          theme.surface,
        ),
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: body,
        ),
      ),
    };

    final cupertino = style == MmVisualStyle.cupertino;
    final label = TextStyle(
      color: style == MmVisualStyle.material ? theme.accent : theme.muted,
      fontSize: cupertino ? 13 : 14,
      fontWeight: cupertino ? FontWeight.w400 : FontWeight.w600,
      letterSpacing: cupertino ? 0.2 : 0.1,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (header != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
            child: Semantics(
              header: true,
              child: Text(
                cupertino ? header!.toUpperCase() : header!,
                style: label,
              ),
            ),
          ),
        panel,
        if (footer != null)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 6, 16, 4),
            child: Text(
              footer!,
              style: TextStyle(color: theme.muted, fontSize: 13),
            ),
          ),
      ],
    );
  }
}

/// One row in an [MmListGroup]: a title, an optional subtitle, and leading
/// and trailing widgets.
class MmListRow extends StatelessWidget {
  /// Creates a row.
  const MmListRow({
    required this.title,
    super.key,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.style,
  });

  /// The main text.
  final Widget title;

  /// Smaller text under [title].
  final Widget? subtitle;

  /// A widget before the text, such as an icon or a moon glyph.
  final Widget? leading;

  /// A widget after the text, such as a chip or a copy button.
  final Widget? trailing;

  /// Makes the row tappable.
  final VoidCallback? onTap;

  /// Overrides the scope's visual style.
  final MmVisualStyle? style;

  @override
  Widget build(BuildContext context) {
    final style = MyanmarCalendarScope.styleOf(context, this.style);
    final theme = MyanmarCalendarScope.themeOf(context);
    if (style == MmVisualStyle.cupertino) {
      return CupertinoListTile(
        title: DefaultTextStyle.merge(
          style: TextStyle(color: theme.ink),
          child: title,
        ),
        subtitle: subtitle == null
            ? null
            : DefaultTextStyle.merge(
                style: TextStyle(color: theme.muted),
                child: subtitle!,
              ),
        leading: leading,
        trailing:
            trailing ??
            (onTap == null ? null : const CupertinoListTileChevron()),
        onTap: onTap,
        backgroundColor: theme.surface,
      );
    }

    final content = ConstrainedBox(
      constraints: const BoxConstraints(minHeight: 48),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            if (leading != null) ...[leading!, const SizedBox(width: 14)],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultTextStyle.merge(
                    style: TextStyle(
                      color: theme.ink,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                    child: title,
                  ),
                  if (subtitle != null)
                    DefaultTextStyle.merge(
                      style: TextStyle(color: theme.muted, fontSize: 13),
                      child: subtitle!,
                    ),
                ],
              ),
            ),
            if (trailing != null) ...[const SizedBox(width: 12), trailing!],
          ],
        ),
      ),
    );
    if (onTap == null) return content;
    return Material(
      type: MaterialType.transparency,
      child: InkWell(onTap: onTap, child: content),
    );
  }
}
