import '../../data/query/tournament_query.dart';
import '../repositories/tournament_repository.dart';

class ListTournaments {
  const ListTournaments(this.repository);

  final TournamentRepository repository;

  Future<TournamentPage> call(TournamentQuery query) {
    return repository.listTournaments(query);
  }
}
