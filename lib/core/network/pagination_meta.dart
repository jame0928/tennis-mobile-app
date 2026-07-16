class PaginationMeta {
  const PaginationMeta({
    required this.requestId,
    this.hasMore = false,
    this.nextCursor,
    this.limit = 10,
  });

  final String requestId;
  final bool hasMore;
  final String? nextCursor;
  final int limit;

  factory PaginationMeta.fromJson(Map<String, dynamic>? json) {
    return PaginationMeta(
      requestId: (json?['request_id'] as String?) ?? '',
      hasMore: (json?['has_more'] as bool?) ?? false,
      nextCursor: json?['next_cursor'] as String?,
      limit: (json?['limit'] as int?) ?? 10,
    );
  }
}
