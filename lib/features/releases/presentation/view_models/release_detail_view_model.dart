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
  List<String>? _headings;

  /// The release, or null while it loads or when there is none with [id].
  Release? get release => _release;
  bool get isLoading => _isLoading;

  /// The headings of the notes, in order, or null when the notes have none.
  List<String>? get headings => _headings;

  Future<void> load() async {
    final int? number = int.tryParse(id);
    if (number == null) {
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      _release = await _repository.getRelease(number);
      _headings = _headingsOf(_release?.notes);
    } on FormatException {
      _release = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  static List<String>? _headingsOf(String? notes) {
    if (notes == null) {
      return null;
    }
    final List<String> headings = <String>[
      for (final String line in notes.split('\n'))
        if (line.startsWith('## ')) line.substring(3).trim(),
    ];
    return headings.isEmpty ? null : headings;
  }
}
