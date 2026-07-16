import '../../domain/entities/registration.dart';
import '../../domain/repositories/registration_repository.dart';
import '../datasources/registration_remote_data_source.dart';
import '../query/registration_query.dart';

class RegistrationRepositoryImpl implements RegistrationRepository {
  const RegistrationRepositoryImpl(this.remote);

  final RegistrationRemoteDataSource remote;

  @override
  Future<Registration> createRegistration({
    required String tournamentId,
    required String tournamentCategoryId,
    String? paymentProofUrl,
  }) {
    return remote.createRegistration(
      tournamentId: tournamentId,
      tournamentCategoryId: tournamentCategoryId,
      paymentProofUrl: paymentProofUrl,
    );
  }

  @override
  Future<RegistrationPage> listMyRegistrations(RegistrationQuery query) async {
    final (items, meta) = await remote.listMyRegistrations(query);
    return RegistrationPage(items: items, meta: meta);
  }

  @override
  Future<String> withdrawRegistration(String registrationId) {
    return remote.withdrawRegistration(registrationId);
  }
}
