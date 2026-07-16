import '../../../../core/network/api_client.dart';
import '../../../../core/network/pagination_meta.dart';
import '../../domain/entities/registration.dart';
import '../query/registration_query.dart';

class RegistrationRemoteDataSource {
  const RegistrationRemoteDataSource(this.client);

  final ApiClient client;

  Future<Registration> createRegistration({
    required String tournamentId,
    required String tournamentCategoryId,
    String? paymentProofUrl,
  }) async {
    final body = <String, dynamic>{
      'tournament_category_id': tournamentCategoryId,
      'payment_proof_url': paymentProofUrl,
    }..removeWhere((_, value) => value == null);

    final response = await client.post(
      '/api/v1/tournaments/$tournamentId/registrations',
      body: body,
    );
    return _fromJson(response.data as Map<String, dynamic>);
  }

  Future<(List<Registration>, PaginationMeta)> listMyRegistrations(
    RegistrationQuery query,
  ) async {
    final response = await client.get(
      '/api/v1/me/registrations',
      query: query.toParams(),
    );
    final list = (response.data as List<dynamic>)
        .map((json) => _fromJson(json as Map<String, dynamic>))
        .toList();
    return (list, response.meta);
  }

  Future<String> withdrawRegistration(String registrationId) async {
    final response = await client.delete(
      '/api/v1/me/registrations/$registrationId',
    );
    final data = response.data as Map<String, dynamic>;
    return data['status'] as String? ?? 'withdrawn';
  }

  Registration _fromJson(Map<String, dynamic> json) {
    return Registration(
      id: json['id'] as String? ?? '',
      tournamentCategoryId: json['tournament_category_id'] as String? ?? '',
      status: json['status'] as String? ?? '',
      paymentStatus: json['payment_status'] as String? ?? '',
    );
  }
}
