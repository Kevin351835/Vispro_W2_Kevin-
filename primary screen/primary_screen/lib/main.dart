import 'package:flutter/material.dart';
import 'features/collection/presentation/collection_overview_screen.dart';

void main() {
  runApp(const KVaultApp());
}

class KVaultApp extends StatelessWidget {
  const KVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'K-Vault',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6750A4),
        ),
      ),
      home: const CollectionOverviewScreen(),
    );
  }
}