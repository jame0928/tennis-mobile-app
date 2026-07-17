import 'package:flutter_test/flutter_test.dart';

import 'package:tennis_tournament_app/app/app.dart';

void main() {
  testWidgets('renders public navigation tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const TennisApp());
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('Torneos'), findsWidgets);
    expect(find.text('Rankings'), findsOneWidget);
    expect(find.text('Academias'), findsOneWidget);
    expect(find.text('Inscripciones'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.text('Calendario'), findsNothing);
  });

  testWidgets('preserves tab state when returning', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TennisApp());
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tap(find.text('Rankings'));
    await tester.pump();

    expect(find.text('Rankings'), findsWidgets);

    await tester.tap(find.text('Torneos'));
    await tester.pump();

    await tester.tap(find.text('Rankings'));
    await tester.pump();

    expect(find.text('Rankings'), findsWidgets);
  });
}
