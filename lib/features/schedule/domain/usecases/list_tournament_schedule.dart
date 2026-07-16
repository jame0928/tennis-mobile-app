import '../../data/query/schedule_query.dart';
import '../repositories/schedule_repository.dart';

class ListTournamentSchedule {
  const ListTournamentSchedule(this.repository);

  final ScheduleRepository repository;

  Future<SchedulePage> call({
    required String tournamentId,
    required ScheduleQuery query,
  }) {
    return repository.listTournamentSchedule(
      tournamentId: tournamentId,
      query: query,
    );
  }
}
