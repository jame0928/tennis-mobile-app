import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/network/api_exception.dart';
import '../../../../core/network/error_mapper.dart';
import '../../../../l10n/l10n.dart';
import '../../../../shared/ui/molecules/error_state_card.dart';
import '../../../../shared/ui/templates/detail_template.dart';
import '../../domain/entities/ranking.dart';
import '../rankings_controller.dart';

class RankingDetailPage extends StatefulWidget {
  const RankingDetailPage({super.key, required this.rankingId});

  final String rankingId;

  @override
  State<RankingDetailPage> createState() => _RankingDetailPageState();
}

class _RankingDetailPageState extends State<RankingDetailPage> {
  Ranking? ranking;
  String? error;
  String? requestId;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final value = await context.read<RankingsController>().loadDetail(
            widget.rankingId,
          );
      if (!mounted) return;
      setState(() => ranking = value);
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
        appBar: AppBar(title: Text(l10n.rankingsDetailTitle)),
        body: Center(
          child: ErrorStateCard(
            message: error!,
            requestId: requestId,
            onRetry: _load,
          ),
        ),
      );
    }

    if (ranking == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return DetailTemplate(
      title: ranking!.title,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${l10n.rankingsTypeLabel}: ${ranking!.rankingType}'),
          const SizedBox(height: 8),
          Text('${l10n.rankingsCategoryLabel}: ${ranking!.category}'),
          const SizedBox(height: 12),
          Text(l10n.rankingsEntriesTitle),
          const SizedBox(height: 8),
          ...ranking!.entries.map(
            (entry) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(entry.name),
              leading: Text('#${entry.position}'),
              trailing: Text('${entry.points}'),
            ),
          ),
        ],
      ),
    );
  }
}
