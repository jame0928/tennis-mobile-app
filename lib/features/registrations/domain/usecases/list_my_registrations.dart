import '../../data/query/registration_query.dart';
import '../repositories/registration_repository.dart';

class ListMyRegistrations {
  const ListMyRegistrations(this.repository);

  final RegistrationRepository repository;

  Future<RegistrationPage> call(RegistrationQuery query) {
    return repository.listMyRegistrations(query);
  }
}
