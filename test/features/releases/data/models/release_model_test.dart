import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui_packages_migration/features/releases/data/models/release_model.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';

const Map<String, Object?> answer = <String, Object?>{
  'id': 3,
  'version': '3.0.0',
  'released_at': '2026-10-01',
  'summary': 'Background sync',
  'notes_markdown': '## Background sync',
  'download_size_bytes': 18400000,
  'minimum_os_version': 'Android 8, iOS 15',
  'known_issues': <String>['Sync can stop when the battery saver is on.'],
};

void main() {
  test('keeps only what the screens need', () {
    expect(
      ReleaseModel.fromJson(answer).toEntity(),
      Release(
        id: 3,
        version: '3.0.0',
        date: DateTime(2026, 10),
        summary: 'Background sync',
        notes: '## Background sync',
        knownIssues: const <String>[
          'Sync can stop when the battery saver is on.',
        ],
      ),
    );
  });

  test('refuses a known issue that is not a text', () {
    expect(
      () => ReleaseModel.fromJson(<String, Object?>{
        ...answer,
        'known_issues': <Object?>['Sync can stop.', 42],
      }),
      throwsFormatException,
    );
  });

  test('refuses an answer with a missing field', () {
    expect(
      () => ReleaseModel.fromJson(
        Map<String, Object?>.of(answer)..remove('version'),
      ),
      throwsFormatException,
    );
  });

  test('refuses a release date that is not a date', () {
    expect(
      () => ReleaseModel.fromJson(<String, Object?>{
        ...answer,
        'released_at': 'soon',
      }).toEntity(),
      throwsFormatException,
    );
  });
}
