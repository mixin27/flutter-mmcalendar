import 'package:flutter/material.dart';
import 'package:flutter_mmcalendar/flutter_mmcalendar.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'MyanmarDatePickerWidget should work without explicit dimensions',
    (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: MyanmarDatePickerWidget(
                initialDate: DateTime(2023, 10, 1),
                onDateChanged: (date) {},
              ),
            ),
          ),
        ),
      );

      // Verify that the widget is rendered
      expect(find.byType(MyanmarDatePickerWidget), findsOneWidget);

      // Verify that it doesn't overflow (basic check)
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'MyanmarDatePickerWidget should work in a constrained height container',
    (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SizedBox(
                height: 400,
                width: 300,
                child: MyanmarDatePickerWidget(
                  initialDate: DateTime(2023, 10, 1),
                  onDateChanged: (date) {},
                ),
              ),
            ),
          ),
        ),
      );

      // Verify that the widget is rendered
      expect(find.byType(MyanmarDatePickerWidget), findsOneWidget);

      // Verify that it doesn't overflow
      expect(tester.takeException(), isNull);
    },
  );
}
