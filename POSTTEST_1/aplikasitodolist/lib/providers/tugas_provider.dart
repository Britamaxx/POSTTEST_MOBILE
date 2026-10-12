import 'package:flutter/foundation.dart';
import 'package:aplikasitodolist/models/tugas.dart';

class TugasProvider extends ChangeNotifier {
  final List<Tugas> _daftarTugas = [
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
    Tugas(
      title: 'Kerjakan Laporan Praktikum',
      description: 'Modul 3 Pemrograman Piranti Bergerak',
      time: '18.00',
      durasi: 60,
    ),
    Tugas(
      title: 'Belajar Flutter',
      description: 'Latihan stateful widget dan Provider',
      time: '19.00',
      durasi: 45,
    ),
    Tugas(
      title: 'Kumpul Tugas Kelompok',
      description: 'Unggah berkas ke platform kuliah',
      time: '21.00',
      durasi: 10,
      isDone: true,
    ),
  ];

  List<Tugas> get daftarTugas => List.unmodifiable(_daftarTugas);

  int get jumlahSelesai => _daftarTugas.where((tugas) => tugas.isDone).length;

  int get jumlahBelumSelesai => _daftarTugas.length - jumlahSelesai;

  double get progress =>
      _daftarTugas.isEmpty ? 0 : jumlahSelesai / _daftarTugas.length;

  void tambahTugas(Tugas tugas) {
    _daftarTugas.add(tugas);
    notifyListeners();
  }

  void ubahStatusTugas(Tugas tugas) {
    tugas.isDone = !tugas.isDone;
    notifyListeners();
  }
}
