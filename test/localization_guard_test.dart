import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('core UI files avoid legacy hardcoded English copy', () {
    const guardedFiles = [
      'lib/app/home_page.dart',
      'lib/app/router.dart',
      'lib/features/profile/presentation/pages/profile_page.dart',
      'lib/features/registrations/presentation/pages/registrations_page.dart',
      'lib/features/schedule/presentation/pages/my_schedule_page.dart',
      'lib/features/tournaments/presentation/pages/tournaments_page.dart',
    ];

    const forbiddenLiterals = [
      'Tournaments',
      'Registrations',
      'Schedule',
      'Profile',
      'Save profile',
      'Route not found',
      'Retry',
      'Load more',
      'No more items',
    ];

    for (final filePath in guardedFiles) {
      final content = File(filePath).readAsStringSync();
      for (final literal in forbiddenLiterals) {
        expect(
          content.contains("'$literal'"),
          isFalse,
          reason:
              'Found hardcoded literal "$literal" in $filePath. Use AppLocalizations instead.',
        );
      }
    }
  });
}
