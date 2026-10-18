import 'dart:async';

import 'package:flutter/material.dart';

/// Builds with today's date and rebuilds at local midnight, and when the app
/// comes back to the foreground, so "today" stays right in long-running apps.
class TodayBuilder extends StatefulWidget {
  /// Creates a builder that passes today (date-only) to [builder].
  const TodayBuilder({required this.builder, super.key, this.clock});

  /// Builds with today's date.
  final Widget Function(BuildContext context, DateTime today) builder;

  /// The current time; defaults to `DateTime.now`. Tests pass a fake clock.
  final DateTime Function()? clock;

  @override
  State<TodayBuilder> createState() => _TodayBuilderState();
}

class _TodayBuilderState extends State<TodayBuilder>
    with WidgetsBindingObserver {
  late DateTime _today;
  Timer? _timer;

  DateTime _now() => (widget.clock ?? DateTime.now)();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refresh(notify: false);
  }

  @override
  void didUpdateWidget(TodayBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.clock != oldWidget.clock) _refresh(notify: false);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refresh();
  }

  void _refresh({bool notify = true}) {
    final now = _now();
    final today = DateUtils.dateOnly(now);
    if (notify && mounted) {
      setState(() => _today = today);
    } else {
      _today = today;
    }
    _timer?.cancel();
    // A second past midnight, so a clock running slightly early still lands
    // on the new day.
    final next = DateTime(now.year, now.month, now.day + 1, 0, 0, 1);
    _timer = Timer(next.difference(now), _refresh);
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, _today);
}
