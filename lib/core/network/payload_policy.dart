class PayloadPolicy {
  const PayloadPolicy();

  void validatePrivatePayload({
    required String path,
    required Map<String, dynamic> body,
  }) {
    final isPrivate =
        path.startsWith('/api/v1/me') ||
        path.startsWith('/api/v1/tournaments/') &&
            path.contains('/registrations');

    if (isPrivate && body.containsKey('profile_id')) {
      throw ArgumentError.value(
        body,
        'body',
        'profile_id is token-derived and cannot be sent by clients.',
      );
    }
  }
}
