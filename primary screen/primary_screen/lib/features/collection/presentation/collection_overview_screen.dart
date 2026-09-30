import 'package:flutter/material.dart';
import 'widgets/collection_stats_card.dart';
import 'widgets/photocard_grid.dart';
import 'widgets/status_filter_bar.dart';
import 'widgets/vault_search_bar.dart';

enum CollectionStatus { owned, wishlist, incoming, trading }

class Photocard {
  final String id;
  final String idolName;
  final String groupName;
  final String albumTitle;
  final String version;
  final String imageUrl;
  final CollectionStatus status;
  final int rarityStars;
  final String notes;

  const Photocard({
    required this.id,
    required this.idolName,
    required this.groupName,
    required this.albumTitle,
    required this.version,
    required this.imageUrl,
    required this.status,
    required this.rarityStars,
    required this.notes,
  });
}

class CollectionOverviewScreen extends StatefulWidget {
  const CollectionOverviewScreen({super.key});

  @override
  State<CollectionOverviewScreen> createState() =>
      _CollectionOverviewScreenState();
}

class _CollectionOverviewScreenState extends State<CollectionOverviewScreen> {
  final List<Photocard> _allCards = const <Photocard>[
    Photocard(
      id: 'pc1',
      idolName: 'Karina',
      groupName: 'aespa',
      albumTitle: 'Armageddon',
      version: 'Superbeing Ver.',
      imageUrl: 'https://picsum.photos/300/450?random=1',
      status: CollectionStatus.owned,
      rarityStars: 5,
      notes: 'Pulls from target exclusive edition.',
    ),
    Photocard(
      id: 'pc2',
      idolName: 'Hanni',
      groupName: 'NewJeans',
      albumTitle: 'Get Up',
      version: 'Bunny Beach Bag',
      imageUrl: 'https://picsum.photos/300/450?random=2',
      status: CollectionStatus.wishlist,
      rarityStars: 4,
      notes: 'High priority wishlist.',
    ),
    Photocard(
      id: 'pc3',
      idolName: 'Wonyoung',
      groupName: 'IVE',
      albumTitle: 'IVE SWITCH',
      version: 'LOVED IVE Ver.',
      imageUrl: 'https://picsum.photos/300/450?random=3',
      status: CollectionStatus.incoming,
      rarityStars: 5,
      notes: 'Traded via Twitter.',
    ),
  ];

  bool _isLoading = false;
  String _searchQuery = '';
  CollectionStatus? _selectedStatus;

  List<Photocard> get _filteredCards {
    return _allCards.where((Photocard card) {
      final bool matchesSearch = card.idolName
              .toLowerCase()
              .contains(_searchQuery.toLowerCase()) ||
          card.groupName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          card.albumTitle.toLowerCase().contains(_searchQuery.toLowerCase());
      final bool matchesFilter =
          _selectedStatus == null || card.status == _selectedStatus;
      return matchesSearch && matchesFilter;
    }).toList();
  }

  void _handleSearchChanged(String query) {
    setState(() => _searchQuery = query);
  }

  void _handleStatusSelected(CollectionStatus? status) {
    setState(() => _selectedStatus = status);
  }

  void _handleResetFilters() {
    setState(() {
      _searchQuery = '';
      _selectedStatus = null;
    });
  }

  void _handleCardTap(Photocard card) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Selected: ${card.idolName}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('K-Vault Binder'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh',
            onPressed: () {
              setState(() => _isLoading = true);
              Future<void>.delayed(
                const Duration(milliseconds: 500),
                () => setState(() => _isLoading = false),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          VaultSearchBar(
            query: _searchQuery,
            onQueryChanged: _handleSearchChanged,
          ),
          StatusFilterBar(
            selectedStatus: _selectedStatus,
            onStatusSelected: _handleStatusSelected,
          ),
          CollectionStatsCard(cards: _allCards),
          Expanded(
            child: PhotocardGrid(
              cards: _filteredCards,
              isLoading: _isLoading,
              searchQuery: _searchQuery,
              onCardTap: _handleCardTap,
              onResetFilters: _handleResetFilters,
            ),
          ),
        ],
      ),
    );
  }
}