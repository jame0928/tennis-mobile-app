class Profile {
  const Profile({
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
}
