import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'token_provider.dart';

class SecureTokenProvider implements TokenProvider {
  SecureTokenProvider({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const _accessTokenKey = 'auth_access_token';

  final FlutterSecureStorage _storage;

  @override
  Future<void> clearAccessToken() {
    return _storage.delete(key: _accessTokenKey);
  }

  @override
  Future<String?> readAccessToken() {
    return _storage.read(key: _accessTokenKey);
  }

  @override
  Future<void> writeAccessToken(String token) {
    return _storage.write(key: _accessTokenKey, value: token);
  }
}
