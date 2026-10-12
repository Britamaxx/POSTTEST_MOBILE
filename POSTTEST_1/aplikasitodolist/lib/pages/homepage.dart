import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aplikasitodolist/models/tugas.dart';
import 'package:aplikasitodolist/pages/detailtugaspage.dart';
import 'package:aplikasitodolist/providers/tugas_provider.dart';
import 'package:aplikasitodolist/theme/app_colors.dart';
import 'package:aplikasitodolist/widgets/activities.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = 'Semua';
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _bukaDetail(Tugas tugas) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailTugasPage(tugas: tugas)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tugasProvider = context.watch<TugasProvider>();
    final tugasTampil = tugasProvider.daftarTugas.where((tugas) {
      final cocokFilter = switch (_filter) {
        'Aktif' => !tugas.isDone,
        'Selesai' => tugas.isDone,
        _ => true,
      };
      final cocokPencarian =
          tugas.title.toLowerCase().contains(_query.toLowerCase()) ||
          tugas.description.toLowerCase().contains(_query.toLowerCase());
      return cocokFilter && cocokPencarian;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    padding: const EdgeInsets.all(5),
                    decoration: const BoxDecoration(
                      color: AppColors.accentSoft,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/LogoKarsa.png',
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) => const Icon(
                        Icons.spa_rounded,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Karsa',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 23,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.4,
                          ),
                        ),
                        Text(
                          'Rencanakan hari dengan tenang',
                          style: TextStyle(
                            color: AppColors.muted,
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      color: AppColors.surface,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.primary,
                      size: 22,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _ProgressCard(
                jumlahSelesai: tugasProvider.jumlahSelesai,
                jumlahTotal: tugasProvider.daftarTugas.length,
                progress: tugasProvider.progress,
              ),
              const SizedBox(height: 25),
              TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _query = value.trim()),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.surface,
                  hintText: 'Cari tugas atau catatan...',
                  hintStyle: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 13,
                  ),
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    color: AppColors.primary,
                  ),
                  suffixIcon: _query.isEmpty
                      ? null
                      : IconButton(
                          tooltip: 'Hapus pencarian',
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _query = '');
                          },
                          icon: const Icon(Icons.close_rounded),
                        ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
              const SizedBox(height: 23),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Daftar kegiatan',
                      style: TextStyle(
                        color: AppColors.text,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  Text(
                    '${tugasTampil.length} tugas',
                    style: const TextStyle(
                      color: AppColors.muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: ['Semua', 'Aktif', 'Selesai'].map((filter) {
                  final isSelected = _filter == filter;
                  return ChoiceChip(
                    label: Text(filter),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _filter = filter),
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppColors.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                    selectedColor: AppColors.primary,
                    backgroundColor: AppColors.accentSoft,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              if (tugasTampil.isEmpty)
                const _EmptyTasks()
              else
                ...tugasTampil.map(
                  (tugas) => ActivityCard(
                    title: tugas.title,
                    description: tugas.description,
                    time: tugas.time,
                    isDone: tugas.isDone,
                    onTap: () => _bukaDetail(tugas),
                    onToggle: () =>
                        context.read<TugasProvider>().ubahStatusTugas(tugas),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  final int jumlahSelesai;
  final int jumlahTotal;
  final double progress;

  const _ProgressCard({
    required this.jumlahSelesai,
    required this.jumlahTotal,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryDark.withValues(alpha: 0.2),
            blurRadius: 18,
            offset: const Offset(0, 9),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -42,
            top: -60,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'PROGRES HARI INI',
                      style: TextStyle(
                        color: Color(0xFFE8D8BC),
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const SizedBox(height: 11),
                    Text(
                      '$jumlahSelesai dari $jumlahTotal tugas',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'Sedikit demi sedikit, semua selesai.',
                      style: TextStyle(
                        color: Color(0xFFE8D8BC),
                        fontSize: 11,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 7,
                        backgroundColor: Colors.white.withValues(alpha: 0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.accent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              SizedBox(
                width: 62,
                height: 62,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CircularProgressIndicator(
                      value: progress,
                      strokeWidth: 5,
                      backgroundColor: Colors.white.withValues(alpha: 0.18),
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.accent,
                      ),
                    ),
                    Icon(
                      progress == 1
                          ? Icons.check_rounded
                          : Icons.coffee_rounded,
                      color: Colors.white,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EmptyTasks extends StatelessWidget {
  const _EmptyTasks();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        children: [
          Icon(Icons.event_available_rounded, color: AppColors.accent, size: 34),
          SizedBox(height: 10),
          Text(
            'Belum ada tugas di sini',
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Coba ubah filter atau kata pencarian.',
            style: TextStyle(color: AppColors.muted, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
