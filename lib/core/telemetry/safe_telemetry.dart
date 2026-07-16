import 'dart:developer';

class SafeTelemetry {
  void recordApiFailure({
    required String endpoint,
    required String code,
    String? requestId,
  }) {
    log(
      'api_failure endpoint=$endpoint code=$code request_id=${requestId ?? ''}',
      name: 'safe_telemetry',
    );
  }
}
