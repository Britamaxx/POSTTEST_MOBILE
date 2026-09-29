import 'package:flutter/material.dart';
import 'package:aplikasitodolist/models/tugas.dart';
import 'package:aplikasitodolist/widgets/activities.dart';
import 'package:aplikasitodolist/pages/detailtugaspage.dart';
import 'package:aplikasitodolist/pages/tambahtugaspage.dart';
 
// TugasPage: menampilkan seluruh daftar tugas dan tombol untuk menambah tugas baru
class TugasPage extends StatefulWidget {
  const TugasPage({super.key});
 
  @override
  State<TugasPage> createState() => _TugasPageState();
}
 
class _TugasPageState extends State<TugasPage> {
  // daftar semua tugas
  final List<Tugas> daftarTugas = [
    Tugas(title: 'Kerjakan Laporan Praktikum', description: 'Modul 3 Pemrograman Piranti Bergerak', time: '08.00', durasi: 60),
    Tugas(title: 'Belajar Flutter', description: 'Latihan Stack dan Navigation', time: '19.00', durasi: 45),
    Tugas(title: 'Kumpul Tugas Kelompok', description: 'Unggah berkas ke platform kuliah', time: '21.00', durasi: 10, isDone: true),
  ];
 
  // membuka halaman TambahTugasPage dengan Navigator.push, lalu menunggu hasil dari Navigator.pop
  Future<void> tambahTugas() async {
    final hasil = await Navigator.push<Tugas>(
      context,
      MaterialPageRoute(builder: (context) => const TambahTugasPage()),
    );
    if (!mounted) return;
    if (hasil != null) {
      setState(() => daftarTugas.add(hasil)); // tambahkan tugas baru ke daftar
    }
  }
 
  // membuka halaman detail tugas
  void bukaDetail(Tugas tugas) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetailTugasPage(tugas: tugas)),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    const merah = Color(0xFFD9472B);
 
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      // FloatingActionButton: tombol bulat untuk menambah tugas
      floatingActionButton: FloatingActionButton(
        onPressed: tambahTugas,
        backgroundColor: merah,
        // Icon tanda tambah
        child: const Icon(Icons.add_rounded, color: Colors.white),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row: judul halaman dan badge jumlah tugas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text: judul halaman
                  const Text(
                    'Semua Tugas',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: merah),
                  ),
                  // Container: badge jumlah tugas
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    decoration: BoxDecoration(color: merah, borderRadius: BorderRadius.circular(20)),
                    // Text: jumlah tugas
                    child: Text(
                      '${daftarTugas.length} Tugas',
                      style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
 
              // Expanded: agar ListView mengisi sisa tinggi layar
              Expanded(
                // ListView.builder: daftar yang bisa di-scroll, dibuat sesuai jumlah tugas
                child: ListView.builder(
                  itemCount: daftarTugas.length,
                  itemBuilder: (context, index) {
                    final t = daftarTugas[index];
                    return ActivityCard(
                      title: t.title,
                      description: t.description,
                      time: t.time,
                      isDone: t.isDone,
                      onTap: () => bukaDetail(t),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}