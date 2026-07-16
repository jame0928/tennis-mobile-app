import '../../../../core/network/pagination_meta.dart';
import '../../data/query/schedule_query.dart';
import '../entities/schedule_match.dart';

class SchedulePage {
  const SchedulePage({required this.items, required this.meta});

  final List<ScheduleMatch> items;
  final PaginationMeta meta;
}

abstract class ScheduleRepository {
  Future<SchedulePage> listMySchedule(ScheduleQuery query);

  Future<SchedulePage> listTournamentSchedule({
    required String tournamentId,
    required ScheduleQuery query,
  });
}
