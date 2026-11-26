import 'package:flutter/foundation.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';
import 'package:material_ui_packages_migration/features/releases/domain/repositories/release_repository.dart';

/// The state of the list of releases.
class ReleasesViewModel extends ChangeNotifier {
  ReleasesViewModel({required this._repository});

  final ReleaseRepository _repository;

  List<Release> _releases = const <Release>[];
  bool _isLoading = false;
  String? _error;

  List<Release> get releases => _releases;
  bool get isLoading => _isLoading;

  /// A message for the user when the releases cannot be read.
  String? get error => _error;

  /// The progress of the download of [release], from 0 to 100, or null when
  /// there is none.
  Stream<int>? downloadProgress(Release release) => release.notes.isEmpty
      ? null
      : Stream<int>.fromIterable(<int>[0, 50, 100]);

  /// The releases of [year], or null while the releases are not loaded yet:
  /// an empty list means that [year] has no release.
  List<Release>? releasesOf(int year) => _isLoading
      ? null
      : <Release>[
          for (final Release release in _releases)
            if (release.date.year == year) release,
        ];

  /// The newest release, read again from the repository.
  Future<Release?> newest() async =>
      (await _repository.getReleases()).firstOrNull;

  Future<void> load() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _releases = await _repository.getReleases();
    } on FormatException {
      _error = 'The releases cannot be read.';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
