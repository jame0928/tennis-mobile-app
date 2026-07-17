import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl(this.remote);

  final AuthRemoteDataSource remote;

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final dto = await remote.login(email: email, password: password);
    return dto.toEntity();
  }
}
