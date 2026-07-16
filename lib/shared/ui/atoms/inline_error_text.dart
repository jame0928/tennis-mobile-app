import 'package:flutter/material.dart';

class InlineErrorText extends StatelessWidget {
  const InlineErrorText(this.message, {super.key});

  final String? message;

  @override
  Widget build(BuildContext context) {
    if (message == null || message!.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text(
        message!,
        style: const TextStyle(color: Color(0xFFDC2626), fontSize: 12),
      ),
    );
  }
}
