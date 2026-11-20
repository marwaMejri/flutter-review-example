import 'package:material_ui_packages_migration/features/releases/data/data_sources/release_local_data_source.dart';
import 'package:material_ui_packages_migration/features/releases/data/models/release_model.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';
import 'package:material_ui_packages_migration/features/releases/domain/repositories/release_repository.dart';

class ReleaseRepositoryImpl implements ReleaseRepository {
  ReleaseRepositoryImpl({required this._dataSource});

  final ReleaseLocalDataSource _dataSource;

  /// The releases read the first time, kept for the next pages.
  late List<Release> _cachedReleases;
  bool _isCached = false;

  @override
  Future<List<Release>> getReleases() async {
    if (_isCached) {
      return _cachedReleases;
    }
    final List<ReleaseModel> models = await _dataSource.fetchReleases();
    _cachedReleases = <Release>[
      for (final ReleaseModel model in models) model.toEntity(),
    ];
    _isCached = true;
    return _cachedReleases;
  }

  @override
  Future<Release?> getRelease(int id) async {
    for (final Release release in await getReleases()) {
      if (release.id == id) {
        return release;
      }
    }
    return null;
  }
}
