import 'package:flutter/material.dart';

import '../features/schedule/presentation/pages/tournament_schedule_page.dart';
import '../features/tournaments/presentation/pages/tournament_detail_page.dart';
import 'home_page.dart';

class AppRouter {
  static const home = '/';
  static const tournamentDetail = '/tournament-detail';
  static const tournamentSchedule = '/tournament-schedule';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case tournamentDetail:
        final tournamentId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => TournamentDetailPage(tournamentId: tournamentId),
        );
      case tournamentSchedule:
        final tournamentId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => TournamentSchedulePage(tournamentId: tournamentId),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}
