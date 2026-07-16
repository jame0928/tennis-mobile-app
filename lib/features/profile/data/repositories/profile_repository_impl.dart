import '../../domain/entities/profile.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  const ProfileRepositoryImpl(this.remote);

  final ProfileRemoteDataSource remote;

  @override
  Future<Profile> getProfile() async {
    final dto = await remote.getProfile();
    return dto.toEntity();
  }

  @override
  Future<Profile> updateProfile({
    required String firstName,
    required String lastName,
    String? displayName,
    String? phone,
    String? avatarUrl,
  }) async {
    final dto = await remote.updateProfile(
      firstName: firstName,
      lastName: lastName,
      displayName: displayName,
      phone: phone,
      avatarUrl: avatarUrl,
    );
    return dto.toEntity();
  }
}
