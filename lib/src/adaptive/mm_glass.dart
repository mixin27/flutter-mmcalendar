import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../foundation/myanmar_calendar_scope.dart';

/// How much a glass panel blurs what is behind it.
enum MmGlassThickness {
  /// No blur: only the rim refracts. For controls over busy content.
  clear(0, 10),

  /// A light blur, like iOS 26's regular glass.
  regular(3, 18),

  /// A heavy frost, for sheets that hold a lot of text.
  frosted(10, 28);

  const MmGlassThickness(this.shaderBlur, this.fallbackBlur);

  /// Blur sigma under the refraction shader.
  final double shaderBlur;

  /// Blur sigma when the shader isn't available, which has to hide more
  /// because there is no refraction to read as glass.
  final double fallbackBlur;
}

/// A Liquid Glass panel: what is behind it bends at the rim, a tint and a
/// bright edge sit on top, and [child] is drawn inside.
///
/// On Impeller the backdrop goes through a refraction shader. On Skia, on
/// web, while the route is animating, and when the user turns on high
/// contrast, it falls back to a blur with a tint and highlight, or to an
/// opaque surface for high contrast.
class MmGlass extends StatefulWidget {
  /// Creates a glass panel.
  const MmGlass({
    super.key,
    this.child,
    this.borderRadius = const BorderRadius.all(Radius.circular(28)),
    this.padding,
    this.tint,
    this.thickness = MmGlassThickness.regular,
    this.refraction = 1,
    this.shadow = true,
  });

  /// The content, drawn above the glass.
  final Widget? child;

  /// The panel's shape. Use a radius of half the height for a capsule.
  final BorderRadius borderRadius;

  /// Space between the rim and [child].
  final EdgeInsetsGeometry? padding;

  /// The glass colour; `null` uses the calendar surface. Pass a translucent
  /// accent for a filled control.
  final Color? tint;

  /// How much the panel blurs its backdrop.
  final MmGlassThickness thickness;

  /// Scales the rim's refraction; 0 turns it off.
  final double refraction;

  /// Whether to cast a soft shadow.
  final bool shadow;

  static ui.FragmentProgram? _program;
  static Future<ui.FragmentProgram?>? _loading;
  static final ValueNotifier<bool> _ready = ValueNotifier(false);

  /// Loads the refraction shader ahead of time, so the first glass panel
  /// doesn't draw with the fallback for a frame. Safe to call more than once.
  static Future<void> precache() => _load();

  static Future<ui.FragmentProgram?> _load() {
    return _loading ??= () async {
      if (!ui.ImageFilter.isShaderFilterSupported) return null;
      try {
        _program = await ui.FragmentProgram.fromAsset(
          'packages/flutter_mmcalendar/shaders/liquid_glass.frag',
        );
        _ready.value = true;
      } on Object catch (error) {
        debugPrint('MmGlass: refraction shader unavailable ($error)');
      }
      return _program;
    }();
  }

  /// Whether glass draws with the refraction shader on this device.
  static bool get usesShader => _program != null;

  @override
  State<MmGlass> createState() => _MmGlassState();
}

class _MmGlassState extends State<MmGlass> {
  Animation<double>? _routeAnimation;
  Animation<double>? _secondaryAnimation;
  bool _routeMoving = false;

  @override
  void initState() {
    super.initState();
    MmGlass._ready.addListener(_rebuild);
    MmGlass._load();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    _watch(route?.animation, route?.secondaryAnimation);
  }

  // While a route slides, layers move without repainting, so the shader's
  // panel rect would lag behind. Use the fallback until it settles.
  void _watch(Animation<double>? a, Animation<double>? b) {
    if (a == _routeAnimation && b == _secondaryAnimation) return;
    _routeAnimation?.removeStatusListener(_onRouteStatus);
    _secondaryAnimation?.removeStatusListener(_onRouteStatus);
    _routeAnimation = a?..addStatusListener(_onRouteStatus);
    _secondaryAnimation = b?..addStatusListener(_onRouteStatus);
    _routeMoving = _isMoving;
  }

  bool get _isMoving =>
      (_routeAnimation?.isAnimating ?? false) ||
      (_secondaryAnimation?.isAnimating ?? false);

  void _onRouteStatus(AnimationStatus _) {
    if (_isMoving != _routeMoving) setState(() => _routeMoving = _isMoving);
  }

  void _rebuild() => setState(() {});

