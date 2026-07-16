import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/state/view_state.dart';
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
        return ListTemplate(
          title: 'My Schedule',
          top: SearchInput(
            hintText: 'Search by court, round, score',
            onSubmitted: (value) => controller.loadMySchedule(q: value),
          ),
          body: switch (state.status) {
            ViewStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            ViewStatus.failure => Center(
              child: ErrorStateCard(
                message: state.message ?? 'Unable to load schedule',
                requestId: state.requestId,
                onRetry: controller.loadMySchedule,
              ),
            ),
            ViewStatus.empty => const Center(
              child: EmptyStateCard(message: 'No scheduled matches'),
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
