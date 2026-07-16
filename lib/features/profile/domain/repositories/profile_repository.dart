import '../entities/profile.dart';

abstract class ProfileRepository {
  Future<Profile> getProfile();

  Future<Profile> updateProfile({
    required String firstName,
    required String lastName,
    String? displayName,
    String? phone,
    String? avatarUrl,
  });
}
