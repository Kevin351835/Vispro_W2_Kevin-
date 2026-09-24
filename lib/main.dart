import 'package:flutter/material.dart';

import 'features/menu/presentation/widgets/menu_empty_state.dart';
import 'features/menu/presentation/widgets/menu_header.dart';
import 'features/menu/presentation/widgets/menu_item_card.dart';
import 'features/menu/presentation/widgets/menu_search_field.dart';
import 'features/menu/presentation/widgets/menu_total_bar.dart';

void main() => runApp(const Lab02App());

class Lab02App extends StatelessWidget {
  const Lab02App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Warung Digital',
      theme: ThemeData(colorSchemeSeed: const Color(0xFF00696E)),
      home: const MenuScreen(),
    );
  }
}

class MenuItem {
  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    this.promo = false,
  });

  final String id;
  final String name;
  final int price;
  final bool promo;
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final List<MenuItem> _items = [
    MenuItem(id: 'm1', name: 'Nasi Goreng Spesial', price: 18000, promo: true),
    MenuItem(id: 'm2', name: 'Mie Ayam Bakso', price: 15000),
    MenuItem(id: 'm3', name: 'Sate Ayam (10 tusuk)', price: 25000),
    MenuItem(id: 'm4', name: 'Ayam Geprek Sambal Matah', price: 20000, promo: true),
    MenuItem(id: 'm5', name: 'Soto Ayam Lamongan', price: 17000),
    MenuItem(id: 'm6', name: 'Es Teh Manis', price: 5000),
    MenuItem(id: 'm7', name: 'Es Jeruk Peras', price: 8000),
    MenuItem(id: 'm8', name: 'Kopi Susu Gula Aren', price: 12000),
  ];

  final Map<String, int> _quantities = {};
  late TextEditingController _searchController;
  late ScrollController _listController;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _listController = ScrollController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _listController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    setState(() => _query = '');
  }

  @override
  Widget build(BuildContext context) {
    List<MenuItem> visible = [];
    for (MenuItem item in _items) {
      if (_query.isEmpty ||
          item.name.toLowerCase().contains(_query.toLowerCase())) {
        visible.add(item);
      }
    }

    int total = 0;
    int lineCount = 0;
    _quantities.forEach((String id, int qty) {
      if (qty > 0) {
        lineCount += 1;
        for (MenuItem item in _items) {
          if (item.id == id) {
            total += (item.price * qty);
          }
        }
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Warung Digital')),
      body: Column(
        children: [
          const MenuHeader(),
          MenuSearchField(
            controller: _searchController,
            query: _query,
            onChanged: (value) => setState(() => _query = value),
            onClear: _clearSearch,
          ),
          Expanded(
            child: visible.isEmpty
                ? MenuEmptyState(
                    query: _query,
                    onClear: _clearSearch,
                  )
                : ListView.builder(
                    controller: _listController,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: visible.length,
                    itemBuilder: (context, index) {
                      final item = visible[index];
                      final qty = _quantities[item.id] ?? 0;
                      return MenuItemCard(
                        item: item,
                        quantity: qty,
                        onIncrement: () =>
                            setState(() => _quantities[item.id] = qty + 1),
                        onDecrement: () =>
                            setState(() => _quantities[item.id] = qty - 1),
                      );
                    },
                  ),
          ),
          MenuTotalBar(
            lineCount: lineCount,
            total: total,
            onSave: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Pesanan disimpan: Rp $total'),
                ),
              );
              setState(() => _quantities.clear());
            },
          ),
        ],
      ),
    );
  }
}