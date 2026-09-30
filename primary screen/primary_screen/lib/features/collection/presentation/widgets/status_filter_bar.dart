import 'package:flutter/material.dart';
import '../collection_overview_screen.dart';

class StatusFilterBar extends StatelessWidget {
  final CollectionStatus? selectedStatus;
  final ValueChanged<CollectionStatus?> onStatusSelected;

  const StatusFilterBar({
    super.key,
    required this.selectedStatus,
    required this.onStatusSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          FilterChip(
            label: const Text('All'),
            selected: selectedStatus == null,
            onSelected: (_) => onStatusSelected(null),
          ),
          const SizedBox(width: 8.0),
          ...CollectionStatus.values.map((CollectionStatus status) {
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FilterChip(
                label: Text(status.name.toUpperCase()),
                selected: selectedStatus == status,
                onSelected: (bool selected) {
                  onStatusSelected(selected ? status : null);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}