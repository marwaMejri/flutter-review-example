import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/view_models/release_detail_view_model.dart';

import '../../fakes/fake_release_repository.dart';

void main() {
  final FakeReleaseRepository repository = FakeReleaseRepository(
    releases: <Release>[release3],
  );

  test('loads the release of the page', () async {
    final ReleaseDetailViewModel viewModel = ReleaseDetailViewModel(
      repository: repository,
      id: '3',
    );

    await viewModel.load();

    expect(viewModel.release, release3);
  });

  test('finds no release for an unknown id', () async {
    final ReleaseDetailViewModel viewModel = ReleaseDetailViewModel(
      repository: repository,
      id: '42',
    );

    await viewModel.load();

    expect(viewModel.release, isNull);
  });

  test('finds no release for an id that is not a number', () async {
    final ReleaseDetailViewModel viewModel = ReleaseDetailViewModel(
      repository: repository,
      id: 'latest',
    );

    await viewModel.load();

    expect(viewModel.release, isNull);
    expect(viewModel.isLoading, isFalse);
  });
}
