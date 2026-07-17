abstract class TokenProvider {
  Future<String?> readAccessToken();

  Future<void> writeAccessToken(String token);

  Future<void> clearAccessToken();
}
