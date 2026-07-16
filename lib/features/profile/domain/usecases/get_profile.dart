import '../entities/profile.dart';
import '../repositories/profile_repository.dart';

class GetProfile {
  const GetProfile(this.repository);

  final ProfileRepository repository;

  Future<Profile> call() => repository.getProfile();
}
