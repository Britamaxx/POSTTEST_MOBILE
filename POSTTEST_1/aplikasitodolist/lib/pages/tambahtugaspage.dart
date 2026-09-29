import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // untuk FilteringTextInputFormatter
import 'package:aplikasitodolist/models/tugas.dart';
 
// TambahTugasPage: form untuk menambah tugas baru
class TambahTugasPage extends StatefulWidget {
  const TambahTugasPage({super.key});
 
  @override
  State<TambahTugasPage> createState() => _TambahTugasPageState();
}
 
class _TambahTugasPageState extends State<TambahTugasPage> {
  // controller: menyimpan isi setiap TextField
  final judulCtrl = TextEditingController();
  final deskripsiCtrl = TextEditingController();
  final jamCtrl = TextEditingController();
  final durasiCtrl = TextEditingController();
 
  @override
  void dispose() {
    // membebaskan controller saat halaman ditutup
    judulCtrl.dispose();
    deskripsiCtrl.dispose();
    jamCtrl.dispose();
    durasiCtrl.dispose();
    super.dispose();
  }
 
  // menyimpan tugas lalu kembali ke halaman sebelumnya sambil mengirim data
  void simpan() {
    if (judulCtrl.text.trim().isEmpty) {
      // SnackBar: pesan singkat di bagian bawah layar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul tugas wajib diisi')),
      );
      return;
    }
    Navigator.pop(
      context,
      Tugas(
        title: judulCtrl.text.trim(),
        description: deskripsiCtrl.text.trim(),
        time: jamCtrl.text.trim().isEmpty ? '-' : jamCtrl.text.trim(),
        durasi: int.tryParse(durasiCtrl.text) ?? 0,
      ),
    ); // Navigator.pop: kembali sambil membawa data Tugas
  }
 
  // membuat satu kolom input: label (Text) + TextField
  Widget buatField({
    required String label,
    required String hint,
    required TextEditingController controller,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text: label kolom input
          Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          // TextField: input dari pengguna
          TextField(
            controller: controller,
            keyboardType: keyboardType, // jenis keyboard yang muncul
            inputFormatters: inputFormatters, // aturan karakter yang boleh diketik
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    const merah = Color(0xFFD9472B);
 
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F2),
      body: SafeArea(
        // SingleChildScrollView: agar form bisa di-scroll saat keyboard muncul
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row: tombol kembali dan judul halaman
              Row(
                children: [
                  // GestureDetector: mendeteksi tap pada ikon kembali
                  GestureDetector(
                    onTap: () => Navigator.pop(context), // Navigator.pop: batal dan kembali
                    // Icon panah kembali
                    child: const Icon(Icons.arrow_back_rounded, color: merah),
                  ),
                  const SizedBox(width: 12),
                  // Text: judul halaman
                  const Text(
                    'Tambah Tugas',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: merah),
                  ),
                ],
              ),
              const SizedBox(height: 24),
 
              buatField(label: 'Judul', hint: 'Contoh: Rapat Kelompok', controller: judulCtrl),
              buatField(label: 'Deskripsi', hint: 'Keterangan singkat', controller: deskripsiCtrl),
              buatField(label: 'Jam', hint: 'Contoh: 16.00', controller: jamCtrl),
 
              // input angka: keyboard angka + hanya menerima digit 0-9
              buatField(
                label: 'Durasi pengingat (menit)',
                hint: 'Contoh: 30',
                controller: durasiCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ],
          ),
        ),
      ),
 
      // Container: bar bawah berisi tombol simpan, diberi bayangan
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            // BoxShadow: bayangan ke arah atas bar
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        // SizedBox: membuat tombol selebar bar
        child: SizedBox(
          width: double.infinity,
          // ElevatedButton: tombol simpan
          child: ElevatedButton(
            onPressed: simpan,
            style: ElevatedButton.styleFrom(
              backgroundColor: merah,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            // Text: label tombol
            child: const Text('Simpan', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}