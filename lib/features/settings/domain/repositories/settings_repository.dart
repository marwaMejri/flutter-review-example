import 'package:material_ui_packages_migration/features/settings/domain/entities/app_settings.dart';

/// Reads and saves the settings of the user.
abstract interface class SettingsRepository {
  Future<AppSettings> getSettings();

  Future<void> saveChannel(UpdateChannel channel);

  /// Calls [listener] each time a channel is saved.
  void addChannelListener(void Function(UpdateChannel channel) listener);
}
