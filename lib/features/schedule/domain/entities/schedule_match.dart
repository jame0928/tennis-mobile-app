class ScheduleMatch {
  const ScheduleMatch({
    required this.id,
    required this.status,
    this.roundName,
    this.courtName,
    this.scoreSummary,
    this.scheduledAt,
  });

  final String id;
  final String status;
  final String? roundName;
  final String? courtName;
  final String? scoreSummary;
  final DateTime? scheduledAt;
}
