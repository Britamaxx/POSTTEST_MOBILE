import 'package:flutter_test/flutter_test.dart';
import 'package:aplikasitodolist/models/tugas.dart';
import 'package:aplikasitodolist/providers/tugas_provider.dart';

void main() {
  group('TugasProvider', () {
    late TugasProvider provider;

    setUp(() {
      provider = TugasProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    test('exposes initial task counts and progress', () {
      expect(provider.daftarTugas, hasLength(6));
      expect(provider.jumlahSelesai, 2);
      expect(provider.jumlahBelumSelesai, 4);
      expect(provider.progress, closeTo(1 / 3, 0.001));
    });

    test('updates completion state and progress', () {
      provider.ubahStatusTugas(provider.daftarTugas[1]);

      expect(provider.jumlahSelesai, 3);
      expect(provider.jumlahBelumSelesai, 3);
      expect(provider.progress, 0.5);
    });

    test('adds a task to the shared list', () {
      provider.tambahTugas(
        Tugas(
          title: 'Baca materi',
          description: 'Ulangi materi Provider',
          time: '20.00',
        ),
      );

      expect(provider.daftarTugas, hasLength(7));
      expect(provider.jumlahBelumSelesai, 5);
    });
  });
}
