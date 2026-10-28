import 'package:material_ui_packages_migration/features/releases/data/models/release_model.dart';

/// Reads the releases from the backend answer stored in the app.
abstract interface class ReleaseLocalDataSource {
  /// Throws a [FormatException] when the answer is not valid.
  Future<List<ReleaseModel>> fetchReleases();
}
