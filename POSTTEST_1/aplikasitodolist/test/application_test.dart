import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aplikasitodolist/main.dart';

void main() {
  testWidgets('new task is shared with the profile summary', (tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    expect(find.text('2 dari 6 tugas'), findsOneWidget);

    await tester.tap(find.text('Tugas'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Tugas baru'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.byType(TextField).first,
      'Baca materi Provider',
    );
    await tester.tap(find.text('Simpan'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Profil'));
    await tester.pumpAndSettle();

    expect(find.text('7'), findsOneWidget);
  });
}
