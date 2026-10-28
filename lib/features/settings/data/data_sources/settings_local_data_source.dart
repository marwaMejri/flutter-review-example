import 'package:material_ui_packages_migration/features/settings/data/models/settings_model.dart';

/// Reads and writes the settings stored on the device.
abstract interface class SettingsLocalDataSource {
  /// Throws a [FormatException] when the stored settings are not valid.
  Future<SettingsModel> readSettings();

  Future<void> writeSettings(SettingsModel settings);
}
