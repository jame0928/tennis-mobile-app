import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../../core/state/view_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/ui/atoms/search_input.dart';
import '../../../../shared/ui/molecules/empty_state_card.dart';
import '../../../../shared/ui/molecules/error_state_card.dart';
import '../../../../shared/ui/molecules/pagination_footer.dart';
import '../../../../shared/ui/templates/list_template.dart';
import '../../domain/entities/ranking.dart';
import '../rankings_controller.dart';

class RankingsPage extends StatefulWidget {
  const RankingsPage({super.key});

  @override
  State<RankingsPage> createState() => _RankingsPageState();
}

class _RankingsPageState extends State<RankingsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<RankingsController>();
      if (controller.state.status == ViewStatus.idle) {
        controller.loadFirstPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RankingsController>(
      builder: (context, controller, _) {
        final l10n = context.l10n;
        final state = controller.state;

        return ListTemplate(
          title: l10n.rankingsTitle,
          top: SearchInput(
            initialValue: controller.searchQuery,
            hintText: l10n.rankingsSearchHint,
            onSubmitted: (value) => controller.loadFirstPage(query: value),
          ),
          body: switch (state.status) {
            ViewStatus.loading => const Center(child: CircularProgressIndicator()),
            ViewStatus.failure => Center(
              child: ErrorStateCard(
                message: state.message ?? l10n.rankingsErrorLoading,
                requestId: state.requestId,
                onRetry: controller.loadFirstPage,
              ),
            ),
            ViewStatus.empty => Center(
              child: EmptyStateCard(message: l10n.rankingsEmpty),
            ),
            ViewStatus.success || ViewStatus.paginating => _RankingsList(
              items: state.data ?? const [],
              hasMore: controller.hasMore,
              loadingMore: state.status == ViewStatus.paginating,
              onLoadMore: controller.loadMore,
            ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }
}

class _RankingsList extends StatelessWidget {
  const _RankingsList({
    required this.items,
    required this.hasMore,
    required this.loadingMore,
    required this.onLoadMore,
  });

  final List<Ranking> items;
  final bool hasMore;
  final bool loadingMore;
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
              loading: loadingMore,
              onLoadMore: onLoadMore,
            ),
          );
        }

        final ranking = items[index];
        return Card(
          child: ListTile(
            title: Text(ranking.title),
            subtitle: Text(
              '${l10n.rankingsTypeLabel}: ${ranking.rankingType} • ${ranking.category}',
            ),
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRouter.rankingDetail,
                arguments: ranking.id,
              );
            },
          ),
        );
      },
    );
  }
}
