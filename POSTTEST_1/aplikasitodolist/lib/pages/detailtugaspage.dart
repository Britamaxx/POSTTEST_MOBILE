import 'package:flutter/material.dart';
import 'package:aplikasitodolist/models/tugas.dart';
 
// DetailTugasPage: menampilkan rincian satu tugas
class DetailTugasPage extends StatelessWidget {
  final Tugas tugas; // data tugas yang dikirim dari halaman sebelumnya
 
  const DetailTugasPage({super.key, required this.tugas});
 
  @override
  Widget build(BuildContext context) {
    const merah = Color(0xFFD9472B);
 
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      // Stack: menumpuk banner, panel isi, dan tombol kembali pada area yang sama
      body: Stack(
        children: [
          // Positioned: banner gambar menempel di bagian atas layar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 240,
            // Container: latar banner berwarna lembut, logo ditaruh di tengah
            child: Container(
              color: merah.withOpacity(0.15),
              padding: const EdgeInsets.only(top: 40, bottom: 50),
              // Image.asset: logo Karsa dari folder assets/images
              child: Image.asset(
                'assets/images/LogoKarsa.png',
                fit: BoxFit.contain,
                // errorBuilder: tampilan cadangan jika file logo tidak ditemukan
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image_outlined, color: merah, size: 48),
              ),
            ),
          ),
 
          // Positioned: panel isi menumpuk di atas banner, mulai dari y = 210
          Positioned(
            top: 210,
            left: 0,
            right: 0,
            bottom: 0,
            // Container: panel putih dengan sudut atas membulat dan bayangan
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [
                  // BoxShadow: bayangan ke arah atas panel
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 10,
                    offset: const Offset(0, -3),
                  ),
                ],
              ),
              // SingleChildScrollView: agar isi panel bisa di-scroll
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text: judul tugas
                    Text(
                      tugas.title,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                    const SizedBox(height: 12),
 
                    // Row: ikon jam dan waktu tugas
                    Row(
                      children: [
                        // Icon jam
                        const Icon(Icons.access_time_rounded, size: 18, color: merah),
                        const SizedBox(width: 8),
                        // Text: jam tugas
                        Text(tugas.time, style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                      ],
                    ),
                    const SizedBox(height: 8),
 
                    // Row: ikon pengingat dan durasi
                    Row(
                      children: [
                        // Icon pengingat
                        const Icon(Icons.timer_outlined, size: 18, color: merah),
                        const SizedBox(width: 8),
                        // Text: durasi pengingat
                        Text('${tugas.durasi} menit', style: TextStyle(fontSize: 13, color: Colors.grey.shade700)),
                      ],
                    ),
                    const SizedBox(height: 8),
 
                    // Row: ikon status dan keterangan selesai/belum
                    Row(
                      children: [
                        // Icon status
                        Icon(
                          tugas.isDone ? Icons.check_circle_rounded : Icons.radio_button_unchecked,
                          size: 18,
                          color: tugas.isDone ? Colors.green : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        // Text: status tugas
                        Text(
                          tugas.isDone ? 'Selesai' : 'Belum selesai',
                          style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
 
                    // Text: label bagian deskripsi
                    const Text('Deskripsi', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 6),
                    // Text: isi deskripsi tugas
                    Text(
                      tugas.description,
                      style: TextStyle(fontSize: 13.5, height: 1.5, color: Colors.grey.shade700),
                    ),
                    const SizedBox(height: 28),
 
                    // SizedBox: membuat tombol selebar panel
                    SizedBox(
                      width: double.infinity,
                      // ElevatedButton: tombol kembali ke halaman sebelumnya
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context), // Navigator.pop: kembali ke halaman sebelumnya
                        style: ElevatedButton.styleFrom(
                          backgroundColor: merah,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        // Text: label tombol
                        child: const Text('Kembali', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
 
          // Positioned: tombol kembali melayang di pojok kiri atas banner
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            // GestureDetector: mendeteksi tap pada tombol
            child: GestureDetector(
              onTap: () => Navigator.pop(context), // Navigator.pop: kembali ke halaman sebelumnya
              // Container: lingkaran putih sebagai latar ikon
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                // Icon panah kembali
                child: const Icon(Icons.arrow_back_rounded, color: merah, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }
}