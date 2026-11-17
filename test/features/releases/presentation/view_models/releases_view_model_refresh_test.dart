import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';
import 'package:material_ui_packages_migration/features/releases/domain/repositories/release_repository.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/view_models/releases_view_model.dart';
import 'package:mocktail/mocktail.dart';

class _MockReleaseRepository extends Mock implements ReleaseRepository {}

void main() {
  test('refresh reads the releases again', () async {
    final _MockReleaseRepository repository = _MockReleaseRepository();
    when(repository.getReleases).thenAnswer((_) async => <Release>[]);
    final ReleasesViewModel viewModel = ReleasesViewModel(
      repository: repository,
    );

    await viewModel.load();
    await viewModel.refresh();

    verify(repository.getReleases).called(2);
  });

  test('refresh does nothing while the releases are read', () async {
    final _MockReleaseRepository repository = _MockReleaseRepository();
    when(repository.getReleases).thenAnswer((_) async => <Release>[]);
    final ReleasesViewModel viewModel = ReleasesViewModel(
      repository: repository,
    );

    final Future<void> loading = viewModel.load();
    await viewModel.refresh();
    await loading;

    verify(repository.getReleases).called(1);
  });
}
