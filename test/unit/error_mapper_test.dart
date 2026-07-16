import 'package:flutter_test/flutter_test.dart';
import 'package:tennis_tournament_app/core/network/api_exception.dart';
import 'package:tennis_tournament_app/core/network/error_mapper.dart';

void main() {
  group('ErrorMapper', () {
    test('maps UNAUTHENTICATED to unauthenticated type', () {
      final mapper = ErrorMapper();
      final failure = mapper.fromApiException(
        const ApiException(
          code: 'UNAUTHENTICATED',
          message: 'Missing token',
          requestId: 'req-1',
        ),
      );

      expect(failure.type, FailureType.unauthenticated);
      expect(failure.requestId, 'req-1');
    });

    test('maps unknown code to unknown type', () {
      final mapper = ErrorMapper();
      final failure = mapper.fromApiException(
        const ApiException(code: 'WHATEVER', message: 'Unexpected'),
      );

      expect(failure.type, FailureType.unknown);
      expect(failure.message, 'Unexpected');
    });
  });
}
