import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/view_models/releases_view_model.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/views/releases_view.dart';
import 'package:provider/provider.dart';

import '../../fakes/fake_release_repository.dart';

void main() {
  testWidgets('says when there is no release yet', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<ReleasesViewModel>(
        create: (BuildContext context) =>
            ReleasesViewModel(repository: FakeReleaseRepository())..load(),
        child: const MaterialApp(home: ReleasesView()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No release yet.'), findsOneWidget);
  });
}
