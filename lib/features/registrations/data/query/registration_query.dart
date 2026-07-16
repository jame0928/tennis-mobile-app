class RegistrationQuery {
  const RegistrationQuery({
    this.state = 'all',
    this.paymentStatus,
    this.tournamentStatus,
    this.q,
    this.limit = 10,
    this.cursor,
  });

  final String state;
  final String? paymentStatus;
  final String? tournamentStatus;
  final String? q;
  final int limit;
  final String? cursor;

  Map<String, String> toParams() {
    return {
      'state': state,
      'limit': '$limit',
      if (paymentStatus != null && paymentStatus!.isNotEmpty)
        'payment_status': paymentStatus!,
      if (tournamentStatus != null && tournamentStatus!.isNotEmpty)
        'tournament_status': tournamentStatus!,
      if (q != null && q!.isNotEmpty) 'q': q!,
      if (cursor != null && cursor!.isNotEmpty) 'cursor': cursor!,
    };
  }
}
