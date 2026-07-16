import 'package:flutter/material.dart';

class ListTemplate extends StatelessWidget {
  const ListTemplate({
    super.key,
    required this.title,
    required this.top,
    required this.body,
  });

  final String title;
  final Widget top;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Column(
          children: [
            Padding(padding: const EdgeInsets.all(12), child: top),
            Expanded(child: body),
          ],
        ),
      ),
    );
  }
}
