import 'package:flutter/material.dart';

import 'di/app_scope.dart';
import 'router.dart';
import 'theme.dart';

class TennisApp extends StatelessWidget {
  const TennisApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScope(
      child: MaterialApp(
        title: 'Next Tennis',
        theme: buildAppTheme(),
        initialRoute: AppRouter.home,
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
