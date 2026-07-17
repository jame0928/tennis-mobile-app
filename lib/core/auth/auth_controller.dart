import 'package:flutter/foundation.dart';

import 'token_provider.dart';

class AuthController extends ChangeNotifier {
  AuthController({required this.tokenProvider});

  final TokenProvider tokenProvider;

  bool _initialized = false;
  bool _initializing = false;
  bool _authenticated = false;
  String? _pendingRoute;
  Object? _pendingArguments;

  bool get initialized => _initialized;
  bool get isAuthenticated => _authenticated;
  String? get pendingRoute => _pendingRoute;
  Object? get pendingArguments => _pendingArguments;

  Future<void> initialize() async {
    if (_initialized || _initializing) {
      return;
    }
    _initializing = true;

    try {
      final token = await tokenProvider.readAccessToken();
      _authenticated = token != null && token.isNotEmpty;
    } catch (_) {
      _authenticated = false;
    }

    _initialized = true;
    _initializing = false;
    notifyListeners();
  }

  Future<void> login(String token) async {
    await tokenProvider.writeAccessToken(token);
    _authenticated = true;
    notifyListeners();
  }

  Future<void> logout() async {
    await tokenProvider.clearAccessToken();
    _authenticated = false;
    _pendingRoute = null;
    _pendingArguments = null;
    notifyListeners();
  }

  void setPendingRoute({required String route, Object? arguments}) {
    _pendingRoute = route;
    _pendingArguments = arguments;
  }

  (String?, Object?) consumePendingRoute() {
    final route = _pendingRoute;
    final args = _pendingArguments;
    _pendingRoute = null;
    _pendingArguments = null;
    return (route, args);
  }
}