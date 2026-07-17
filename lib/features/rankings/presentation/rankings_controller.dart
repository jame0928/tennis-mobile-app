import 'package:flutter/foundation.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/error_mapper.dart';
import '../../../core/state/view_state.dart';
import '../data/query/ranking_query.dart';
import '../domain/entities/ranking.dart';
import '../domain/usecases/get_ranking_detail.dart';
import '../domain/usecases/list_rankings.dart';

class RankingsController extends ChangeNotifier {
  RankingsController({
    required this.listRankings,
    required this.getRankingDetail,
    required this.errorMapper,
  });

  final ListRankings listRankings;
  final GetRankingDetail getRankingDetail;
  final ErrorMapper errorMapper;

  ViewState<List<Ranking>> state = ViewState.idle();
  String searchQuery = '';
  String? nextCursor;
  bool hasMore = false;

  Future<void> loadFirstPage({String? query}) async {
    if (query != null) {
      searchQuery = query;
    }

    state = ViewState.loading();
    notifyListeners();

    try {
      final page = await listRankings(
        RankingQuery(q: searchQuery.isEmpty ? null : searchQuery),
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
      final page = await listRankings(
        RankingQuery(
          q: searchQuery.isEmpty ? null : searchQuery,
          cursor: nextCursor,
        ),
      );
      hasMore = page.meta.hasMore;
      nextCursor = page.meta.nextCursor;
      state = ViewState.success([...current, ...page.items]);
    } on ApiException catch (e) {
      final failure = errorMapper.fromApiException(e);
      state = ViewState.failure(failure.message, requestId: failure.requestId);
    }

    notifyListeners();
  }

  Future<Ranking> loadDetail(String rankingId) {
    return getRankingDetail(rankingId);
  }
}
