class AcademyQuery {
  const AcademyQuery({
    this.q,
    this.city,
    this.country,
    this.limit = 10,
    this.cursor,
  });

  final String? q;
  final String? city;
  final String? country;
  final int limit;
  final String? cursor;

  Map<String, String> toParams() {
    return {
      if (q != null && q!.isNotEmpty) 'q': q!,
      if (city != null && city!.isNotEmpty) 'city': city!,
      if (country != null && country!.isNotEmpty) 'country': country!,
      'limit': '$limit',
      if (cursor != null && cursor!.isNotEmpty) 'cursor': cursor!,
    };
  }
}
