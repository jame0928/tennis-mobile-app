import 'package:flutter/foundation.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/network/error_mapper.dart';
import '../../../../core/state/view_state.dart';
import '../data/query/tournament_query.dart';
import '../domain/entities/tournament.dart';
import '../domain/usecases/get_tournament_detail.dart';
import '../domain/usecases/list_tournaments.dart';

class TournamentsController extends ChangeNotifier {
  TournamentsController({
    required this.listTournaments,
    required this.getTournamentDetail,
    required this.errorMapper,
  });

  final ListTournaments listTournaments;
  final GetTournamentDetail getTournamentDetail;
  final ErrorMapper errorMapper;

  ViewState<List<Tournament>> state = ViewState.idle();
  String searchQuery = '';
  String? status;
  String? academySlug;
  String? nextCursor;
  bool hasMore = false;

  Future<void> loadFirstPage({String? query}) async {
    if (query != null) {
      searchQuery = query;
    }
    state = ViewState.loading();
    notifyListeners();

    try {
      final page = await listTournaments(
        TournamentQuery(q: searchQuery.isEmpty ? null : searchQuery),
      );
      hasMore = page.meta.hasMore;
      nextCursor = page.meta.nextCursor;
      state = page.items.isEmpty
          ? ViewState.empty()
          : ViewState.success(page.items);
    } on ApiException catch (e) {
      final failure = errorMapper.fromApiException(e);
      state = ViewState.failure(failure.message, requestId: failure.requestId);
    }
    notifyListeners();
  }

  Future<void> loadMore() async {
    if (!hasMore || nextCursor == null || state.data == null) return;
    final current = state.data!;
    state = ViewState.paginating(current);
    notifyListeners();

    try {
      final page = await listTournaments(
        TournamentQuery(
          q: searchQuery.isEmpty ? null : searchQuery,
          cursor: nextCursor,
        ),
      );
      final merged = [...current, ...page.items];
      hasMore = page.meta.hasMore;
      nextCursor = page.meta.nextCursor;
      state = ViewState.success(merged);
    } on ApiException catch (e) {
      final failure = errorMapper.fromApiException(e);
      state = ViewState.failure(failure.message, requestId: failure.requestId);
    }
    notifyListeners();
  }

  Future<Tournament> loadDetail(String tournamentId) {
    return getTournamentDetail(tournamentId);
  }
}
