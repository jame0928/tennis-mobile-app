import '../../../../core/network/pagination_meta.dart';
import '../../data/query/ranking_query.dart';
import '../entities/ranking.dart';

class RankingPage {
  const RankingPage({required this.items, required this.meta});

  final List<Ranking> items;
  final PaginationMeta meta;
}

abstract class RankingRepository {
  Future<RankingPage> listRankings(RankingQuery query);

  Future<Ranking> getRankingDetail(String rankingId);
}
