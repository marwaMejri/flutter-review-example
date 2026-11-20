import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui_packages_migration/app/app.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/views/releases_view.dart';
import 'package:material_ui_packages_migration/features/settings/presentation/views/settings_view.dart';

void main() {
  testWidgets('opening the settings plays a page transition', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ReleaseNotesApp());
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Settings'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.byType(ReleasesView), findsOneWidget);
    expect(find.byType(SettingsView), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.byType(SettingsView), findsOneWidget);
  });
}
