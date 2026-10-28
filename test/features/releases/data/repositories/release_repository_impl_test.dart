import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui_packages_migration/features/releases/data/data_sources/release_local_data_source_impl.dart';
import 'package:material_ui_packages_migration/features/releases/data/repositories/release_repository_impl.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';

void main() {
  const ReleaseRepositoryImpl repository = ReleaseRepositoryImpl(
    dataSource: ReleaseLocalDataSourceImpl(),
  );

  test('gives the releases newest first', () async {
    final List<Release> releases = await repository.getReleases();

    expect(releases.map((Release release) => release.version), <String>[
      '3.0.0',
      '2.1.0',
      '2.0.0',
    ]);
  });

  test('finds a release by its id', () async {
    expect((await repository.getRelease(2))?.version, '2.1.0');
    expect(await repository.getRelease(42), isNull);
  });
}
