import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tennis_tournament_app/l10n/app_localizations.dart';

import 'di/app_scope.dart';
import '../l10n/l10n.dart';
import 'router.dart';
import 'theme.dart';

class TennisApp extends StatelessWidget {
  const TennisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScope(
      child: MaterialApp(
        onGenerateTitle: (context) => context.l10n.appTitle,
        locale: const Locale('es'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        theme: buildAppTheme(),
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
