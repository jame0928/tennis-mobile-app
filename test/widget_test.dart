import 'package:flutter_test/flutter_test.dart';

import 'package:tennis_tournament_app/app/app.dart';

void main() {
  testWidgets('renders main navigation tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const TennisApp());
    await tester.pumpAndSettle();

    expect(find.text('Tournaments'), findsWidgets);
    expect(find.text('Registrations'), findsOneWidget);
    expect(find.text('Schedule'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });

  testWidgets('preserves tab state when returning', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TennisApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Profile'), findsWidgets);

    await tester.tap(find.text('Tournaments'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profile'));
    await tester.pumpAndSettle();

    expect(find.text('Profile'), findsWidgets);
  });
}
