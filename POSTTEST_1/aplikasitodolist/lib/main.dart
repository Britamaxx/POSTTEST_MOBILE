import 'package:flutter/material.dart';
import 'package:aplikasitodolist/pages/mainpage.dart';
 
void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    // MaterialApp: widget akar yang mengatur tema dan halaman awal aplikasi
    return MaterialApp(
      title: 'Karsa', // nama aplikasi
      debugShowCheckedModeBanner: false, // menonaktifkan tulisan debug di pojok kanan atas
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: const Color(0xFFFFFFFF),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD9472B)),
      ), // menentukan visual umum aplikasi
      home: const MainPage(), // halaman pertama: MainPage yang memuat Navigation Bar
    );
  }
}