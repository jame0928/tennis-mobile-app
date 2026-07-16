import '../repositories/registration_repository.dart';

class WithdrawRegistration {
  const WithdrawRegistration(this.repository);

  final RegistrationRepository repository;

  Future<String> call(String registrationId) {
    return repository.withdrawRegistration(registrationId);
  }
}
