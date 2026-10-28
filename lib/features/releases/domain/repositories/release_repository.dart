import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';

/// Gives the releases of the app, newest first.
abstract interface class ReleaseRepository {
  Future<List<Release>> getReleases();

  /// The release with [id], or null when there is none.
  Future<Release?> getRelease(int id);
}
