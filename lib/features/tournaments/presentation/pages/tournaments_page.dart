import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../../l10n/l10n.dart';
import '../../../../core/state/view_state.dart';
import '../../../../shared/ui/atoms/search_input.dart';
import '../../../../shared/ui/atoms/status_badge.dart';
import '../../../../shared/ui/molecules/empty_state_card.dart';
import '../../../../shared/ui/molecules/error_state_card.dart';
import '../../../../shared/ui/molecules/pagination_footer.dart';
import '../../../../shared/ui/templates/list_template.dart';
import '../../domain/entities/tournament.dart';
import '../tournaments_controller.dart';

class TournamentsPage extends StatefulWidget {
  const TournamentsPage({super.key});

  @override
  State<TournamentsPage> createState() => _TournamentsPageState();
}

class _TournamentsPageState extends State<TournamentsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<TournamentsController>();
      if (controller.state.status == ViewStatus.idle) {
        controller.loadFirstPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TournamentsController>(
      builder: (context, controller, _) {
        final state = controller.state;
        final l10n = context.l10n;
        return ListTemplate(
          title: l10n.tournamentsTitle,
          top: SearchInput(
            initialValue: controller.searchQuery,
            hintText: l10n.tournamentsSearchHint,
            onSubmitted: (value) => controller.loadFirstPage(query: value),
          ),
          body: switch (state.status) {
            ViewStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            ViewStatus.failure => Center(
              child: ErrorStateCard(
                message: state.message ?? l10n.tournamentsErrorLoading,
                requestId: state.requestId,
                onRetry: controller.loadFirstPage,
              ),
            ),
            ViewStatus.empty => Center(
              child: EmptyStateCard(message: l10n.tournamentsEmpty),
            ),
            ViewStatus.success || ViewStatus.paginating => _TournamentList(
              items: state.data ?? const [],
              hasMore: controller.hasMore,
              isPaginating: state.status == ViewStatus.paginating,
              onLoadMore: controller.loadMore,
            ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}

class _TournamentList extends StatelessWidget {
  const _TournamentList({
    required this.items,
    required this.hasMore,
    required this.isPaginating,
    required this.onLoadMore,
  });

  final List<Tournament> items;
  final bool hasMore;
  final bool isPaginating;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView.builder(
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == items.length) {
          return Center(
            child: PaginationFooter(
              hasMore: hasMore,
              loading: isPaginating,
              onLoadMore: onLoadMore,
            ),
          );
        }
        final tournament = items[index];
        return Card(
          child: ListTile(
            title: Text(tournament.name),
            subtitle: Text(tournament.venue ?? l10n.tournamentsUnknownVenue),
            trailing: StatusBadge(label: tournament.status),
            onTap: () {
              Navigator.of(
                context,
              ).pushNamed(AppRouter.tournamentDetail, arguments: tournament.id);
            },
          ),
        );
      },
    );
  }
}
