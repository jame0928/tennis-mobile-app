class Tournament {
  const Tournament({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    this.description,
    this.venue,
  });

  final String id;
  final String name;
  final String slug;
  final String status;
  final String? description;
  final String? venue;
}
