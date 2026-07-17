import 'token_provider.dart';

class InMemoryTokenProvider implements TokenProvider {
  InMemoryTokenProvider({String? initialToken}) : _token = initialToken;

  String? _token;

  @override
  Future<String?> readAccessToken() async => _token;

  @override
  Future<void> writeAccessToken(String token) async {
    _token = token;
  }

  @override
  Future<void> clearAccessToken() async {
    _token = null;
  }
}
