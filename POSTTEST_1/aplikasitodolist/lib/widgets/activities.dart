import 'package:flutter/material.dart';
 
class ActivityCard extends StatelessWidget { // widget untuk menampilkan satu tugas dalam daftar to-do
  final String title;
  final String description;
  final String time;
  final bool isDone;
  final VoidCallback? onTap; // fungsi saat kartu di-tap (untuk pindah ke halaman detail)
 
  const ActivityCard({
    super.key,
    required this.title,
    required this.description,
    required this.time,
    required this.isDone,
    this.onTap,
  });
 
  @override
  Widget build(BuildContext context) {
    const sekunder = Color(0xFFF3ECE3);
    const aksen = Color(0xFFD9472B);
 
    // GestureDetector: mendeteksi tap pada seluruh kartu
    return GestureDetector(
      onTap: onTap,
      child: Container( // membungkus satu baris tugas dengan latar warna sekunder
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: sekunder,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row( // menyusun checkbox, judul/deskripsi, dan waktu secara horizontal
          children: [
            Container( // container untuk checkbox bulat, terisi warna aksen saat tugas selesai
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDone ? aksen : Colors.transparent,
                border: Border.all(color: aksen, width: 1.8),
              ),
              // Icon tanda centang, hanya muncul saat tugas selesai
              child: isDone
                  ? const Icon(Icons.check_rounded, size: 14, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 12), // SizedBox: jarak horizontal antar widget
 
            Expanded( // agar judul dan deskripsi mengisi sisa ruang yang tersedia
              child: Column( // menyusun judul dan deskripsi secara vertikal
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text: judul tugas
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: isDone ? Colors.grey.shade500 : Colors.black87,
                      decoration: isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  const SizedBox(height: 2),
                  // Text: deskripsi singkat tugas
                  Text(
                    description,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
 
            // Text: menampilkan jam tugas, warna netral agar tidak bersaing dengan aksen
            Text(
              time,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}