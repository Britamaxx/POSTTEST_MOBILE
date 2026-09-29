// model data satu tugas, dipakai oleh semua halaman
class Tugas {
  final String title; // judul tugas
  final String description; // deskripsi singkat
  final String time; // jam tugas
  final int durasi; // durasi pengingat dalam menit
  bool isDone; // status selesai
 
  Tugas({
    required this.title,
    required this.description,
    required this.time,
    this.durasi = 0,
    this.isDone = false,
  });
}