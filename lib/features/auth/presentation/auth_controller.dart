import 'package:flutter/foundation.dart';

import '../../../core/auth/auth_controller.dart' as core_auth;
import '../../../core/network/api_exception.dart';
import '../../../core/network/error_mapper.dart';
import '../../../core/state/view_state.dart';
import '../domain/usecases/login.dart';

class AuthController extends ChangeNotifier {
  AuthController({
    required this.loginUseCase,
    required this.errorMapper,
    required this.sessionController,
  });

  final Login loginUseCase;
  final ErrorMapper errorMapper;
  final core_auth.AuthController sessionController;

  ViewState<void> state = ViewState.idle();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = ViewState.loading();
    notifyListeners();

    try {
      final session = await loginUseCase(
        email: email,
        password: password,
      );

      if (session.accessToken.isEmpty) {
        state = ViewState.failure('LOGIN_INVALID_SESSION');
      } else {
        await sessionController.login(session.accessToken);
        state = ViewState.success(null);
      }
    } on ApiException catch (e) {
      final failure = errorMapper.fromApiException(e);
      state = ViewState.failure(failure.message, requestId: failure.requestId);
    }

    notifyListeners();
  }
}
