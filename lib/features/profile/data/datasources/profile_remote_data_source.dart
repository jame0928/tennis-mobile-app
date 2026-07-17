import '../../../../core/network/api_client.dart';
import '../../../../core/config/api_paths.dart';
import '../dto/profile_dto.dart';

class ProfileRemoteDataSource {
  const ProfileRemoteDataSource(this.client);

  final ApiClient client;

  Future<ProfileDto> getProfile() async {
    final response = await client.get(ApiPaths.me());
    return ProfileDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<ProfileDto> updateProfile({
    required String firstName,
    required String lastName,
    String? displayName,
    String? phone,
    String? avatarUrl,
  }) async {
    final body = <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'display_name': displayName,
      'phone': phone,
      'avatar_url': avatarUrl,
    }..removeWhere((_, value) => value == null);

    final response = await client.patch(
      ApiPaths.me(),
      body: body,
    );
    return ProfileDto.fromJson(response.data as Map<String, dynamic>);
  }
}
