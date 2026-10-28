import 'package:material_ui_packages_migration/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:material_ui_packages_migration/features/settings/data/models/settings_model.dart';
import 'package:material_ui_packages_migration/features/settings/domain/entities/app_settings.dart';
import 'package:material_ui_packages_migration/features/settings/domain/repositories/settings_repository.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  const SettingsRepositoryImpl({required this._dataSource});

  final SettingsLocalDataSource _dataSource;

  @override
  Future<AppSettings> getSettings() async =>
      (await _dataSource.readSettings()).toEntity();

  @override
  Future<void> saveChannel(UpdateChannel channel) async {
    final SettingsModel stored = await _dataSource.readSettings();
    await _dataSource.writeSettings(
      stored.copyWith(updateChannel: channel.name),
    );
  }
}
