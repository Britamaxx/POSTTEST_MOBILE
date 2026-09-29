import 'package:flutter/material.dart';
import 'package:aplikasitodolist/models/tugas.dart';
import 'package:aplikasitodolist/widgets/activities.dart';
import 'package:aplikasitodolist/widgets/categoryChip.dart';
import 'package:aplikasitodolist/pages/detailtugaspage.dart';
 
// HomePage adalah halaman utama aplikasi To-Do List "Karsa"
class HomePage extends StatefulWidget {
  const HomePage({super.key});
 
  @override
  State<HomePage> createState() => _HomePageState();
}
 
class _HomePageState extends State<HomePage> {
  // selectedCategory: menyimpan kategori mana yang sedang aktif dipilih
  String selectedCategory = 'Hari Ini';
 
  // daftar tugas hari ini
  final List<Tugas> tugasHariIni = [
    Tugas(
      title: 'Jumpa Dosen Pembimbing',
      description: 'Bimbingan skripsi dan konsultasi progres',
      time: '09.00',
      durasi: 30,
      isDone: true,
    ),
    Tugas(
      title: 'Rapat Organisasi',
      description: 'Membahas agenda kegiatan organisasi',
      time: '13.00',
      durasi: 15,
    ),
    Tugas(
      title: 'Rapat Kelompok',
      description: 'Diskusi progres tugas kelompok',
      time: '16.00',
      durasi: 15,
    ),
  ];
 
  // membuka halaman detail dengan Navigator.push
  void bukaDetail(Tugas tugas) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailTugasPage(tugas: tugas)),
    );
  }
 
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
                    // Row: logo aplikasi di samping judul dan tagline
                    Row(
                      children: [
                        // Image.asset: logo Karsa dari folder assets/images
                        Image.asset(
                          'assets/images/LogoKarsa.png',
                          width: 44,
                          height: 44,
                          fit: BoxFit.contain,
                          // errorBuilder: tampilan cadangan jika file logo tidak ditemukan
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_outlined, color: merah, size: 44),
                        ),
                        const SizedBox(width: 10),
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
                      ],
                    ),
                    // Stack: menumpuk titik merah (badge) di atas ikon notifikasi
                    Stack(
                      children: [
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
                        // Positioned: menempatkan titik badge di pojok kanan atas ikon
                        Positioned(
                          top: 8,
                          right: 10,
                          // Container: titik merah penanda notifikasi baru
                          child: Container(
                            width: 9,
                            height: 9,
                            decoration: BoxDecoration(
                              color: merah,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 1.5),
                            ),
                          ),
                        ),
                      ],
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
                    // Expanded: membagi lebar Row sama rata untuk setiap kategori
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
                    // Text: judul bagian daftar tugas
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
                      child: Text(
                        '${tugasHariIni.length} Tugas',
                        style: const TextStyle(
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
                // saat kartu di-tap, pindah ke DetailTugasPage lewat Navigator.push
                for (final t in tugasHariIni)
                  ActivityCard(
                    title: t.title,
                    description: t.description,
                    time: t.time,
                    isDone: t.isDone,
                    onTap: () => bukaDetail(t),
                  ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}