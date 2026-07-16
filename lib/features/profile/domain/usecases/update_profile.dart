import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class UpdateProfile {
  const UpdateProfile(this.repository);

  final ProfileRepository repository;

  Future<Profile> call({
    required String firstName,
    required String lastName,
    String? displayName,
    String? phone,
    String? avatarUrl,
  }) {
    return repository.updateProfile(
      firstName: firstName,
      lastName: lastName,
      displayName: displayName,
      phone: phone,
      avatarUrl: avatarUrl,
    );
  }
}
