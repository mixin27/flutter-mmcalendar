import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_mmcalendar_example/main.dart';

void main() {
  testWidgets('showcase app renders main sections', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('Myanmar Calendar Showcase'), findsOneWidget);
    expect(find.text('Calendar'), findsOneWidget);
    expect(find.text('Picker'), findsOneWidget);
    expect(find.text('Insights'), findsOneWidget);
  });
}
