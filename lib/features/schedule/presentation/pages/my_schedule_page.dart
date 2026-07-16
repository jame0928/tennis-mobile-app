import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/state/view_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/ui/atoms/search_input.dart';
import '../../../../shared/ui/atoms/status_badge.dart';
import '../../../../shared/ui/molecules/empty_state_card.dart';
import '../../../../shared/ui/molecules/error_state_card.dart';
import '../../../../shared/ui/templates/list_template.dart';
import '../../domain/entities/schedule_match.dart';
import '../schedule_controller.dart';

class MySchedulePage extends StatefulWidget {
  const MySchedulePage({super.key});

  @override
  State<MySchedulePage> createState() => _MySchedulePageState();
}

class _MySchedulePageState extends State<MySchedulePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScheduleController>().loadMySchedule();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleController>(
      builder: (context, controller, _) {
        final state = controller.myState;
        final l10n = context.l10n;
        return ListTemplate(
          title: l10n.scheduleMyTitle,
          top: SearchInput(
            hintText: l10n.scheduleMySearchHint,
            onSubmitted: (value) => controller.loadMySchedule(q: value),
          ),
          body: switch (state.status) {
            ViewStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            ViewStatus.failure => Center(
              child: ErrorStateCard(
                message: state.message ?? l10n.scheduleErrorLoading,
                requestId: state.requestId,
                onRetry: controller.loadMySchedule,
              ),
            ),
            ViewStatus.empty => Center(
              child: EmptyStateCard(message: l10n.scheduleMyEmpty),
            ),
            ViewStatus.success || ViewStatus.paginating => _ScheduleList(
              items: state.data ?? const [],
            ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList({required this.items});

  final List<ScheduleMatch> items;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          child: ListTile(
            title: Text(item.roundName ?? l10n.scheduleRoundUnknown),
            subtitle: Text(item.courtName ?? l10n.scheduleCourtTbd),
            trailing: StatusBadge(label: item.status),
          ),
        );
      },
    );
  }
}
