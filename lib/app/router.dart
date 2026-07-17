import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/auth/auth_controller.dart';
import '../l10n/l10n.dart';
import '../features/academies/presentation/pages/academy_detail_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/rankings/presentation/pages/ranking_detail_page.dart';
import '../features/schedule/presentation/pages/tournament_schedule_page.dart';
import '../features/tournaments/presentation/pages/tournament_detail_page.dart';
import 'home_page.dart';

class AppRouter {
  static const home = '/';
  static const login = '/login';
  static const tournamentDetail = '/tournament-detail';
  static const tournamentSchedule = '/tournament-schedule';
  static const rankingDetail = '/ranking-detail';
  static const academyDetail = '/academy-detail';

  static const _privateRoutes = <String>{
    tournamentSchedule,
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case tournamentDetail:
        final tournamentId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => TournamentDetailPage(tournamentId: tournamentId),
        );
      case tournamentSchedule:
        final tournamentId = settings.arguments as String;
        return _privateRoute(
          settings: settings,
          builder: (_) => TournamentSchedulePage(tournamentId: tournamentId),
        );
      case rankingDetail:
        final rankingId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => RankingDetailPage(rankingId: rankingId),
        );
      case academyDetail:
        final academyId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AcademyDetailPage(academyId: academyId),
        );
      default:
        return MaterialPageRoute(
          builder: (context) =>
              Scaffold(body: Center(child: Text(context.l10n.routeNotFound))),
        );
    }
  }

  static Route<dynamic> _privateRoute({
    required RouteSettings settings,
    required WidgetBuilder builder,
  }) {
    return MaterialPageRoute(
      settings: settings,
      builder: (context) {
        final auth = context.read<AuthController>();
        if (_privateRoutes.contains(settings.name) && !auth.isAuthenticated) {
          auth.setPendingRoute(
            route: settings.name!,
            arguments: settings.arguments,
          );
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed(login);
          });
          return Scaffold(
            body: Center(
              child: Text(context.l10n.authGuardRedirectingMessage),
            ),
          );
        }
        return builder(context);
      },
    );
  }
}
