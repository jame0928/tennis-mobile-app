import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/state/view_state.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/ui/atoms/app_button.dart';
import '../../../../shared/ui/atoms/search_input.dart';
import '../../../../shared/ui/atoms/status_badge.dart';
import '../../../../shared/ui/molecules/empty_state_card.dart';
import '../../../../shared/ui/molecules/error_state_card.dart';
import '../../../../shared/ui/molecules/pagination_footer.dart';
import '../../../../shared/ui/templates/list_template.dart';
import '../../domain/entities/registration.dart';
import '../registrations_controller.dart';

class RegistrationsPage extends StatefulWidget {
  const RegistrationsPage({super.key});

  @override
  State<RegistrationsPage> createState() => _RegistrationsPageState();
}

class _RegistrationsPageState extends State<RegistrationsPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RegistrationsController>().loadFirstPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegistrationsController>(
      builder: (context, controller, _) {
        final state = controller.state;
        final l10n = context.l10n;
        return ListTemplate(
          title: l10n.registrationsTitle,
          top: Column(
            children: [
              SearchInput(
                hintText: l10n.registrationsSearchHint,
                onSubmitted: (value) => controller.loadFirstPage(q: value),
              ),
              if (controller.feedbackMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(controller.feedbackMessage),
                ),
            ],
          ),
          body: switch (state.status) {
            ViewStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
            ViewStatus.failure => Center(
              child: ErrorStateCard(
                message: state.message ?? l10n.registrationsErrorLoading,
                requestId: state.requestId,
                onRetry: controller.loadFirstPage,
              ),
            ),
            ViewStatus.empty => Center(
              child: EmptyStateCard(message: l10n.registrationsEmpty),
            ),
            ViewStatus.success || ViewStatus.paginating => _RegistrationList(
              items: state.data ?? const [],
              hasMore: controller.hasMore,
              loadingMore: state.status == ViewStatus.paginating,
              onLoadMore: controller.loadMore,
              onWithdraw: (id) => _confirmWithdraw(context, id),
            ),
            _ => const SizedBox.shrink(),
          },
        );
      },
    );
  }

  Future<void> _confirmWithdraw(
    BuildContext context,
    String registrationId,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final l10n = dialogContext.l10n;
        return AlertDialog(
          title: Text(l10n.registrationsWithdrawTitle),
          content: Text(l10n.registrationsWithdrawConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.commonCancel),
            ),
            AppButton(
              label: l10n.registrationsWithdraw,
              variant: AppButtonVariant.danger,
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      await context.read<RegistrationsController>().withdraw(registrationId);
    }
  }
}

class _RegistrationList extends StatelessWidget {
  const _RegistrationList({
    required this.items,
    required this.hasMore,
    required this.loadingMore,
    required this.onLoadMore,
    required this.onWithdraw,
  });

  final List<Registration> items;
  final bool hasMore;
  final bool loadingMore;
  final VoidCallback onLoadMore;
  final void Function(String) onWithdraw;

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

        final registration = items[index];
        return Card(
          child: ListTile(
            title: Text(
              l10n.registrationsItemTitle(registration.id.substring(0, 8)),
            ),
            subtitle: Text(
              l10n.registrationsCategory(registration.tournamentCategoryId),
            ),
            trailing: Wrap(
              spacing: 8,
              children: [
                StatusBadge(label: registration.status),
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => onWithdraw(registration.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
