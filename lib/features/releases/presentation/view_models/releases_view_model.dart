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

  /// The releases whose version ends with `.0.0`, or null when there is none.
  List<Release>? get majorReleases {
    final List<Release> majors = <Release>[
      for (final Release release in _releases)
        if (release.version.endsWith('.0.0')) release,
    ];
    return majors.isEmpty ? null : majors;
  }

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
