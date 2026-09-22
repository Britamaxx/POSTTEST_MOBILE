import 'package:flutter/material.dart';

// class ini berfungsi sebagai kotak kategori untuk filter tugas (Hari Ini, Favorit, Selesai)
class CategoryChip extends StatelessWidget {
  // properti yang diterima dari parent widget
  final IconData icon; // ikon yang ditampilkan
  final String label; // teks label kategori
  final Color color; // warna utama kotak
  final bool isSelected; // status apakah kategori sedang dipilih atau tidak
  final VoidCallback onTap; // fungsi yang dijalankan saat kotak di-tap

  const CategoryChip({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // GestureDetector untuk mendeteksi tap/sentuhan user
    return GestureDetector(
      onTap: onTap, // panggil fungsi onTap saat kotak di-tap
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        // decoration untuk atur warna dan bentuk kotak
        decoration: BoxDecoration(
          // jika isSelected true, gunakan warna full; jika false, gunakan warna transparan
          color: isSelected ? color : color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(14),
        ),
        // susun ikon dan label secara vertikal
        child: Column(
          children: [
            Icon(icon, color: isSelected ? Colors.white : color, size: 20), // Icon: tampilkan ikon, warna putih jika dipilih, warna asli jika tidak
            const SizedBox(height: 6), 
            Text( 
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}