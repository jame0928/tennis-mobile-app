import 'package:flutter_test/flutter_test.dart';

import 'package:tennis_tournament_app/app/app.dart';

void main() {
  testWidgets('renders main navigation tabs', (WidgetTester tester) async {
    await tester.pumpWidget(const TennisApp());
    await tester.pumpAndSettle();

    expect(find.text('Torneos'), findsWidgets);
    expect(find.text('Inscripciones'), findsOneWidget);
    expect(find.text('Calendario'), findsOneWidget);
    expect(find.text('Perfil'), findsOneWidget);
  });

  testWidgets('preserves tab state when returning', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const TennisApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();

    expect(find.text('Perfil'), findsWidgets);

    await tester.tap(find.text('Torneos'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();

    expect(find.text('Perfil'), findsWidgets);
  });
}
