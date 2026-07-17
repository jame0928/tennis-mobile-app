import '../../domain/entities/ranking.dart';
import '../../domain/repositories/ranking_repository.dart';
import '../datasources/ranking_remote_data_source.dart';
import '../query/ranking_query.dart';

class RankingRepositoryImpl implements RankingRepository {
  const RankingRepositoryImpl(this.remote);

  final RankingRemoteDataSource remote;

  @override
  Future<Ranking> getRankingDetail(String rankingId) {
    return remote.getRankingDetail(rankingId);
  }

  @override
  Future<RankingPage> listRankings(RankingQuery query) async {
    final (items, meta) = await remote.listRankings(query);
    return RankingPage(items: items, meta: meta);
  }
}
