import 'package:flutter_test/flutter_test.dart';
import 'package:tennis_tournament_app/core/network/pagination_meta.dart';
import 'package:tennis_tournament_app/features/tournaments/data/query/tournament_query.dart';

void main() {
  group('API contract compliance', () {
    test('tournament query defaults to limit 10', () {
      const query = TournamentQuery();
      expect(query.toParams()['limit'], '10');
    });

    test('pagination meta reads contract keys', () {
      final meta = PaginationMeta.fromJson(const {
        'request_id': 'req-123',
        'has_more': true,
        'next_cursor': 'cursor-2',
        'limit': 10,
      });

      expect(meta.requestId, 'req-123');
      expect(meta.hasMore, isTrue);
      expect(meta.nextCursor, 'cursor-2');
      expect(meta.limit, 10);
    });
  });
}
