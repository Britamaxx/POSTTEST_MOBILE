import 'package:flutter/material.dart';
import 'package:aplikasitodolist/widgets/activities.dart';
import 'package:aplikasitodolist/widgets/categoryChip.dart';

// HomePage adalah halaman utama aplikasi To-Do List "Karsa"
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // selectedCategory: menyimpan kategori mana yang sedang aktif dipilih
  String selectedCategory = 'Hari Ini';

  @override
  Widget build(BuildContext context) {
    const merah = Color(0xFFD9472B);
    const emas = Color(0xFFFFB800);

    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      body: SafeArea( // memastikan konten tidak tertutup area perangkat (notch, status bar)
        child: SingleChildScrollView( // agar seluruh halaman bisa di-scroll
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16), // Padding: jarak di sekeliling konten
            child: Column(
              // Column untuk menyusun semua widget secara vertikal
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Row untuk menyusun judul aplikasi dan ikon notifikasi secara horizontal
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text: judul aplikasi Karsa
                        const Text(
                          'Karsa',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: merah,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        // Text: tagline aplikasi
                        Text(
                          'Your Reminder',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                    // Container untuk lingkaran warna sebagai latar ikon notifikasi
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: emas.withOpacity(0.15),
                        shape: BoxShape.circle,
                      ),
                      // Icon notifikasi
                      child: const Icon(Icons.notifications_none_rounded, color: emas, size: 22),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Container untuk divider tema dekoratif Nusantara
                Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [merah, emas],
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 18),

                // TextField: input untuk mencari tugas
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Cari tugas',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 12, right: 8),
                      // Icon kaca pembesar untuk pencarian
                      child: Icon(Icons.search_rounded, color: merah, size: 20),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
                const SizedBox(height: 20),

                // Row untuk kotak-kotak kategori tugas (Hari Ini, Favorit, Selesai)
                Row(
                  children: [
                    Expanded(
                      child: CategoryChip(
                        icon: Icons.today_rounded,
                        label: 'Hari Ini',
                        color: merah,
                        isSelected: selectedCategory == 'Hari Ini',
                        onTap: () => setState(() => selectedCategory = 'Hari Ini'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CategoryChip(
                        icon: Icons.star_rounded,
                        label: 'Favorit',
                        color: emas,
                        isSelected: selectedCategory == 'Favorit',
                        onTap: () => setState(() => selectedCategory = 'Favorit'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CategoryChip(
                        icon: Icons.check_circle_rounded,
                        label: 'Selesai',
                        color: Colors.green,
                        isSelected: selectedCategory == 'Selesai',
                        onTap: () => setState(() => selectedCategory = 'Selesai'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Row untuk judul daftar tugas dan badge jumlah tugas
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tugas Hari Ini',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    // Container untuk badge kecil berwarna untuk jumlah tugas
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: merah,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      // Text: jumlah tugas hari ini
                      child: const Text(
                        '3 Tugas',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Daftar tugas, tiap tugas ditampilkan lewat ActivityCard (activities.dart)
                const ActivityCard(
                  title: 'Jumpa Dosen Pembimbing',
                  description: 'Bimbingan skripsi dan konsultasi progres',
                  time: '09.00',
                  isDone: true,
                ),
                const SizedBox(height: 10),
                const ActivityCard(
                  title: 'Rapat Organisasi',
                  description: 'Membahas agenda kegiatan organisasi',
                  time: '13.00',
                  isDone: false,
                ),
                const SizedBox(height: 10),
                const ActivityCard(
                  title: 'Rapat Kelompok',
                  description: 'Diskusi progres tugas kelompok',
                  time: '16.00',
                  isDone: false,
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),

      // BottomNavigationBar untuk navigasi utama di bagian bawah halaman
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: merah,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 8,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.checklist_rounded), label: 'Tugas'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profil'),
        ],
      ),
    );
  }
}