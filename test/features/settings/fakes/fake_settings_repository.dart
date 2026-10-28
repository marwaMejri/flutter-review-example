import 'package:material_ui_packages_migration/features/settings/domain/entities/app_settings.dart';
import 'package:material_ui_packages_migration/features/settings/domain/repositories/settings_repository.dart';

/// A repository that keeps the channel in memory, and remembers each save.
class FakeSettingsRepository implements SettingsRepository {
  FakeSettingsRepository({this.channel = UpdateChannel.stable});

  UpdateChannel channel;
  final List<UpdateChannel> saved = <UpdateChannel>[];

  @override
  Future<AppSettings> getSettings() async => AppSettings(channel: channel);

  @override
  Future<void> saveChannel(UpdateChannel channel) async {
    saved.add(channel);
    this.channel = channel;
  }
}
