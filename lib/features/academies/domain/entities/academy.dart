class Academy {
  const Academy({
    required this.id,
    required this.name,
    this.city,
    this.country,
    this.email,
    this.phone,
    this.address,
  });

  final String id;
  final String name;
  final String? city;
  final String? country;
  final String? email;
  final String? phone;
  final String? address;
}
