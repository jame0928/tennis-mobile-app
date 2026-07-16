import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.label});

  final String label;

  String get _normalized => label.toLowerCase().trim();

  Color _backgroundColor() {
    if (_normalized.contains('open') || _normalized.contains('paid')) {
      return const Color(0xFF18A999);
    }
    if (_normalized.contains('progress')) {
      return const Color(0xFF1E63D8);
    }
    if (_normalized.contains('cancel') || _normalized.contains('reject')) {
      return const Color(0xFFDC2626);
    }
    return const Color(0xFF6B7280);
  }

  String _translatedLabel(BuildContext context) {
    final l10n = context.l10n;
    switch (_normalized) {
      case 'registration_open':
        return l10n.statusRegistrationOpen;
      case 'registration_closed':
        return l10n.statusRegistrationClosed;
      case 'in_progress':
        return l10n.statusInProgress;
      case 'completed':
        return l10n.statusCompleted;
      case 'cancelled':
        return l10n.statusCancelled;
      case 'rejected':
        return l10n.statusRejected;
      case 'pending':
        return l10n.statusPending;
      case 'paid':
        return l10n.statusPaid;
      case 'refunded':
        return l10n.statusRefunded;
      case 'waived':
        return l10n.statusWaived;
      case 'active':
        return l10n.statusActive;
      case 'past':
        return l10n.statusPast;
      case 'scheduled':
        return l10n.statusScheduled;
      case 'draft_scheduled':
        return l10n.statusDraftScheduled;
      case 'walkover':
        return l10n.statusWalkover;
      case 'postponed':
        return l10n.statusPostponed;
      default:
        return label.isEmpty ? l10n.statusUnknown : label;
    }
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
        _translatedLabel(context),
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }
}
