import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tennis_tournament_app/core/auth/in_memory_token_provider.dart';
import 'package:tennis_tournament_app/core/network/api_client.dart';
import 'package:tennis_tournament_app/core/network/pagination_meta.dart';
import 'package:tennis_tournament_app/core/telemetry/safe_telemetry.dart';
import 'package:tennis_tournament_app/features/tournaments/data/datasources/tournament_remote_data_source.dart';
import 'package:tennis_tournament_app/features/tournaments/data/query/tournament_query.dart';
import 'package:tennis_tournament_app/features/tournaments/data/repositories/tournament_repository_impl.dart';
import 'package:tennis_tournament_app/features/tournaments/domain/entities/tournament.dart';

class _FakeRemoteDataSource extends TournamentRemoteDataSource {
  _FakeRemoteDataSource()
    : super(
        ApiClient(
          baseUrl: 'https://example.com',
          httpClient: http.Client(),
          tokenProvider: InMemoryTokenProvider(),
          telemetry: SafeTelemetry(),
        ),
      );

  @override
  Future<(List<Tournament>, PaginationMeta)> listTournaments(
    TournamentQuery query,
  ) async {
    return (
      const [
        Tournament(
          id: '1',
          name: 'Open 2026',
          slug: 'open-2026',
          status: 'registration_open',
        ),
      ],
      const PaginationMeta(requestId: 'req-1', hasMore: false, limit: 10),
    );
  }

  @override
  Future<Tournament> getTournament(String id) async {
    return Tournament(
      id: id,
      name: 'Open 2026',
      slug: 'open-2026',
      status: 'in_progress',
    );
  }
}

void main() {
  test('maps datasource output into tournament page', () async {
    final repository = TournamentRepositoryImpl(_FakeRemoteDataSource());

    final page = await repository.listTournaments(const TournamentQuery());

    expect(page.items, hasLength(1));
    expect(page.items.first.name, 'Open 2026');
    expect(page.meta.limit, 10);
  });
}
