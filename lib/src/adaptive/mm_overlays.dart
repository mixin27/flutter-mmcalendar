import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../foundation/mm_visual_style.dart';
import '../foundation/myanmar_calendar_scope.dart';
import 'mm_glass.dart';

/// Shows a bottom sheet in the calendar's style: Material's with a drag
/// handle, a Cupertino sheet with a grabber, or a floating glass sheet.
///
/// The sheet's content takes the scope of [context], so calendar widgets in
/// it keep the same client, language and theme.
Future<T?> showMmSheet<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  MmVisualStyle? style,
  bool isDismissible = true,
  bool useRootNavigator = false,
}) {
  final resolved = MyanmarCalendarScope.styleOf(context, style);
  final theme = MyanmarCalendarScope.themeOf(context);

  // Routes are built above the scope, so carry it over.
  Widget scoped(BuildContext ctx) =>
      MyanmarCalendarScope.wrap(context, Builder(builder: builder));

  const grabber = Padding(
    padding: EdgeInsets.only(top: 8, bottom: 4),
    child: _Grabber(),
  );

  switch (resolved) {
    case MmVisualStyle.material:
    case MmVisualStyle.automatic:
      return showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        showDragHandle: true,
        isDismissible: isDismissible,
        useRootNavigator: useRootNavigator,
        backgroundColor: theme.surface,
        builder: scoped,
      );
    case MmVisualStyle.cupertino:
      return showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        isDismissible: isDismissible,
        useRootNavigator: useRootNavigator,
        backgroundColor: theme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
        ),
        builder: (ctx) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            grabber,
            Flexible(child: scoped(ctx)),
          ],
        ),
      );
    case MmVisualStyle.glass:
      return showModalBottomSheet<T>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        isDismissible: isDismissible,
        useRootNavigator: useRootNavigator,
        backgroundColor: Colors.transparent,
        elevation: 0,
        barrierColor: Colors.black.withValues(alpha: 0.12),
        builder: (ctx) => Padding(
          // A floating sheet: inset from the edges and above the home
          // indicator.
          padding: EdgeInsets.fromLTRB(
            8,
            0,
            8,
            math.max(8, MediaQuery.viewPaddingOf(ctx).bottom),
          ),
          child: MmGlass(
            borderRadius: BorderRadius.circular(34),
            thickness: MmGlassThickness.frosted,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                grabber,
                Flexible(child: scoped(ctx)),
              ],
            ),
          ),
        ),
      );
  }
}

/// Shows a small panel next to [anchor] (by default the box of [context]),
/// below it when there is room and above it otherwise.
Future<T?> showMmPopover<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  Rect? anchor,
  double width = 280,
  MmVisualStyle? style,
}) {
  final resolved = MyanmarCalendarScope.styleOf(context, style);
  final theme = MyanmarCalendarScope.themeOf(context);
  final box = context.findRenderObject()! as RenderBox;
  final rect = anchor ?? box.localToGlobal(Offset.zero) & box.size;
  final label = MaterialLocalizations.of(context).modalBarrierDismissLabel;

  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: label,
    barrierColor: Colors.transparent,
    transitionDuration: const Duration(milliseconds: 180),
    pageBuilder: (ctx, _, _) {
      final content = MyanmarCalendarScope.wrap(
        context,
        Builder(builder: builder),
      );
      final Widget panel = switch (resolved) {
        MmVisualStyle.glass => MmGlass(
          borderRadius: BorderRadius.circular(24),
          thickness: MmGlassThickness.frosted,
          child: content,
        ),
        MmVisualStyle.cupertino => DecoratedBox(
          decoration: BoxDecoration(
            color: theme.surface,
            borderRadius: BorderRadius.circular(13),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: content,
          ),
        ),
        _ => Material(
          color: Color.alphaBlend(
            theme.accent.withValues(alpha: 0.08),
            theme.surface,
          ),
          elevation: 3,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: content,
        ),
      };
      return CustomSingleChildLayout(
        delegate: _PopoverLayout(
          anchor: rect,
          width: width,
          padding: MediaQuery.paddingOf(ctx),
        ),
        child: panel,
      );
    },
    transitionBuilder: (ctx, animation, _, child) {
      if (MediaQuery.disableAnimationsOf(ctx)) return child;
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween(begin: 0.94, end: 1.0).animate(curved),
          child: child,
        ),
      );
    },
  );
}

class _PopoverLayout extends SingleChildLayoutDelegate {
  _PopoverLayout({
    required this.anchor,
    required this.width,
    required this.padding,
  });

  final Rect anchor;
  final double width;
  final EdgeInsets padding;

  static const double _gap = 8;
  static const double _margin = 12;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final maxWidth = math.max(0.0, constraints.maxWidth - 2 * _margin);
    final below = constraints.maxHeight - anchor.bottom - padding.bottom - _gap;
    final above = anchor.top - padding.top - _gap;
    return BoxConstraints(
      maxWidth: math.min(width, maxWidth),
      maxHeight: math.max(math.max(below, above) - _margin, 0),
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final fitsBelow =
        anchor.bottom + _gap + childSize.height <=
        size.height - padding.bottom - _margin;
    final y = fitsBelow
        ? anchor.bottom + _gap
        : anchor.top - _gap - childSize.height;
    final x = (anchor.center.dx - childSize.width / 2)
        .clamp(
          _margin,
          math.max(_margin, size.width - _margin - childSize.width),
        )
        .toDouble();
    return Offset(x, math.max(y, padding.top + _margin));
  }

  @override
  bool shouldRelayout(_PopoverLayout old) =>
      old.anchor != anchor || old.width != width || old.padding != padding;
}

class _Grabber extends StatelessWidget {
  const _Grabber();

  @override
  Widget build(BuildContext context) {
    final theme = MyanmarCalendarScope.themeOf(context);
    return Container(
      width: 36,
      height: 5,
      decoration: BoxDecoration(
        color: theme.muted.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
