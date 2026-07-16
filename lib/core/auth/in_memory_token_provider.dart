import 'token_provider.dart';

class InMemoryTokenProvider implements TokenProvider {
  InMemoryTokenProvider({String? initialToken}) : _token = initialToken;

  String? _token;

  @override
  Future<String?> readAccessToken() async => _token;

  void setToken(String? token) {
    _token = token;
  }
}
