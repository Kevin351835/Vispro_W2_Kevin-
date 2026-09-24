import 'package:flutter/material.dart';

class MenuTotalBar extends StatelessWidget {
  final int lineCount;
  final int total;
  final VoidCallback onSave;

  const MenuTotalBar({
    super.key,
    required this.lineCount,
    required this.total,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lineCount == 0
                      ? 'Belum ada pesanan'
                      : '$lineCount menu dipilih',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Rp $total',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: total == 0 ? null : onSave,
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }
}