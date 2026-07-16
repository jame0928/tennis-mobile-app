import '../../../../core/network/pagination_meta.dart';
import '../../data/query/registration_query.dart';
import '../entities/registration.dart';

class RegistrationPage {
  const RegistrationPage({required this.items, required this.meta});

  final List<Registration> items;
  final PaginationMeta meta;
}

abstract class RegistrationRepository {
  Future<Registration> createRegistration({
    required String tournamentId,
    required String tournamentCategoryId,
    String? paymentProofUrl,
  });

  Future<RegistrationPage> listMyRegistrations(RegistrationQuery query);

  Future<String> withdrawRegistration(String registrationId);
}
