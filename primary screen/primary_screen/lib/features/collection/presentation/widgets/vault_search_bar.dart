import 'package:flutter/material.dart';

class VaultSearchBar extends StatelessWidget {
  final String query;
  final ValueChanged<String> onQueryChanged;

  const VaultSearchBar({
    super.key,
    required this.query,
    required this.onQueryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SearchBar(
        hintText: 'Search idol, group, or album...',
        leading: const Icon(Icons.search),
        onChanged: onQueryChanged,
      ),
    );
  }
}