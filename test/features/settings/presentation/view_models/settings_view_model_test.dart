import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui_packages_migration/features/settings/domain/entities/app_settings.dart';
import 'package:material_ui_packages_migration/features/settings/presentation/view_models/settings_view_model.dart';

import '../../fakes/fake_settings_repository.dart';

void main() {
  test('reads the saved channel', () async {
    final SettingsViewModel viewModel = SettingsViewModel(
      repository: FakeSettingsRepository(channel: UpdateChannel.beta),
    );
    addTearDown(viewModel.dispose);

    await viewModel.load();

    expect(viewModel.channel.value, UpdateChannel.beta);
  });

  test('saves a new channel once', () async {
    final FakeSettingsRepository repository = FakeSettingsRepository();
    final SettingsViewModel viewModel = SettingsViewModel(
      repository: repository,
    );
    addTearDown(viewModel.dispose);
    await viewModel.load();

    viewModel
      ..selectChannel(UpdateChannel.beta)
      ..selectChannel(UpdateChannel.beta);
    await Future<void>.delayed(Duration.zero);

    expect(viewModel.channel.value, UpdateChannel.beta);
    expect(repository.saved, <UpdateChannel>[UpdateChannel.beta]);
  });
}
