import 'package:flutter_test/flutter_test.dart';
import 'package:tennis_tournament_app/core/network/payload_policy.dart';

void main() {
  group('PayloadPolicy', () {
    test('throws when profile_id is included for private endpoint', () {
      const policy = PayloadPolicy();

      expect(
        () => policy.validatePrivatePayload(
          path: '/api/v1/me',
          body: const {'profile_id': 'abc'},
        ),
        throwsArgumentError,
      );
    });

    test('accepts payload for private endpoint without profile_id', () {
      const policy = PayloadPolicy();

      expect(
        () => policy.validatePrivatePayload(
          path: '/api/v1/me',
          body: const {'first_name': 'Ana'},
        ),
        returnsNormally,
      );
    });
  });
}