  @override
  void dispose() {
    MmGlass._ready.removeListener(_rebuild);
    _routeAnimation?.removeStatusListener(_onRouteStatus);
    _secondaryAnimation?.removeStatusListener(_onRouteStatus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyanmarCalendarScope.themeOf(context);
    final dark = theme.brightness == Brightness.dark;
    final radius = widget.borderRadius;
    Widget content = widget.child ?? const SizedBox.shrink();
    if (widget.padding != null) {
      content = Padding(padding: widget.padding!, child: content);
    }

    final shadow = widget.shadow
        ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: dark ? 0.35 : 0.16),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ]
        : null;

    if (MediaQuery.highContrastOf(context)) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: theme.surface,
          borderRadius: radius,
          border: Border.all(color: theme.outline),
          boxShadow: shadow,
        ),
        child: content,
      );
    }

    final tint =
        widget.tint ?? theme.surface.withValues(alpha: dark ? 0.22 : 0.30);
    // The tint sits above the filter, so the filter only sees the backdrop.
    content = CustomPaint(
      painter: _GlassTintPainter(radius: radius, tint: tint, dark: dark),
      child: content,
    );
    final program = MmGlass._program;
    final useShader = program != null && !_routeMoving && widget.refraction > 0;

    final Widget backdrop = useShader
        ? _GlassShaderFilter(
            program: program,
            borderRadius: radius.resolve(Directionality.of(context)),
            blurSigma: widget.thickness.shaderBlur,
            refraction: widget.refraction,
            devicePixelRatio: MediaQuery.devicePixelRatioOf(context),
            scrollPosition: Scrollable.maybeOf(context)?.position,
            child: content,
          )
        : BackdropFilter(
            filter: ui.ImageFilter.compose(
              outer: _saturate(1.6),
              inner: ui.ImageFilter.blur(
                sigmaX: widget.thickness.fallbackBlur,
                sigmaY: widget.thickness.fallbackBlur,
              ),
            ),
            child: content,
          );

    return DecoratedBox(
      decoration: BoxDecoration(borderRadius: radius, boxShadow: shadow),
      child: ClipRRect(
        borderRadius: radius,
        child: CustomPaint(
          foregroundPainter: _GlassRimPainter(radius: radius, dark: dark),
          child: backdrop,
        ),
      ),
    );
  }

  static ColorFilter _saturate(double s) {
    const r = 0.2126, g = 0.7152, b = 0.0722;
    final i = 1 - s;
    return ColorFilter.matrix([
      r * i + s, g * i, b * i, 0, 0, //
      r * i, g * i + s, b * i, 0, 0, //
      r * i, g * i, b * i + s, 0, 0, //
      0, 0, 0, 1, 0,
    ]);
  }
}

/// The glass colour, with a faint light falling from the top.
class _GlassTintPainter extends CustomPainter {
  _GlassTintPainter({
    required this.radius,
    required this.tint,
    required this.dark,
  });

  final BorderRadius radius;
  final Color tint;
  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final rrect = radius.toRRect(Offset.zero & size);
    canvas.drawRRect(rrect, Paint()..color = tint);
    canvas.drawRRect(
      rrect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: dark ? 0.06 : 0.14),
            Colors.white.withValues(alpha: 0),
          ],
        ).createShader(Offset.zero & size),
    );
  }

  @override
  bool shouldRepaint(_GlassTintPainter old) =>
      old.radius != radius || old.tint != tint || old.dark != dark;
}

/// The bright edge: strongest at the top left, where the light comes from,
/// with a fainter glint at the bottom right.
class _GlassRimPainter extends CustomPainter {
  _GlassRimPainter({required this.radius, required this.dark});

  final BorderRadius radius;
  final bool dark;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = radius.toRRect(rect).deflate(0.5);
    final a = dark ? 0.7 : 1.0;
    canvas.drawRRect(
      rrect,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1
        ..shader = LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.75 * a),
            Colors.white.withValues(alpha: 0.12 * a),
            Colors.white.withValues(alpha: 0.10 * a),
            Colors.white.withValues(alpha: 0.45 * a),
          ],
          stops: const [0, 0.35, 0.7, 1],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(_GlassRimPainter old) =>
      old.radius != radius || old.dark != dark;
}

