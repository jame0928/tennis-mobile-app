import '../../data/query/academy_query.dart';
import '../repositories/academy_repository.dart';

class ListAcademies {
  const ListAcademies(this.repository);

  final AcademyRepository repository;

  Future<AcademyPage> call(AcademyQuery query) {
    return repository.listAcademies(query);
  }
}
