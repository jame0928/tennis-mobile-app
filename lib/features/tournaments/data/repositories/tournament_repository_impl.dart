import '../../domain/entities/tournament.dart';
import '../../domain/repositories/tournament_repository.dart';
import '../datasources/tournament_remote_data_source.dart';
import '../query/tournament_query.dart';

class TournamentRepositoryImpl implements TournamentRepository {
  const TournamentRepositoryImpl(this.remote);

  final TournamentRemoteDataSource remote;

  @override
  Future<Tournament> getTournamentDetail(String tournamentId) {
    return remote.getTournament(tournamentId);
  }

  @override
  Future<TournamentPage> listTournaments(TournamentQuery query) async {
    final (items, meta) = await remote.listTournaments(query);
    return TournamentPage(items: items, meta: meta);
  }
}
