1. VaultSearchBar
- Trigger: Readability & Reuse. Dipisah agar kode halaman utama tidak terlalu panjang dan komponen pencarian ini bisa dipakai ulang di halaman lain jika dibutuhkan.
- What it owns: UI bidang pencarian (SearchBar), ikon, teks petunjuk (placeholder), dan pemrosesan teks input.
- What it reports upward: Mengirimkan string pencarian terbaru ke parent melalui callback `onQueryChanged(String query)`.

2. StatusFilterBar
- Trigger: Readability. Dipisah untuk merapikan kode baris chip filter horizontal dari file utama.
- What it owns: Daftar pilihan status (`CollectionStatus`), komponen chip filter, dan status chip yang sedang aktif.
- What it reports upward: Mengirimkan kategori status yang dipilih user ke parent melalui callback `onStatusSelected(CollectionStatus status)`.

3. CollectionStatsCard
- Trigger: Readability. Dipisah untuk memisahkan tampilan kartu ringkasan angka statistik dari komponen utama.
- What it owns: Perhitungan ringkasan jumlah item (Total, Owned, Wishlist) dan tata letak kartu statistik.
- What it reports upward: Tidak ada. Widget ini bersifat pasif (hanya menampilkan data yang diterima dari parent).

4. PhotocardGrid
- Trigger: Readability. Dipisah agar logika penanganan layout grid, tampilan loading, dan tampilan saat data kosong tidak menumpuk di method `build` utama.
- What it owns: Layout `GridView.builder`, indikator loading (`CircularProgressIndicator`), dan tampilan pesan saat hasil pencarian/filter tidak ditemukan.
- What it reports upward: Mengirimkan data photocard yang diklik via callback `onCardTap(Photocard card)` serta event reset filter via `onResetFilters()`.