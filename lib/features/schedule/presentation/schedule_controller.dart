import 'package:flutter/foundation.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/network/error_mapper.dart';
import '../../../../core/state/view_state.dart';
import '../data/query/schedule_query.dart';
import '../domain/entities/schedule_match.dart';
import '../domain/usecases/list_my_schedule.dart';
import '../domain/usecases/list_tournament_schedule.dart';

class ScheduleController extends ChangeNotifier {
  ScheduleController({
    required this.listMySchedule,
    required this.listTournamentSchedule,
    required this.errorMapper,
  });

  final ListMySchedule listMySchedule;
  final ListTournamentSchedule listTournamentSchedule;
  final ErrorMapper errorMapper;

  ViewState<List<ScheduleMatch>> myState = ViewState.idle();
  ViewState<List<ScheduleMatch>> tournamentState = ViewState.idle();

  Future<void> loadMySchedule({String? q, String? from, String? to}) async {
    myState = ViewState.loading();
    notifyListeners();

    try {
      final page = await listMySchedule(
        ScheduleQuery(q: q, from: from, to: to),
      );
      myState = page.items.isEmpty
          ? ViewState.empty()
          : ViewState.success(page.items);
    } on ApiException catch (e) {
      final failure = errorMapper.fromApiException(e);
      myState = ViewState.failure(
        failure.message,
        requestId: failure.requestId,
      );
    }
    notifyListeners();
  }

  Future<void> loadTournamentSchedule({
    required String tournamentId,
    String? q,
    String? date,
    String? courtId,
  }) async {
    tournamentState = ViewState.loading();
    notifyListeners();

    try {
      final page = await listTournamentSchedule(
        tournamentId: tournamentId,
        query: ScheduleQuery(q: q, date: date, courtId: courtId),
      );
      tournamentState = page.items.isEmpty
          ? ViewState.empty()
          : ViewState.success(page.items);
    } on ApiException catch (e) {
      final failure = errorMapper.fromApiException(e);
      tournamentState = ViewState.failure(
        failure.message,
        requestId: failure.requestId,
      );
    }
    notifyListeners();
  }
}
