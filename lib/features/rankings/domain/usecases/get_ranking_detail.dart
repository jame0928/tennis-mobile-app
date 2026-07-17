import '../entities/ranking.dart';
import '../repositories/ranking_repository.dart';

class GetRankingDetail {
  const GetRankingDetail(this.repository);

  final RankingRepository repository;

  Future<Ranking> call(String rankingId) {
    return repository.getRankingDetail(rankingId);
  }
}
