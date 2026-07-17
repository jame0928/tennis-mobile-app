import '../../domain/entities/auth_session.dart';

class AuthSessionDto {
  const AuthSessionDto({
    required this.accessToken,
    this.refreshToken,
  });

  final String accessToken;
  final String? refreshToken;

  factory AuthSessionDto.fromJson(Map<String, dynamic> json) {
    final session = json['session'] as Map<String, dynamic>?;
    final accessToken =
        (json['access_token'] as String?) ??
        (json['token'] as String?) ??
        (session?['access_token'] as String?) ??
        '';

    final refreshToken =
        (json['refresh_token'] as String?) ??
        (session?['refresh_token'] as String?);

    return AuthSessionDto(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  AuthSession toEntity() {
    return AuthSession(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }
}
