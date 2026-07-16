import 'package:flutter/material.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    super.key,
    required this.onSubmitted,
    this.initialValue,
    this.hintText = 'Search',
  });

  final void Function(String) onSubmitted;
  final String? initialValue;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
