import 'package:flutter/material.dart';

class DetailTemplate extends StatelessWidget {
  const DetailTemplate({
    super.key,
    required this.title,
    required this.content,
    this.actions,
  });

  final String title;
  final Widget content;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: content),
              ...?actions,
            ],
          ),
        ),
      ),
    );
  }
}
