import 'package:flutter_test/flutter_test.dart';
import 'package:tennis_tournament_app/core/network/pagination_meta.dart';
import 'package:tennis_tournament_app/features/academies/data/query/academy_query.dart';
import 'package:tennis_tournament_app/features/academies/domain/entities/academy.dart';
import 'package:tennis_tournament_app/features/academies/domain/repositories/academy_repository.dart';
import 'package:tennis_tournament_app/features/academies/domain/usecases/list_academies.dart';

class _FakeAcademyRepository implements AcademyRepository {
  @override
  Future<Academy> getAcademyDetail(String academyId) {
    throw UnimplementedError();
  }

  @override
  Future<AcademyPage> listAcademies(AcademyQuery query) async {
    return AcademyPage(
      items: const [
        Academy(id: 'a1', name: 'Academia Centro', city: 'Madrid'),
      ],
      meta: const PaginationMeta(requestId: 'req-academies'),
    );
  }
}

void main() {
  test('list academies use case returns repository data', () async {
    final useCase = ListAcademies(_FakeAcademyRepository());

    final page = await useCase(const AcademyQuery(q: 'centro'));

    expect(page.items, hasLength(1));
    expect(page.items.first.id, 'a1');
  });
}
