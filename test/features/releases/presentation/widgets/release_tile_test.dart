import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/widgets/release_tile.dart';

void main() {
  testWidgets('the version is in bold', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: ReleaseTile(
            release: Release(
              id: 3,
              version: '3.0.0',
              date: DateTime(2026, 10),
              summary: 'Background sync',
              notes: '## Background sync',
            ),
            onTap: () {},
          ),
        ),
      ),
    );

    final RichText title = tester.widget<RichText>(
      find.byType(RichText).at(1),
    );
    expect(title.text.style?.fontWeight, FontWeight.bold);
  });
}
