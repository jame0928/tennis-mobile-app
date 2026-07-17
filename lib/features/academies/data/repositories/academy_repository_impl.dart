import '../../domain/entities/academy.dart';
import '../../domain/repositories/academy_repository.dart';
import '../datasources/academy_remote_data_source.dart';
import '../query/academy_query.dart';

class AcademyRepositoryImpl implements AcademyRepository {
  const AcademyRepositoryImpl(this.remote);

  final AcademyRemoteDataSource remote;

  @override
  Future<Academy> getAcademyDetail(String academyId) {
    return remote.getAcademyDetail(academyId);
  }

  @override
  Future<AcademyPage> listAcademies(AcademyQuery query) async {
    final (items, meta) = await remote.listAcademies(query);
    return AcademyPage(items: items, meta: meta);
  }
}
