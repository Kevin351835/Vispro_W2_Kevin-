import 'package:flutter/material.dart';
import '../collection_overview_screen.dart';

class PhotocardGrid extends StatelessWidget {
  final List<Photocard> cards;
  final bool isLoading;
  final String searchQuery;
  final ValueChanged<Photocard> onCardTap;
  final VoidCallback onResetFilters;

  const PhotocardGrid({
    super.key,
    required this.cards,
    required this.isLoading,
    required this.searchQuery,
    required this.onCardTap,
    required this.onResetFilters,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (cards.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.search_off_rounded,
                size: 64,
                color: theme.colorScheme.secondary.withValues(alpha: 0.6),
              ),
              const SizedBox(height: 16.0),
              Text(
                'No Photocards Found',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                searchQuery.isEmpty
                    ? 'Your vault is currently empty.'
                    : 'No items match "$searchQuery".',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 24.0),
              FilledButton.icon(
                onPressed: onResetFilters,
                icon: const Icon(Icons.refresh),
                label: const Text('Reset Filters'),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: cards.length,
      itemBuilder: (BuildContext context, int index) {
        final Photocard card = cards[index];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () => onCardTap(card),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: theme.colorScheme.surfaceContainerHigh,
                    child: Image.network(
                      card.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Center(
                        child: Icon(
                          Icons.style_rounded,
                          size: 40,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        card.idolName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${card.groupName} • ${card.albumTitle}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}