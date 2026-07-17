import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/pagination_meta.dart';
import '../../domain/entities/ranking.dart';
import '../../domain/entities/ranking_entry.dart';
import '../query/ranking_query.dart';

class RankingRemoteDataSource {
  const RankingRemoteDataSource(this.client);

  final ApiClient client;

  Future<(List<Ranking>, PaginationMeta)> listRankings(RankingQuery query) async {
    final response = await client.get(
      ApiPaths.rankings(),
      authenticated: false,
      query: query.toParams(),
    );

    final list = (response.data as List<dynamic>)
        .map((json) => _fromJson(json as Map<String, dynamic>))
        .toList();

    return (list, response.meta);
  }

  Future<Ranking> getRankingDetail(String rankingId) async {
    final response = await client.get(
      ApiPaths.rankingDetail(rankingId),
      authenticated: false,
    );

    return _fromJson(response.data as Map<String, dynamic>);
  }

  Ranking _fromJson(Map<String, dynamic> json) {
    final entries = (json['entries'] as List<dynamic>? ?? const [])
        .map((entry) => _entryFromJson(entry as Map<String, dynamic>))
        .toList();

    return Ranking(
      id: json['id'] as String? ?? '',
      title: (json['title'] as String?) ?? (json['name'] as String?) ?? '',
      rankingType: json['ranking_type'] as String? ?? '',
      category: json['category'] as String? ?? '',
      gender: json['gender'] as String? ?? '',
      entries: entries,
    );
  }

  RankingEntry _entryFromJson(Map<String, dynamic> json) {
    return RankingEntry(
      position: json['position'] as int? ?? 0,
      name: (json['name'] as String?) ?? (json['player_name'] as String?) ?? '',
      points: json['points'] as int? ?? 0,
    );
  }
}
