import 'package:flutter_test/flutter_test.dart';
import 'package:tennis_tournament_app/core/network/pagination_meta.dart';
import 'package:tennis_tournament_app/features/rankings/data/query/ranking_query.dart';
import 'package:tennis_tournament_app/features/rankings/domain/entities/ranking.dart';
import 'package:tennis_tournament_app/features/rankings/domain/repositories/ranking_repository.dart';
import 'package:tennis_tournament_app/features/rankings/domain/usecases/list_rankings.dart';

class _FakeRankingRepository implements RankingRepository {
  @override
  Future<Ranking> getRankingDetail(String rankingId) {
    throw UnimplementedError();
  }

  @override
  Future<RankingPage> listRankings(RankingQuery query) async {
    return RankingPage(
      items: const [
        Ranking(
          id: 'r1',
          title: 'Ranking Open',
          rankingType: 'general',
          category: 'A',
          gender: 'M',
        ),
      ],
      meta: const PaginationMeta(requestId: 'req-rankings'),
    );
  }
}

void main() {
  test('list rankings use case returns repository data', () async {
    final useCase = ListRankings(_FakeRankingRepository());

    final page = await useCase(const RankingQuery(q: 'open'));

    expect(page.items, hasLength(1));
    expect(page.items.first.id, 'r1');
  });
}
