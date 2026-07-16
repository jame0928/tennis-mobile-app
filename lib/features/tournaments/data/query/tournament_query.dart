class TournamentQuery {
  const TournamentQuery({
    this.q,
    this.status,
    this.academySlug,
    this.startFrom,
    this.startTo,
    this.limit = 10,
    this.cursor,
  });

  final String? q;
  final String? status;
  final String? academySlug;
  final String? startFrom;
  final String? startTo;
  final int limit;
  final String? cursor;

  Map<String, String> toParams() {
    return {
      if (q != null && q!.isNotEmpty) 'q': q!,
      if (status != null && status!.isNotEmpty) 'status': status!,
      if (academySlug != null && academySlug!.isNotEmpty)
        'academy_slug': academySlug!,
      if (startFrom != null && startFrom!.isNotEmpty) 'start_from': startFrom!,
      if (startTo != null && startTo!.isNotEmpty) 'start_to': startTo!,
      'limit': '$limit',
      if (cursor != null && cursor!.isNotEmpty) 'cursor': cursor!,
    };
  }
}
