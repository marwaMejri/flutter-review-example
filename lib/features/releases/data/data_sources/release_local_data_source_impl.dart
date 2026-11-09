import 'package:material_ui_packages_migration/features/releases/data/data_sources/release_local_data_source.dart';
import 'package:material_ui_packages_migration/features/releases/data/models/release_model.dart';

/// The answer of the backend, as decoded from its JSON.
const List<Map<String, Object?>> _releasesAnswer = <Map<String, Object?>>[
  <String, Object?>{
    'id': 3,
    'version': '3.0.0',
    'released_at': '2026-10-01',
    'summary': 'Background sync',
    'notes_markdown': r'''
## Background sync

Notely now saves your notes to the cloud while you write.
You no longer need to press **Save**.

To sync from your own code, call `sync()`:

```dart
final SyncResult result = await notes.sync();
print('${result.count} notes synced');
```

Also in this version:

- The app opens twice as fast.
- Your notes stay readable offline.
''',
    'download_size_bytes': 18400000,
    'minimum_os_version': 'Android 8, iOS 15',
    'known_issues': <String>[
      'Sync can stop when the battery saver is on.',
      'A note edited on two devices at once keeps only the last version.',
      'The first sync of a large folder can take several minutes.',
      'Images larger than 20 MB are not synced.',
      'The sync icon can stay grey after the connection comes back.',
      'Notes in a shared folder sync only when the owner is online.',
      'A deleted note can come back after a sync from an old device.',
      'The search does not find words in synced attachments yet.',
      'Sync uses mobile data even when "Wi-Fi only" is on, on Android 8.',
      'Moving a note to another folder during a sync can duplicate it.',
      'The app can ask to sign in again after an update.',
      'Dark mode is not applied to the sync settings page.',
      'Very long note titles are cut in the sync history.',
      'Exported PDF files do not keep the code blocks colors.',
      'The widget on the home screen shows the old count until the app opens.',
    ],
  },
  <String, Object?>{
    'id': 2,
    'version': '2.1.0',
    'released_at': '2026-07-15',
    'summary': 'Search fix',
    'notes_markdown': '''
## Search fix

The search field no longer loses focus when you type `#` to look for a tag.
''',
    'download_size_bytes': 17900000,
    'minimum_os_version': 'Android 8, iOS 15',
    'known_issues': <String>[],
  },
  <String, Object?>{
    'id': 1,
    'version': '2.0.0',
    'released_at': '2026-05-02',
    'summary': 'First public release',
    'notes_markdown': '''
## First public release

Write notes, sort them into folders, and search them.
''',
    'download_size_bytes': 17200000,
    'minimum_os_version': 'Android 7, iOS 14',
    'known_issues': <String>['Search ignores the accents of a word.'],
  },
];

class ReleaseLocalDataSourceImpl implements ReleaseLocalDataSource {
  const ReleaseLocalDataSourceImpl();

  @override
  Future<List<ReleaseModel>> fetchReleases() async => <ReleaseModel>[
    for (final Map<String, Object?> json in _releasesAnswer)
      ReleaseModel.fromJson(json),
  ];
}