/// A backdrop filter whose refraction shader knows where the panel is on
/// screen. It repaints when its scrollable scrolls, so the rect stays right.
class _GlassShaderFilter extends SingleChildRenderObjectWidget {
  const _GlassShaderFilter({
    required this.program,
    required this.borderRadius,
    required this.blurSigma,
    required this.refraction,
    required this.devicePixelRatio,
    required this.scrollPosition,
    super.child,
  });

  final ui.FragmentProgram program;
  final BorderRadius borderRadius;
  final double blurSigma;
  final double refraction;
  final double devicePixelRatio;
  final ScrollPosition? scrollPosition;

  @override
  _RenderGlassShaderFilter createRenderObject(BuildContext context) =>
      _RenderGlassShaderFilter(
        shader: program.fragmentShader(),
        borderRadius: borderRadius,
        blurSigma: blurSigma,
        refraction: refraction,
        devicePixelRatio: devicePixelRatio,
        scrollPosition: scrollPosition,
      );

  @override
  void updateRenderObject(
    BuildContext context,
    _RenderGlassShaderFilter renderObject,
  ) {
    renderObject
      ..borderRadius = borderRadius
      ..blurSigma = blurSigma
      ..refraction = refraction
      ..devicePixelRatio = devicePixelRatio
      ..scrollPosition = scrollPosition;
  }
}

class _RenderGlassShaderFilter extends RenderProxyBox {
  _RenderGlassShaderFilter({
    required ui.FragmentShader shader,
    required BorderRadius borderRadius,
    required double blurSigma,
    required double refraction,
    required double devicePixelRatio,
    required ScrollPosition? scrollPosition,
  }) : _shader = shader,
       _borderRadius = borderRadius,
       _blurSigma = blurSigma,
       _refraction = refraction,
       _devicePixelRatio = devicePixelRatio,
       _scrollPosition = scrollPosition;

  final ui.FragmentShader _shader;

  BorderRadius _borderRadius;
  set borderRadius(BorderRadius v) {
    if (v == _borderRadius) return;
    _borderRadius = v;
    markNeedsPaint();
  }

  double _blurSigma;
  set blurSigma(double v) {
    if (v == _blurSigma) return;
    _blurSigma = v;
    markNeedsPaint();
  }

  double _refraction;
  set refraction(double v) {
    if (v == _refraction) return;
    _refraction = v;
    markNeedsPaint();
  }

  double _devicePixelRatio;
  set devicePixelRatio(double v) {
    if (v == _devicePixelRatio) return;
    _devicePixelRatio = v;
    markNeedsPaint();
  }

  ScrollPosition? _scrollPosition;
  set scrollPosition(ScrollPosition? v) {
    if (v == _scrollPosition) return;
    if (attached) _scrollPosition?.removeListener(markNeedsPaint);
    _scrollPosition = v;
    if (attached) _scrollPosition?.addListener(markNeedsPaint);
  }

  @override
  void attach(PipelineOwner owner) {
    super.attach(owner);
    _scrollPosition?.addListener(markNeedsPaint);
  }

  @override
  void detach() {
    _scrollPosition?.removeListener(markNeedsPaint);
    super.detach();
  }

  @override
  void dispose() {
    _shader.dispose();
    super.dispose();
  }

  @override
  bool get alwaysNeedsCompositing => child != null;

  @override
  BackdropFilterLayer? get layer => super.layer as BackdropFilterLayer?;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child == null) return;
    final dpr = _devicePixelRatio;
    final origin = localToGlobal(Offset.zero) * dpr;
    final px = size * dpr;
    // Index 0 and 1 (uSize) are set by the engine.
    final radius = _borderRadius.topLeft.x * dpr;
    _shader
      ..setFloat(2, origin.dx)
      ..setFloat(3, origin.dy)
      ..setFloat(4, px.width)
      ..setFloat(5, px.height)
      ..setFloat(6, radius)
      ..setFloat(7, 18 * dpr) // bezel
      ..setFloat(8, 9 * dpr * _refraction) // strength
      ..setFloat(9, 0.08) // dispersion
      ..setFloat(10, 1.25); // saturation
    final shaderFilter = ui.ImageFilter.shader(_shader);
    final filter = _blurSigma > 0
        ? ui.ImageFilter.compose(
            outer: shaderFilter,
            inner: ui.ImageFilter.blur(sigmaX: _blurSigma, sigmaY: _blurSigma),
          )
        : shaderFilter;
    layer ??= BackdropFilterLayer();
    layer!.filter = filter;
    context.pushLayer(layer!, super.paint, offset);
  }
}
