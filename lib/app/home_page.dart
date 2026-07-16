import 'package:flutter/material.dart';

import '../l10n/l10n.dart';
import '../features/profile/presentation/pages/profile_page.dart';
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

  static const pages = [
    TournamentsPage(),
    RegistrationsPage(),
    MySchedulePage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.emoji_events),
            label: context.l10n.navTournaments,
          ),
          NavigationDestination(
            icon: const Icon(Icons.assignment),
            label: context.l10n.navRegistrations,
          ),
          NavigationDestination(
            icon: const Icon(Icons.calendar_month),
            label: context.l10n.navSchedule,
          ),
          NavigationDestination(
            icon: const Icon(Icons.person),
            label: context.l10n.navProfile,
          ),
        ],
      ),
    );
  }
}
