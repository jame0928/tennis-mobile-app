import '../../data/query/schedule_query.dart';
import '../repositories/schedule_repository.dart';

class ListMySchedule {
  const ListMySchedule(this.repository);

  final ScheduleRepository repository;

  Future<SchedulePage> call(ScheduleQuery query) {
    return repository.listMySchedule(query);
  }
}
