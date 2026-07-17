import '../entities/academy.dart';
import '../repositories/academy_repository.dart';

class GetAcademyDetail {
  const GetAcademyDetail(this.repository);

  final AcademyRepository repository;

  Future<Academy> call(String academyId) {
    return repository.getAcademyDetail(academyId);
  }
}
