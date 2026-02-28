import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MoonPhaseMath', () {
    test('returns key landmarks for daily moon phase', () {
      final full = MoonPhaseMath.phaseFromDailyMyanmarData(
        moonPhase: 1,
        fortnightDay: 15,
        monthLength: 30,
      );
      final newMoon = MoonPhaseMath.phaseFromDailyMyanmarData(
        moonPhase: 3,
        fortnightDay: 15,
        monthLength: 30,
      );

      expect(full, closeTo(0.5, 0.0001));
      expect(newMoon, closeTo(1.0, 0.0001));
    });

    test('illumination peaks around full moon', () {
      final waxing = MoonPhaseMath.phaseFromDailyMyanmarData(
        moonPhase: 0,
        fortnightDay: 10,
        monthLength: 30,
      );
      final full = MoonPhaseMath.phaseFromDailyMyanmarData(
        moonPhase: 1,
        fortnightDay: 15,
        monthLength: 30,
      );
      final waning = MoonPhaseMath.phaseFromDailyMyanmarData(
        moonPhase: 2,
        fortnightDay: 5,
        monthLength: 30,
      );

      final waxingIllumination = MoonPhaseMath.illumination(waxing);
      final fullIllumination = MoonPhaseMath.illumination(full);
      final waningIllumination = MoonPhaseMath.illumination(waning);

      expect(fullIllumination, greaterThan(waxingIllumination));
      expect(fullIllumination, greaterThan(waningIllumination));
    });
  });

  testWidgets('DailyMoonPhaseWidget renders with label', (
    WidgetTester tester,
  ) async {
    final completeDate = MyanmarCalendar.getCompleteDate(DateTime(2024, 5, 23));

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: DailyMoonPhaseWidget.fromCompleteDate(
              completeDate,
              showLabel: true,
              showIllumination: true,
            ),
          ),
        ),
      ),
    );

    expect(find.byType(DailyMoonPhaseWidget), findsOneWidget);
    expect(find.byType(CustomPaint), findsWidgets);
  });
}
