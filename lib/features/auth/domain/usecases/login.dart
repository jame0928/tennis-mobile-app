import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class Login {
  const Login(this.repository);

  final AuthRepository repository;

  Future<AuthSession> call({
    required String email,
    required String password,
  }) {
    return repository.login(email: email, password: password);
  }
}
