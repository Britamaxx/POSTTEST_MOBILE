import 'package:flutter/material.dart';
import 'package:aplikasitodolist/pages/homepage.dart';
import 'package:aplikasitodolist/pages/tugaspage.dart';
import 'package:aplikasitodolist/pages/profilpage.dart';
 
// MainPage: kerangka utama yang menampung Navigation Bar dan memilih halaman yang tampil
class MainPage extends StatefulWidget {
  const MainPage({super.key});
 
  @override
  State<MainPage> createState() => _MainPageState();
}
 
class _MainPageState extends State<MainPage> {
  // currentIndex: menyimpan tab yang sedang aktif (0 = Beranda, 1 = Tugas, 2 = Profil)
  int currentIndex = 0;
 
  // daftar halaman sesuai urutan item pada Navigation Bar
  final List<Widget> halaman = const [HomePage(), TugasPage(), ProfilPage()];
 
  @override
  Widget build(BuildContext context) {
    const merah = Color(0xFFD9472B);
 
    // Scaffold: kerangka halaman (body + bottom navigation)
    return Scaffold(
      // IndexedStack: menampilkan satu halaman sesuai index, halaman lain tetap tersimpan state-nya
      body: IndexedStack(index: currentIndex, children: halaman),
 
      // Container: pembungkus Navigation Bar agar bisa diberi bayangan
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            // BoxShadow: bayangan di sisi atas Navigation Bar
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        // BottomNavigationBar: navigasi utama di bagian bawah halaman
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index), // ganti tab saat di-tap
          selectedItemColor: merah,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0, // bayangan sudah diatur lewat BoxShadow
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Beranda'),
            BottomNavigationBarItem(icon: Icon(Icons.checklist_rounded), label: 'Tugas'),
            BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}