class ApiPaths {
  ApiPaths._();

    static const v1 = '/api/v1';

  static String tournaments() => '$v1/tournaments';
  static String tournamentDetail(String tournamentId) =>
      '$v1/tournaments/$tournamentId';
  static String tournamentRegistrations(String tournamentId) =>
      '$v1/tournaments/$tournamentId/registrations';
  static String tournamentSchedule(String tournamentId) =>
      '$v1/tournaments/$tournamentId/schedule';

  static String me() => '$v1/me';
  static String myRegistrations() => '$v1/me/registrations';
  static String myRegistrationDetail(String registrationId) =>
      '$v1/me/registrations/$registrationId';
  static String mySchedule() => '$v1/me/schedule';

  static String rankings() => '$v1/rankings';
  static String rankingDetail(String rankingId) => '$v1/rankings/$rankingId';
  static String academies() => '$v1/academies';
  static String academyDetail(String academyId) => '$v1/academies/$academyId';

  static String login() => '$v1/auth/login';
}