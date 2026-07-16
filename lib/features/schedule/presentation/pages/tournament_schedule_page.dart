import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/network/error_mapper.dart';
import '../../../../core/state/view_state.dart';
import '../../../../shared/ui/atoms/search_input.dart';
import '../../../../shared/ui/atoms/status_badge.dart';
import '../../../../shared/ui/molecules/empty_state_card.dart';
import '../../../../shared/ui/molecules/error_state_card.dart';
import '../../../../shared/ui/templates/list_template.dart';
import '../../domain/entities/schedule_match.dart';
import '../schedule_controller.dart';

class TournamentSchedulePage extends StatefulWidget {
  const TournamentSchedulePage({super.key, required this.tournamentId});

  final String tournamentId;

  @override
  State<TournamentSchedulePage> createState() => _TournamentSchedulePageState();
}

class _TournamentSchedulePageState extends State<TournamentSchedulePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScheduleController>().loadTournamentSchedule(
        tournamentId: widget.tournamentId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleController>(
      builder: (context, controller, _) {
        final state = controller.tournamentState;
        final mapper = context.read<ErrorMapper>();

        return ListTemplate(
          title: 'Tournament Schedule',
          top: SearchInput(
            hintText: 'Search by round/court',
            onSubmitted: (value) => controller.loadTournamentSchedule(
              tournamentId: widget.tournamentId,
              q: value,
            ),
          ),
          body: switch (state.status) {
            ViewStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            ViewStatus.failure => Center(
              child: ErrorStateCard(
                message: _messageForVisibility(state.message ?? '', mapper),
                requestId: state.requestId,
                onRetry: () => controller.loadTournamentSchedule(
                  tournamentId: widget.tournamentId,
                ),
              ),
            ),
            ViewStatus.empty => const Center(
              child: EmptyStateCard(message: 'No schedule entries found'),
            ),
            ViewStatus.success || ViewStatus.paginating =>
              _TournamentScheduleList(items: state.data ?? const []),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }

  String _messageForVisibility(String original, ErrorMapper mapper) {
    if (original.contains('access')) {
      return 'Schedule visibility is restricted for your account.';
    }
    if (original.contains('not found')) {
      return 'Tournament schedule not found.';
    }
    return original;
  }
}

class _TournamentScheduleList extends StatelessWidget {
  const _TournamentScheduleList({required this.items});

  final List<ScheduleMatch> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          child: ListTile(
            title: Text(item.roundName ?? 'Round unknown'),
            subtitle: Text(item.courtName ?? 'Court TBD'),
            trailing: StatusBadge(label: item.status),
          ),
        );
      },
    );
  }
}
