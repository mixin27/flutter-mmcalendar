import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';

class MoonPhasePage extends StatelessWidget {
  const MoonPhasePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MoonPhase Widget'),
      ),
      body: Center(
        child: MoonPhaseWidget(
          date: DateTime.now(),
          size: 50,
        ),
      ),
    );
  }
}
