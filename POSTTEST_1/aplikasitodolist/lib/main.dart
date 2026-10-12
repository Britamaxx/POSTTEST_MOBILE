import 'package:flutter/material.dart';
import 'package:aplikasitodolist/pages/mainpage.dart';
import 'package:aplikasitodolist/providers/tugas_provider.dart';
import 'package:aplikasitodolist/theme/app_colors.dart';
import 'package:provider/provider.dart';
 
void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({super.key});
 
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TugasProvider(),
      child: MaterialApp(
        title: 'Karsa',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Inter',
          scaffoldBackgroundColor: AppColors.background,
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            surface: AppColors.surface,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.background,
            foregroundColor: AppColors.text,
            elevation: 0,
          ),
        ),
        home: const MainPage(),
      ),
    );
  }
}