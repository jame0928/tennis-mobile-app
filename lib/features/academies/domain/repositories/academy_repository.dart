import '../../../../core/network/pagination_meta.dart';
import '../../data/query/academy_query.dart';
import '../entities/academy.dart';

class AcademyPage {
  const AcademyPage({required this.items, required this.meta});

  final List<Academy> items;
  final PaginationMeta meta;
}

abstract class AcademyRepository {
  Future<AcademyPage> listAcademies(AcademyQuery query);

  Future<Academy> getAcademyDetail(String academyId);
}
