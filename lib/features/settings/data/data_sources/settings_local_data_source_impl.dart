import 'package:material_ui_packages_migration/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:material_ui_packages_migration/features/settings/data/models/settings_model.dart';

/// Keeps the settings in memory while the app runs.
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  Map<String, Object?> _stored = <String, Object?>{
    'update_channel': 'stable',
    'notifications_enabled': true,
  };

  @override
  Future<SettingsModel> readSettings() async => SettingsModel.fromJson(_stored);

  @override
  Future<void> writeSettings(SettingsModel settings) async {
    _stored = settings.toJson();
  }
}
