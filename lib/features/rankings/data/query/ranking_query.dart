class RankingQuery {
  const RankingQuery({
    this.q,
    this.rankingType,
    this.category,
    this.gender,
    this.limit = 10,
    this.cursor,
  });

  final String? q;
  final String? rankingType;
  final String? category;
  final String? gender;
  final int limit;
  final String? cursor;

  Map<String, String> toParams() {
    return {
      if (q != null && q!.isNotEmpty) 'q': q!,
      if (rankingType != null && rankingType!.isNotEmpty)
        'ranking_type': rankingType!,
      if (category != null && category!.isNotEmpty) 'category': category!,
      if (gender != null && gender!.isNotEmpty) 'gender': gender!,
      'limit': '$limit',
      if (cursor != null && cursor!.isNotEmpty) 'cursor': cursor!,
    };
  }
}
