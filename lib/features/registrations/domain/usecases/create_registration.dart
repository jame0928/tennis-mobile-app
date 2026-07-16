import '../entities/registration.dart';
import '../repositories/registration_repository.dart';

class CreateRegistration {
  const CreateRegistration(this.repository);

  final RegistrationRepository repository;

  Future<Registration> call({
    required String tournamentId,
    required String tournamentCategoryId,
    String? paymentProofUrl,
  }) {
    return repository.createRegistration(
      tournamentId: tournamentId,
      tournamentCategoryId: tournamentCategoryId,
      paymentProofUrl: paymentProofUrl,
    );
  }
}
