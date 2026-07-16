import 'package:flutter/material.dart';

class SkeletonBox extends StatelessWidget {
  const SkeletonBox({super.key, this.height = 16});

  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E7EB),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
