import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/widgets/release_highlights.dart';

void main() {
  testWidgets('shows the count, the highlights and the tags', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(
          child: ReleaseHighlights(
            loadCount: () async => 3,
            tags: const <String>['sync', 'search'],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('3 releases'), findsOneWidget);
    expect(find.text('Offline notes'), findsOneWidget);
    expect(find.text('sync, search'), findsOneWidget);
  });

  testWidgets('shows no tag line when there is none', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Material(child: ReleaseHighlights(loadCount: () async => 1)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('1 releases'), findsOneWidget);
    expect(find.textContaining(','), findsNothing);
  });
}
