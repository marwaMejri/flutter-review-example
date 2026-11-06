import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui_packages_migration/app/app.dart';

void main() {
  testWidgets('the list says how many releases there are', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ReleaseNotesApp());
    await tester.pumpAndSettle();

    expect(find.text('3 releases'), findsOneWidget);
  });
}
