import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label});

  final String label;

  Color _backgroundColor() {
    if (label.contains('open') || label.contains('paid')) {
      return const Color(0xFF18A999);
    }
    if (label.contains('progress')) {
      return const Color(0xFF1E63D8);
    }
    if (label.contains('cancel') || label.contains('reject')) {
      return const Color(0xFFDC2626);
    }
    return const Color(0xFF6B7280);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _backgroundColor(),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
