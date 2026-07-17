import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tennis_tournament_app/app/app.dart';
import 'package:tennis_tournament_app/app/router.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('navigates public shell and guards private schedule route', (
    tester,
  ) async {
    await tester.pumpWidget(const TennisApp());
    await tester.pumpAndSettle();

    expect(find.text('Torneos'), findsOneWidget);
    expect(find.text('Rankings'), findsOneWidget);
    expect(find.text('Academias'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);

    await tester.tap(find.text('Rankings'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Academias'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Iniciar sesion'), findsOneWidget);

    final navigator = tester.state<NavigatorState>(find.byType(Navigator));
    navigator.pushNamed(AppRouter.tournamentSchedule, arguments: 'test-id');
    await tester.pumpAndSettle();

    expect(find.text('Se requiere iniciar sesion. Redirigiendo...'), findsOneWidget);
  });
}
