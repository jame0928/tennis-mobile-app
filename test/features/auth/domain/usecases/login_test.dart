import 'package:flutter_test/flutter_test.dart';
import 'package:tennis_tournament_app/features/auth/domain/entities/auth_session.dart';
import 'package:tennis_tournament_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:tennis_tournament_app/features/auth/domain/usecases/login.dart';

class _FakeAuthRepository implements AuthRepository {
  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    return const AuthSession(accessToken: 'token-demo');
  }
}

void main() {
  test('login use case delegates to repository', () async {
    final useCase = Login(_FakeAuthRepository());

    final session = await useCase(email: 'demo@test.com', password: '123456');

    expect(session.accessToken, 'token-demo');
  });
}
