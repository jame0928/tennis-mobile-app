import '../../../../core/network/pagination_meta.dart';
import '../../data/query/tournament_query.dart';
import '../entities/tournament.dart';

class TournamentPage {
  const TournamentPage({required this.items, required this.meta});

  final List<Tournament> items;
  final PaginationMeta meta;
}

abstract class TournamentRepository {
  Future<TournamentPage> listTournaments(TournamentQuery query);
  Future<Tournament> getTournamentDetail(String tournamentId);
}
