import 'ranking_entry.dart';

class Ranking {
  const Ranking({
    required this.id,
    required this.title,
    required this.rankingType,
    required this.category,
    required this.gender,
    this.entries = const [],
  });

  final String id;
  final String title;
  final String rankingType;
  final String category;
  final String gender;
  final List<RankingEntry> entries;
}
