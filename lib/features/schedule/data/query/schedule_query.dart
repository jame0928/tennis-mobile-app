class ScheduleQuery {
  const ScheduleQuery({
    this.q,
    this.from,
    this.to,
    this.status,
    this.tournamentId,
    this.date,
    this.courtId,
    this.limit = 10,
    this.cursor,
  });

  final String? q;
  final String? from;
  final String? to;
  final String? status;
  final String? tournamentId;
  final String? date;
  final String? courtId;
  final int limit;
  final String? cursor;

  Map<String, String> toParams({bool isTournamentSchedule = false}) {
    return {
      if (q != null && q!.isNotEmpty) 'q': q!,
      if (!isTournamentSchedule && from != null && from!.isNotEmpty)
        'from': from!,
      if (!isTournamentSchedule && to != null && to!.isNotEmpty) 'to': to!,
      if (!isTournamentSchedule &&
          tournamentId != null &&
          tournamentId!.isNotEmpty)
        'tournament_id': tournamentId!,
      if (isTournamentSchedule && date != null && date!.isNotEmpty)
        'date': date!,
      if (isTournamentSchedule && courtId != null && courtId!.isNotEmpty)
        'court_id': courtId!,
      if (status != null && status!.isNotEmpty) 'status': status!,
      'limit': '$limit',
      if (cursor != null && cursor!.isNotEmpty) 'cursor': cursor!,
    };
  }
}
