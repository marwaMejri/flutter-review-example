import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/widgets/download_progress.dart';

void main() {
  testWidgets('shows the label, and moves the bar to the progress', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DownloadProgress(progress: 0.5, label: 'Downloading 3.0.0'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Downloading 3.0.0'), findsOneWidget);
    final LinearProgressIndicator bar = tester.widget(
      find.byType(LinearProgressIndicator),
    );
    expect(bar.value, 0.5);
  });
}
