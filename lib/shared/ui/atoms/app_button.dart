import 'package:flutter/material.dart';

enum AppButtonVariant { primary, secondary, danger }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case AppButtonVariant.secondary:
        return OutlinedButton(onPressed: onPressed, child: Text(label));
      case AppButtonVariant.danger:
        return FilledButton.tonal(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFFDC2626),
            foregroundColor: Colors.white,
          ),
          onPressed: onPressed,
          child: Text(label),
        );
      case AppButtonVariant.primary:
        return FilledButton(onPressed: onPressed, child: Text(label));
    }
  }
}
