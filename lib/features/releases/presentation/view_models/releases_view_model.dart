import 'package:material_ui/material_ui.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';
import 'package:material_ui_packages_migration/features/releases/domain/repositories/release_repository.dart';

/// The state of the list of releases.
class ReleasesViewModel extends ChangeNotifier {
  ReleasesViewModel({required this._repository});

  final ReleaseRepository _repository;

  List<Release> _releases = const <Release>[];
  bool _isLoading = false;
  String? _error;

  /// The page that shows the list, so that an error can be shown on it.
  BuildContext? pageContext;

  List<Release> get releases => _releases;
  bool get isLoading => _isLoading;

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
      final BuildContext? context = pageContext;
      if (context != null && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('The releases cannot be read. Try again later.'),
          ),
        );
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
