import '../../../../core/network/api_client.dart';
import '../../../../core/config/api_paths.dart';
import '../../../../core/network/pagination_meta.dart';
import '../../domain/entities/schedule_match.dart';
import '../query/schedule_query.dart';

class ScheduleRemoteDataSource {
  const ScheduleRemoteDataSource(this.client);

  final ApiClient client;

  Future<(List<ScheduleMatch>, PaginationMeta)> listMySchedule(
    ScheduleQuery query,
  ) async {
    final response = await client.get(
      ApiPaths.mySchedule(),
      query: query.toParams(),
    );
    final list = (response.data as List<dynamic>)
        .map((json) => _fromJson(json as Map<String, dynamic>))
        .toList();
    return (list, response.meta);
  }

  Future<(List<ScheduleMatch>, PaginationMeta)> listTournamentSchedule({
    required String tournamentId,
    required ScheduleQuery query,
  }) async {
    final response = await client.get(
      ApiPaths.tournamentSchedule(tournamentId),
      query: query.toParams(isTournamentSchedule: true),
    );
    final list = (response.data as List<dynamic>)
        .map((json) => _fromJson(json as Map<String, dynamic>))
        .toList();
    return (list, response.meta);
  }

  ScheduleMatch _fromJson(Map<String, dynamic> json) {
    return ScheduleMatch(
      id: json['id'] as String? ?? '',
      status: json['status'] as String? ?? '',
      roundName: json['round_name'] as String?,
      courtName: json['court_name'] as String?,
      scoreSummary: json['score_summary'] as String?,
      scheduledAt: json['scheduled_at'] == null
          ? null
          : DateTime.tryParse(json['scheduled_at'] as String),
    );
  }
}
