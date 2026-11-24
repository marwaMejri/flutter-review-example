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

  /// How many releases there are, as the list shows it: `1 release`,
  /// `3 releases`.
  String get countLabel =>
      _releases.length == 1 ? '1 release' : '${_releases.length} releases';

  /// A message for the user when the releases cannot be read.
  String? get error => _error;

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
