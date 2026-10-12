import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aplikasitodolist/models/tugas.dart';
import 'package:aplikasitodolist/pages/detailtugaspage.dart';
import 'package:aplikasitodolist/pages/tambahtugaspage.dart';
import 'package:aplikasitodolist/providers/tugas_provider.dart';
import 'package:aplikasitodolist/theme/app_colors.dart';
import 'package:aplikasitodolist/widgets/activities.dart';

class TugasPage extends StatelessWidget {
  const TugasPage({super.key});

  Future<void> _tambahTugas(BuildContext context) async {
    final hasil = await Navigator.push<Tugas>(
      context,
      MaterialPageRoute(builder: (_) => const TambahTugasPage()),
    );
    if (!context.mounted || hasil == null) return;
    context.read<TugasProvider>().tambahTugas(hasil);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tugas berhasil ditambahkan')),
    );
  }

  void _bukaDetail(BuildContext context, Tugas tugas) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DetailTugasPage(tugas: tugas)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tugasProvider = context.watch<TugasProvider>();
    final daftarTugas = tugasProvider.daftarTugas;

    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _tambahTugas(context),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Tugas baru',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 22, 20, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Agenda kamu',
                    style: TextStyle(
                      color: AppColors.text,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Satu langkah kecil membuat hari lebih ringan.',
                    style: TextStyle(color: AppColors.muted, fontSize: 12),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: _SummaryTile(
                          label: 'Semua tugas',
                          value: '${daftarTugas.length}',
                          icon: Icons.event_note_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _SummaryTile(
                          label: 'Terselesaikan',
                          value: '${tugasProvider.jumlahSelesai}',
                          icon: Icons.check_circle_outline_rounded,
                          color: AppColors.green,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  const Text(
                    'Semua tugas',
                    style: TextStyle(
                      color: AppColors.text,
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: daftarTugas.isEmpty
                  ? const Center(child: Text('Belum ada tugas.'))
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 92),
                      itemCount: daftarTugas.length,
                      itemBuilder: (context, index) {
                        final tugas = daftarTugas[index];
                        return ActivityCard(
                          title: tugas.title,
                          description: tugas.description,
                          time: tugas.time,
                          isDone: tugas.isDone,
                          onTap: () => _bukaDetail(context, tugas),
                          onToggle: () => context
                              .read<TugasProvider>()
                              .ubahStatusTugas(tugas),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const _SummaryTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 19),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(
                    color: AppColors.text,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.muted,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
