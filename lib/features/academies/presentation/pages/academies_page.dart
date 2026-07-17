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
import '../../domain/entities/academy.dart';
import '../academies_controller.dart';

class AcademiesPage extends StatefulWidget {
  const AcademiesPage({super.key});

  @override
  State<AcademiesPage> createState() => _AcademiesPageState();
}

class _AcademiesPageState extends State<AcademiesPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final controller = context.read<AcademiesController>();
      if (controller.state.status == ViewStatus.idle) {
        controller.loadFirstPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AcademiesController>(
      builder: (context, controller, _) {
        final l10n = context.l10n;
        final state = controller.state;

        return ListTemplate(
          title: l10n.academiesTitle,
          top: SearchInput(
            initialValue: controller.searchQuery,
            hintText: l10n.academiesSearchHint,
            onSubmitted: (value) => controller.loadFirstPage(query: value),
          ),
          body: switch (state.status) {
            ViewStatus.loading => const Center(child: CircularProgressIndicator()),
            ViewStatus.failure => Center(
              child: ErrorStateCard(
                message: state.message ?? l10n.academiesErrorLoading,
                requestId: state.requestId,
                onRetry: controller.loadFirstPage,
              ),
            ),
            ViewStatus.empty => Center(
              child: EmptyStateCard(message: l10n.academiesEmpty),
            ),
            ViewStatus.success || ViewStatus.paginating => _AcademiesList(
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

class _AcademiesList extends StatelessWidget {
  const _AcademiesList({
    required this.items,
    required this.hasMore,
    required this.loadingMore,
    required this.onLoadMore,
  });

  final List<Academy> items;
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

        final academy = items[index];
        final location = [academy.city, academy.country]
            .whereType<String>()
            .where((v) => v.isNotEmpty)
            .join(', ');
        return Card(
          child: ListTile(
            title: Text(academy.name),
            subtitle: Text(location.isEmpty ? l10n.academiesUnknownLocation : location),
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRouter.academyDetail,
                arguments: academy.id,
              );
            },
          ),
        );
      },
    );
  }
}
