import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';
import 'package:material_ui_packages_migration/features/releases/domain/repositories/release_repository.dart';

/// A repository that returns [releases], or throws when [fails] is true.
class FakeReleaseRepository implements ReleaseRepository {
  FakeReleaseRepository({
    this.releases = const <Release>[],
    this.fails = false,
  });

  final List<Release> releases;
  final bool fails;

  @override
  Future<List<Release>> getReleases() async {
    if (fails) {
      throw const FormatException('Invalid answer.');
    }
    return releases;
  }

  @override
  Future<Release?> getRelease(int id) async {
    for (final Release release in await getReleases()) {
      if (release.id == id) {
        return release;
      }
    }
    return null;
  }
}

final Release release3 = Release(
  id: 3,
  version: '3.0.0',
  date: DateTime(2026, 10),
  summary: 'Background sync',
  notes: '## Background sync',
  downloadSizeBytes: 18400000,
  minimumOsVersion: 'Android 8, iOS 15',
);
