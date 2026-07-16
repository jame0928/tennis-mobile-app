import '../../../../core/network/api_client.dart';
import '../../../../core/network/pagination_meta.dart';
import '../../domain/entities/tournament.dart';
import '../query/tournament_query.dart';

class TournamentRemoteDataSource {
  const TournamentRemoteDataSource(this.client);

  final ApiClient client;

  Future<(List<Tournament>, PaginationMeta)> listTournaments(
    TournamentQuery query,
  ) async {
    final response = await client.get(
      '/api/v1/tournaments',
      query: query.toParams(),
    );
    final list = (response.data as List<dynamic>)
        .map((json) => _fromJson(json as Map<String, dynamic>))
        .toList();
    return (list, response.meta);
  }

  Future<Tournament> getTournament(String id) async {
    final response = await client.get(
      '/api/v1/tournaments/$id',
      authenticated: false,
    );
    return _fromJson(response.data as Map<String, dynamic>);
  }

  Tournament _fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      status: json['status'] as String? ?? '',
      description: json['description'] as String?,
      venue: json['venue'] as String?,
    );
  }
}
