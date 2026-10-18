import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A tap target for the glass controls: keyboard focus and activation, button
/// semantics, a focus ring, and a slight press-down scale.
class MmPressable extends StatefulWidget {
  /// Creates a pressable area around [child].
  const MmPressable({
    required this.child,
    required this.onPressed,
    super.key,
    this.borderRadius = const BorderRadius.all(Radius.circular(999)),
    this.focusColor,
    this.semanticLabel,
    this.selected,
    this.minSize = 44,
  });

  /// The control's look.
  final Widget child;

  /// Called on tap, Enter or Space; `null` disables the control.
  final VoidCallback? onPressed;

  /// The focus ring's shape.
  final BorderRadius borderRadius;

  /// The focus ring's colour; defaults to the theme's primary colour.
  final Color? focusColor;

  /// Replaces the label read from [child].
  final String? semanticLabel;

  /// Whether the control is in a selected state, for screen readers.
  final bool? selected;

  /// The smallest tap target, in logical pixels.
  final double minSize;

  @override
  State<MmPressable> createState() => _MmPressableState();
}

class _MmPressableState extends State<MmPressable> {
  bool _pressed = false;
  bool _focused = false;

  bool get _enabled => widget.onPressed != null;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final ring = widget.focusColor ?? Theme.of(context).colorScheme.primary;
    return Semantics(
      button: true,
      enabled: _enabled,
      selected: widget.selected,
      label: widget.semanticLabel,
      // With its own label the child's semantics are dropped, so the tap
      // action has to be declared here.
      onTap: widget.semanticLabel != null ? widget.onPressed : null,
      excludeSemantics: widget.semanticLabel != null,
      child: FocusableActionDetector(
        enabled: _enabled,
        mouseCursor: _enabled ? SystemMouseCursors.click : MouseCursor.defer,
        onShowFocusHighlight: (v) => setState(() => _focused = v),
        actions: {
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (_) {
              widget.onPressed?.call();
              return null;
            },
          ),
        },
        shortcuts: const {
          SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
          SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTapDown: _enabled ? (_) => _setPressed(true) : null,
          onTapUp: _enabled ? (_) => _setPressed(false) : null,
          onTapCancel: _enabled ? () => _setPressed(false) : null,
          onTap: widget.onPressed,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: widget.minSize,
              minHeight: widget.minSize,
            ),
            child: Center(
              widthFactor: 1,
              heightFactor: 1,
              child: AnimatedScale(
                scale: _pressed && !reduceMotion ? 0.95 : 1,
                duration: const Duration(milliseconds: 120),
                curve: Curves.easeOut,
                child: AnimatedOpacity(
                  opacity: _enabled ? 1 : 0.45,
                  duration: const Duration(milliseconds: 120),
                  child: DecoratedBox(
                    position: DecorationPosition.foreground,
                    decoration: BoxDecoration(
                      borderRadius: widget.borderRadius,
                      border: _focused
                          ? Border.all(color: ring, width: 2)
                          : null,
                    ),
                    child: widget.child,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
