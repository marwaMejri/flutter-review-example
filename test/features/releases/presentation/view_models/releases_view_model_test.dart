import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/view_models/releases_view_model.dart';

import '../../fakes/fake_release_repository.dart';

void main() {
  test('loads the releases', () async {
    final ReleasesViewModel viewModel = ReleasesViewModel(
      repository: FakeReleaseRepository(releases: <Release>[release3]),
    );

    final Future<void> loading = viewModel.load();
    expect(viewModel.isLoading, isTrue);
    await loading;

    expect(viewModel.isLoading, isFalse);
    expect(viewModel.releases, <Release>[release3]);
    expect(viewModel.error, isNull);
  });

  test('gives a message when the releases cannot be read', () async {
    final ReleasesViewModel viewModel = ReleasesViewModel(
      repository: FakeReleaseRepository(fails: true),
    );

    await viewModel.load();

    expect(viewModel.error, 'The releases cannot be read.');
    expect(viewModel.releases, isEmpty);
  });

  test('counts the releases', () async {
    final ReleasesViewModel one = ReleasesViewModel(
      repository: FakeReleaseRepository(releases: <Release>[release3]),
    );
    final ReleasesViewModel none = ReleasesViewModel(
      repository: FakeReleaseRepository(),
    );

    await one.load();
    await none.load();

    expect(one.countLabel, '1 release');
    expect(none.countLabel, '0 releases');
  });
}
