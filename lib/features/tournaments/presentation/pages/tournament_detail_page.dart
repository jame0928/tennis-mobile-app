import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../app/router.dart';
import '../../../../core/network/api_exception.dart';
import '../../../../core/network/error_mapper.dart';
import '../../../../l10n/l10n.dart';
import '../../../registrations/presentation/registrations_controller.dart';
import '../../../../shared/ui/atoms/app_button.dart';
import '../../../../shared/ui/atoms/status_badge.dart';
import '../../../../shared/ui/molecules/error_state_card.dart';
import '../../../../shared/ui/templates/detail_template.dart';
import '../../domain/entities/tournament.dart';
import '../tournaments_controller.dart';

class TournamentDetailPage extends StatefulWidget {
  const TournamentDetailPage({super.key, required this.tournamentId});

  final String tournamentId;

  @override
  State<TournamentDetailPage> createState() => _TournamentDetailPageState();
}

class _TournamentDetailPageState extends State<TournamentDetailPage> {
  Tournament? tournament;
  String? error;
  String? requestId;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final result = await context.read<TournamentsController>().loadDetail(
        widget.tournamentId,
      );
      if (!mounted) return;
      setState(() => tournament = result);
    } on ApiException catch (e) {
      final failure = context.read<ErrorMapper>().fromApiException(e);
      if (!mounted) return;
      setState(() {
        error = failure.message;
        requestId = failure.requestId;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    if (error != null) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.tournamentDetailTitle)),
        body: Center(
          child: ErrorStateCard(
            message: error!,
            requestId: requestId,
            onRetry: _load,
          ),
        ),
      );
    }

    if (tournament == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return DetailTemplate(
      title: tournament!.name,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StatusBadge(label: tournament!.status),
          const SizedBox(height: 12),
          Text(tournament!.description ?? l10n.tournamentNoDescription),
          const SizedBox(height: 12),
          Text(
            l10n.tournamentVenue(
              tournament!.venue ?? l10n.tournamentVenueNotSpecified,
            ),
          ),
        ],
      ),
      actions: [
        AppButton(
          label: l10n.tournamentRegisterNow,
          onPressed: _showRegistrationDialog,
        ),
        const SizedBox(height: 8),
        AppButton(
          label: l10n.tournamentViewSchedule,
          onPressed: () {
            Navigator.of(context).pushNamed(
              AppRouter.tournamentSchedule,
              arguments: tournament!.id,
            );
          },
        ),
      ],
    );
  }

  Future<void> _showRegistrationDialog() async {
    final categoryController = TextEditingController();
    final controller = context.read<RegistrationsController>();

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        final l10n = dialogContext.l10n;
        return AlertDialog(
          title: Text(l10n.tournamentCreateRegistration),
          content: TextField(
            controller: categoryController,
            decoration: InputDecoration(
              labelText: l10n.tournamentCategoryId,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(l10n.commonCancel),
            ),
            AppButton(
              label: l10n.tournamentRegister,
              onPressed: () => Navigator.of(dialogContext).pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed == true && categoryController.text.trim().isNotEmpty) {
      await controller.create(
        tournamentId: tournament!.id,
        categoryId: categoryController.text.trim(),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(controller.feedbackMessage)),
      );
    }
  }
}
