import '../../domain/entities/profile.dart';

class ProfileDto {
  const ProfileDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    this.displayName,
    this.email,
    this.phone,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String? displayName;
  final String? email;
  final String? phone;

  factory ProfileDto.fromJson(Map<String, dynamic> json) {
    return ProfileDto(
      id: json['id'] as String? ?? '',
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      displayName: json['display_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Profile toEntity() {
    return Profile(
      id: id,
      firstName: firstName,
      lastName: lastName,
      displayName: displayName,
      email: email,
      phone: phone,
    );
  }
}
