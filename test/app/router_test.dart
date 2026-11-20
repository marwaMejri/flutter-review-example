import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui_packages_migration/app/app.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/views/release_detail_view.dart';
import 'package:material_ui_packages_migration/features/settings/presentation/views/settings_view.dart';

void main() {
  testWidgets('the settings open from the list', (WidgetTester tester) async {
    await tester.pumpWidget(const ReleaseNotesApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Settings'));
    await tester.pumpAndSettle();

    expect(find.byType(SettingsView), findsOneWidget);
  });

  testWidgets('a release opens from the list', (WidgetTester tester) async {
    await tester.pumpWidget(const ReleaseNotesApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Version 2.1.0'));
    await tester.pumpAndSettle();

    expect(find.byType(ReleaseDetailView), findsOneWidget);
  });
}
