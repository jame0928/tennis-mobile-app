import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_client.dart';
import '../dto/auth_session_dto.dart';

class AuthRemoteDataSource {
  const AuthRemoteDataSource(this.client);

  final ApiClient client;

  Future<AuthSessionDto> login({
    required String email,
    required String password,
  }) async {
    final response = await client.post(
      ApiPaths.login(),
      authenticated: false,
      body: {
        'email': email,
        'password': password,
      },
    );

    return AuthSessionDto.fromJson(response.data as Map<String, dynamic>);
  }
}
