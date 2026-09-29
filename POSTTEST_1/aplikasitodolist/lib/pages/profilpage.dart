import 'package:flutter/material.dart';
 
// ProfilPage: halaman profil pengguna
class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});
 
  // membuat satu kotak statistik (angka + label)
  Widget kotakStatistik(String angka, String label) {
    // Container: kotak putih dengan bayangan
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          // BoxShadow: bayangan halus di sekitar kotak
          BoxShadow(color: Colors.grey.shade300, blurRadius: 10, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        children: [
          // Text: angka statistik
          Text(angka, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFFD9472B))),
          const SizedBox(height: 2),
          // Text: label statistik
          Text(label, style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
        ],
      ),
    );
  }
 
  // membuat satu baris menu (ikon + teks)
  Widget barisMenu(IconData icon, String teks) {
    // Container: baris menu berlatar putih
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          // Icon menu
          Icon(icon, color: const Color(0xFFD9472B), size: 20),
          const SizedBox(width: 12),
          // Expanded: teks mengisi sisa ruang
          Expanded(child: Text(teks, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500))),
          // Icon panah kanan
          Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400),
        ],
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    const merah = Color(0xFFD9472B);
    const emas = Color(0xFFFFB800);
 
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      // SingleChildScrollView: agar halaman bisa di-scroll
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Stack: menumpuk foto profil di atas banner
            Stack(
              clipBehavior: Clip.none, // agar foto boleh keluar dari batas banner
              children: [
                // Container: banner gradien di bagian atas
                Container(
                  height: 150,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [merah, emas]),
                  ),
                ),
                // Positioned: foto profil di tengah, separuh keluar dari banner
                Positioned(
                  bottom: -45,
                  left: 0,
                  right: 0,
                  // Center: menempatkan foto di tengah horizontal
                  child: Center(
                    // Container: bingkai lingkaran dengan bayangan
                    child: Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          // BoxShadow: bayangan di sekitar foto
                          BoxShadow(color: Colors.grey.shade400, blurRadius: 10, offset: const Offset(0, 3)),
                        ],
                      ),
                      // ClipOval: memotong gambar menjadi lingkaran
                      child: ClipOval(
                        // Image.asset: logo Karsa sebagai foto profil sementara
                        child: Image.asset(
                          'assets/images/LogoKarsa.png',
                          width: 90,
                          height: 90,
                          fit: BoxFit.contain,
                          // errorBuilder: tampilan cadangan jika file gambar belum ada
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: merah.withOpacity(0.15),
                            child: const Icon(Icons.person_rounded, color: merah, size: 44),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 56), // ruang untuk bagian foto yang keluar dari banner
 
            // Text: nama pengguna
            const Text('Nama Pengguna', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            // Text: keterangan program studi
            Text('Informatika, Universitas Mulawarman', style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600)),
            const SizedBox(height: 20),
 
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Row: tiga kotak statistik
                  Row(
                    children: [
                      Expanded(child: kotakStatistik('6', 'Total Tugas')),
                      const SizedBox(width: 10),
                      Expanded(child: kotakStatistik('2', 'Selesai')),
                      const SizedBox(width: 10),
                      Expanded(child: kotakStatistik('4', 'Tertunda')),
                    ],
                  ),
                  const SizedBox(height: 20),
                  barisMenu(Icons.notifications_none_rounded, 'Notifikasi'),
                  barisMenu(Icons.palette_outlined, 'Tampilan'),
                  barisMenu(Icons.info_outline_rounded, 'Tentang Aplikasi'),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}