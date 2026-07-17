import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/auth/auth_controller.dart';
import '../l10n/l10n.dart';
import '../features/academies/presentation/pages/academies_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/profile/presentation/pages/profile_page.dart';
import '../features/rankings/presentation/pages/rankings_page.dart';
import '../features/registrations/presentation/pages/registrations_page.dart';
import '../features/schedule/presentation/pages/my_schedule_page.dart';
import '../features/tournaments/presentation/pages/tournaments_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  List<({Widget page, NavigationDestination destination})> _buildTabs(
    BuildContext context,
    bool authenticated,
  ) {
    final l10n = context.l10n;
    final tabs = <({Widget page, NavigationDestination destination})>[
      (
        page: const TournamentsPage(),
        destination: NavigationDestination(
          icon: const Icon(Icons.emoji_events),
          label: l10n.navTournaments,
        ),
      ),
      (
        page: const RankingsPage(),
        destination: NavigationDestination(
          icon: const Icon(Icons.leaderboard),
          label: l10n.navRankings,
        ),
      ),
      (
        page: const AcademiesPage(),
        destination: NavigationDestination(
          icon: const Icon(Icons.school),
          label: l10n.navAcademies,
        ),
      ),
      (
        page: const RegistrationsPage(),
        destination: NavigationDestination(
          icon: const Icon(Icons.assignment),
          label: l10n.navRegistrations,
        ),
      ),
    ];

    if (authenticated) {
      tabs.add(
        (
          page: const MySchedulePage(),
          destination: NavigationDestination(
            icon: const Icon(Icons.calendar_month),
            label: l10n.navSchedule,
          ),
        ),
      );
      tabs.add(
        (
          page: const ProfilePage(),
          destination: NavigationDestination(
            icon: const Icon(Icons.person),
            label: l10n.navProfile,
          ),
        ),
      );
    } else {
      tabs.add(
        (
          page: const LoginPage(),
          destination: NavigationDestination(
            icon: const Icon(Icons.login),
            label: l10n.navLogin,
          ),
        ),
      );
    }

    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, auth, _) {
        final tabs = _buildTabs(context, auth.isAuthenticated);
        if (index >= tabs.length) {
          index = 0;
        }
        return Scaffold(
          body: IndexedStack(index: index, children: tabs.map((t) => t.page).toList()),
          bottomNavigationBar: NavigationBar(
            selectedIndex: index,
            onDestinationSelected: (value) => setState(() => index = value),
            destinations: tabs.map((t) => t.destination).toList(),
          ),
        );
      },
    );
  }
}
