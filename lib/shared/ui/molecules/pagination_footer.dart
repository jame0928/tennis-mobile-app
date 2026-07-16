import 'package:flutter/material.dart';

import '../atoms/app_button.dart';

class PaginationFooter extends StatelessWidget {
  const PaginationFooter({
    super.key,
    required this.hasMore,
    required this.onLoadMore,
    this.loading = false,
  });

  final bool hasMore;
  final bool loading;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    if (!hasMore) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Text('No more items'),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: loading
          ? const CircularProgressIndicator()
          : AppButton(label: 'Load more', onPressed: onLoadMore),
    );
  }
}
