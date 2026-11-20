import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';

/// A release as the backend returns it.
///
/// It has more fields than the app shows: [toEntity] keeps only what the
/// screens need.
class ReleaseModel {
  const ReleaseModel({
    required this.id,
    required this.version,
    required this.releasedAt,
    required this.summary,
    required this.notesMarkdown,
    required this.downloadSizeBytes,
    required this.minimumOsVersion,
  });

  /// Reads one release of the backend answer.
  ///
  /// Throws a [FormatException] when a field is missing or has another type.
  factory ReleaseModel.fromJson(Map<String, Object?> json) {
    if (json case {
      'id': final int id,
      'version': final String version,
      'released_at': final String releasedAt,
      'summary': final String summary,
      'notes_markdown': final String notesMarkdown,
      'download_size_bytes': final int downloadSizeBytes,
      'minimum_os_version': final String minimumOsVersion,
    }) {
      return ReleaseModel(
        id: id,
        version: version,
        releasedAt: releasedAt,
        summary: summary,
        notesMarkdown: notesMarkdown,
        downloadSizeBytes: downloadSizeBytes,
        minimumOsVersion: minimumOsVersion,
      );
    }
    throw FormatException('This release has a missing or wrong field.', json);
  }

  final int id;
  final String version;

  /// The release date, as `yyyy-mm-dd`.
  final String releasedAt;
  final String summary;
  final String notesMarkdown;
  final int downloadSizeBytes;
  final String minimumOsVersion;

  /// The release as the app uses it.
  ///
  /// Throws a [FormatException] when [releasedAt] is not a date.
  Release toEntity() => Release(
    id: id,
    version: version,
    date: DateTime.parse(releasedAt),
    summary: summary,
    notes: notesMarkdown,
    downloadSizeBytes: downloadSizeBytes,
    minimumOsVersion: minimumOsVersion,
  );
}
