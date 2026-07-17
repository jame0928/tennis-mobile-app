import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/network/error_mapper.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/ui/molecules/error_state_card.dart';
import '../../../../shared/ui/templates/detail_template.dart';
import '../../domain/entities/academy.dart';
import '../academies_controller.dart';

class AcademyDetailPage extends StatefulWidget {
  const AcademyDetailPage({super.key, required this.academyId});

  final String academyId;

  @override
  State<AcademyDetailPage> createState() => _AcademyDetailPageState();
}

class _AcademyDetailPageState extends State<AcademyDetailPage> {
  Academy? academy;
  String? error;
  String? requestId;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final value = await context.read<AcademiesController>().loadDetail(
            widget.academyId,
          );
      if (!mounted) return;
      setState(() => academy = value);
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
        appBar: AppBar(title: Text(l10n.academiesDetailTitle)),
        body: Center(
          child: ErrorStateCard(
            message: error!,
            requestId: requestId,
            onRetry: _load,
          ),
        ),
      );
    }

    if (academy == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return DetailTemplate(
      title: academy!.name,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (academy!.city != null || academy!.country != null)
            Text(
              '${academy!.city ?? ''} ${academy!.country ?? ''}'.trim(),
            ),
          const SizedBox(height: 12),
          if (academy!.email != null)
            Text('${l10n.academiesEmailLabel}: ${academy!.email}'),
          if (academy!.phone != null)
            Text('${l10n.academiesPhoneLabel}: ${academy!.phone}'),
          if (academy!.address != null)
            Text('${l10n.academiesAddressLabel}: ${academy!.address}'),
        ],
      ),
    );
  }
}
