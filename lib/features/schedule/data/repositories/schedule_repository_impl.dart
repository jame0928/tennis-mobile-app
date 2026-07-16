import '../../domain/repositories/schedule_repository.dart';
import '../datasources/schedule_remote_data_source.dart';
import '../query/schedule_query.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  const ScheduleRepositoryImpl(this.remote);

  final ScheduleRemoteDataSource remote;

  @override
  Future<SchedulePage> listMySchedule(ScheduleQuery query) async {
    final (items, meta) = await remote.listMySchedule(query);
    return SchedulePage(items: items, meta: meta);
  }

  @override
  Future<SchedulePage> listTournamentSchedule({
    required String tournamentId,
    required ScheduleQuery query,
  }) async {
    final (items, meta) = await remote.listTournamentSchedule(
      tournamentId: tournamentId,
      query: query,
    );
    return SchedulePage(items: items, meta: meta);
  }
}
