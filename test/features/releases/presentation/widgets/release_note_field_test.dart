import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/widgets/release_note_field.dart';

void main() {
  testWidgets('gives each change of the note', (WidgetTester tester) async {
    final List<String> notes = <String>[];
    await tester.pumpWidget(
      MaterialApp(
        home: Material(child: ReleaseNoteField(onChanged: notes.add)),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Try the sync');

    expect(notes, <String>['Try the sync']);
  });
}
