import 'package:flutter/material.dart';
import '../collection_overview_screen.dart';

class CollectionStatsCard extends StatelessWidget {
  final List<Photocard> cards;

  const CollectionStatsCard({
    super.key,
    required this.cards,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final int total = cards.length;
    final int owned = cards
        .where((Photocard c) => c.status == CollectionStatus.owned)
        .length;
    final int wishlist = cards
        .where((Photocard c) => c.status == CollectionStatus.wishlist)
        .length;

    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _StatItem(label: 'Total', count: total),
          _StatItem(label: 'Owned', count: owned),
          _StatItem(label: 'Wishlist', count: wishlist),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final int count;

  const _StatItem({
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$count',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}