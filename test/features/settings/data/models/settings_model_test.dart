import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui_packages_migration/features/settings/data/models/settings_model.dart';
import 'package:material_ui_packages_migration/features/settings/domain/entities/app_settings.dart';

void main() {
  test('keeps only the channel', () {
    expect(
      SettingsModel.fromJson(const <String, Object?>{
        'update_channel': 'beta',
        'notifications_enabled': true,
      }).toEntity(),
      const AppSettings(channel: UpdateChannel.beta),
    );
  });

  test('refuses an unknown channel', () {
    expect(
      () => SettingsModel.fromJson(const <String, Object?>{
        'update_channel': 'nightly',
        'notifications_enabled': true,
      }).toEntity(),
      throwsFormatException,
    );
  });

  test('changes the channel and keeps the other fields', () {
    const SettingsModel stored = SettingsModel(
      updateChannel: 'stable',
      notificationsEnabled: false,
    );

    expect(stored.copyWith(updateChannel: 'beta').toJson(), <String, Object?>{
      'update_channel': 'beta',
      'notifications_enabled': false,
    });
  });
}
