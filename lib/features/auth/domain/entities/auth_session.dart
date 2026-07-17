class AuthSession {
  const AuthSession({
    required this.accessToken,
    this.refreshToken,
  });

  final String accessToken;
  final String? refreshToken;
}
