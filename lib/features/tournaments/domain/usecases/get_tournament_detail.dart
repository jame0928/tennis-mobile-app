import '../entities/tournament.dart';
import '../repositories/tournament_repository.dart';

class GetTournamentDetail {
  const GetTournamentDetail(this.repository);

  final TournamentRepository repository;

  Future<Tournament> call(String tournamentId) {
    return repository.getTournamentDetail(tournamentId);
  }
}
