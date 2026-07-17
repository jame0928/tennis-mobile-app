import '../../data/query/ranking_query.dart';
import '../repositories/ranking_repository.dart';

class ListRankings {
  const ListRankings(this.repository);

  final RankingRepository repository;

  Future<RankingPage> call(RankingQuery query) {
    return repository.listRankings(query);
  }
}
