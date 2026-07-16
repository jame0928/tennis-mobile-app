import 'package:flutter/material.dart';

import '../atoms/app_button.dart';

class ErrorStateCard extends StatelessWidget {
  const ErrorStateCard({
    super.key,
    required this.message,
    this.requestId,
    required this.onRetry,
  });

  final String message;
  final String? requestId;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(message, textAlign: TextAlign.center),
            if (requestId != null && requestId!.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'request_id: $requestId',
                style: const TextStyle(fontSize: 12),
              ),
            ],
            const SizedBox(height: 12),
            AppButton(label: 'Retry', onPressed: onRetry),
          ],
        ),
      ),
    );
  }
}
