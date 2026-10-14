import 'package:flutter/material.dart';

/// Search field reusable. onChanged diteruskan ke provider oleh parent.
class SearchBarField extends StatelessWidget {
  const SearchBarField({
    super.key,
    required this.controller,
    required this.onChanged,
    this.onClear,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      hintText: 'Cari anime... (dummy)',
      leading: const Icon(Icons.search_rounded),
      trailing: [
        if (controller.text.isNotEmpty)
          IconButton(
            icon: const Icon(Icons.clear_rounded),
            onPressed: onClear,
          ),
      ],
      onChanged: onChanged,
    );
  }
}
