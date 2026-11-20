import 'package:flutter/foundation.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';
import 'package:material_ui_packages_migration/features/releases/domain/repositories/release_repository.dart';

/// The state of the page of one release.
class ReleaseDetailViewModel extends ChangeNotifier {
  ReleaseDetailViewModel({required this._repository, required this.id});

  final ReleaseRepository _repository;

  /// The id from the address of the page. It may not be a number.
  final String id;

  Release? _release;
  bool _isLoading = false;
  final ValueNotifier<int> _matchCount = ValueNotifier<int>(0);

  /// The release, or null while it loads or when there is none with [id].
  Release? get release => _release;
  bool get isLoading => _isLoading;

  /// How many times the searched word appears in the notes.
  ValueListenable<int> get matchCount => _matchCount;

  Future<void> load() async {
    final int? number = int.tryParse(id);
    if (number == null) {
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      _release = await _repository.getRelease(number);
    } on FormatException {
      _release = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Counts how many times [query] appears in the notes, ignoring the case.
  void search(String query) {
    final String? notes = _release?.notes.toLowerCase();
    final String word = query.trim().toLowerCase();
    if (notes == null || word.isEmpty) {
      _matchCount.value = 0;
      return;
    }
    int count = 0;
    int start = notes.indexOf(word);
    while (start != -1) {
      count++;
      start = notes.indexOf(word, start + word.length);
    }
    _matchCount.value = count;
  }

  @override
  void dispose() {
    _matchCount.dispose();
    super.dispose();
  }
}
