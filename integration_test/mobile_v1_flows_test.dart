import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:tennis_tournament_app/app/app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('navigates critical v1 flows shell', (tester) async {
    await tester.pumpWidget(const TennisApp());
    await tester.pumpAndSettle();

    expect(find.text('Torneos'), findsOneWidget);

    await tester.tap(find.text('Inscripciones'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Calendario'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Perfil'));
    await tester.pumpAndSettle();

    expect(find.text('Guardar perfil'), findsOneWidget);
  });
}
