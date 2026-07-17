import '../../../../core/config/api_paths.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/pagination_meta.dart';
import '../../domain/entities/academy.dart';
import '../query/academy_query.dart';

class AcademyRemoteDataSource {
  const AcademyRemoteDataSource(this.client);

  final ApiClient client;

  Future<(List<Academy>, PaginationMeta)> listAcademies(AcademyQuery query) async {
    final response = await client.get(
      ApiPaths.academies(),
      authenticated: false,
      query: query.toParams(),
    );

    final list = (response.data as List<dynamic>)
        .map((json) => _fromJson(json as Map<String, dynamic>))
        .toList();

    return (list, response.meta);
  }

  Future<Academy> getAcademyDetail(String academyId) async {
    final response = await client.get(
      ApiPaths.academyDetail(academyId),
      authenticated: false,
    );

    return _fromJson(response.data as Map<String, dynamic>);
  }

  Academy _fromJson(Map<String, dynamic> json) {
    return Academy(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      city: json['city'] as String?,
      country: json['country'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
    );
  }
}
