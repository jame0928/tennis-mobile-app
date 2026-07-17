import 'package:flutter/foundation.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/error_mapper.dart';
import '../../../core/state/view_state.dart';
import '../data/query/academy_query.dart';
import '../domain/entities/academy.dart';
import '../domain/usecases/get_academy_detail.dart';
import '../domain/usecases/list_academies.dart';

class AcademiesController extends ChangeNotifier {
  AcademiesController({
    required this.listAcademies,
    required this.getAcademyDetail,
    required this.errorMapper,
  });

  final ListAcademies listAcademies;
  final GetAcademyDetail getAcademyDetail;
  final ErrorMapper errorMapper;

  ViewState<List<Academy>> state = ViewState.idle();
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
      final page = await listAcademies(
        AcademyQuery(q: searchQuery.isEmpty ? null : searchQuery),
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
      final page = await listAcademies(
        AcademyQuery(
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

  Future<Academy> loadDetail(String academyId) {
    return getAcademyDetail(academyId);
  }
}
