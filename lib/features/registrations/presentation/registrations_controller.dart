import 'package:flutter/foundation.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/network/error_mapper.dart';
import '../../../../core/state/view_state.dart';
import '../data/query/registration_query.dart';
import '../domain/entities/registration.dart';
import '../domain/usecases/create_registration.dart';
import '../domain/usecases/list_my_registrations.dart';
import '../domain/usecases/withdraw_registration.dart';

class RegistrationsController extends ChangeNotifier {
  RegistrationsController({
    required this.createRegistration,
    required this.listMyRegistrations,
    required this.withdrawRegistration,
    required this.errorMapper,
  });

  final CreateRegistration createRegistration;
  final ListMyRegistrations listMyRegistrations;
  final WithdrawRegistration withdrawRegistration;
  final ErrorMapper errorMapper;

  ViewState<List<Registration>> state = ViewState.idle();
  String? nextCursor;
  bool hasMore = false;
  String feedbackMessage = '';

  Future<void> loadFirstPage({String? q}) async {
    state = ViewState.loading();
    notifyListeners();
    try {
      final page = await listMyRegistrations(RegistrationQuery(q: q));
      nextCursor = page.meta.nextCursor;
      hasMore = page.meta.hasMore;
      state = page.items.isEmpty
          ? ViewState.empty()
          : ViewState.success(page.items);
    } on ApiException catch (e) {
      final failure = errorMapper.fromApiException(e);
      state = ViewState.failure(failure.message, requestId: failure.requestId);
    }
    notifyListeners();
  }

  Future<void> loadMore({String? q}) async {
    if (!hasMore || nextCursor == null || state.data == null) return;
    final current = state.data!;
    state = ViewState.paginating(current);
    notifyListeners();

    try {
      final page = await listMyRegistrations(
        RegistrationQuery(q: q, cursor: nextCursor),
      );
      nextCursor = page.meta.nextCursor;
      hasMore = page.meta.hasMore;
      state = ViewState.success([...current, ...page.items]);
    } on ApiException catch (e) {
      final failure = errorMapper.fromApiException(e);
      state = ViewState.failure(failure.message, requestId: failure.requestId);
    }
    notifyListeners();
  }

  Future<void> create({
    required String tournamentId,
    required String categoryId,
  }) async {
    try {
      await createRegistration(
        tournamentId: tournamentId,
        tournamentCategoryId: categoryId,
      );
      feedbackMessage = 'Registration created';
      await loadFirstPage();
    } on ApiException catch (e) {
      final failure = errorMapper.fromApiException(e);
      if (failure.type == FailureType.conflict) {
        feedbackMessage = 'Conflict: duplicate or category full.';
      } else if (failure.type == FailureType.businessRule) {
        feedbackMessage =
            'Business rule violation: registration window closed.';
      } else {
        feedbackMessage = failure.message;
      }
      notifyListeners();
    }
  }

  Future<void> withdraw(String registrationId) async {
    try {
      await withdrawRegistration(registrationId);
      feedbackMessage = 'Registration withdrawn';
      await loadFirstPage();
    } on ApiException catch (e) {
      final failure = errorMapper.fromApiException(e);
      if (failure.type == FailureType.businessRule) {
        feedbackMessage = 'Cannot withdraw in the current tournament status.';
      } else {
        feedbackMessage = failure.message;
      }
      notifyListeners();
    }
  }
}
