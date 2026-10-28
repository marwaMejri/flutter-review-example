import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:material_ui_packages_migration/features/settings/domain/entities/app_settings.dart';
import 'package:material_ui_packages_migration/features/settings/domain/repositories/settings_repository.dart';

/// The state of the settings page.
class SettingsViewModel extends ChangeNotifier {
  SettingsViewModel({required this._repository});

  final SettingsRepository _repository;

  /// The chosen channel, or null until the settings are read.
  ///
  /// A [ValueListenable], because the dropdown of the page listens to one.
  final ValueNotifier<UpdateChannel?> _channel = ValueNotifier<UpdateChannel?>(
    null,
  );

  ValueListenable<UpdateChannel?> get channel => _channel;

  Future<void> load() async {
    try {
      _channel.value = (await _repository.getSettings()).channel;
    } on FormatException {
      _channel.value = null;
    }
  }

  void selectChannel(UpdateChannel? channel) {
    if (channel == null || channel == _channel.value) {
      return;
    }
    _channel.value = channel;
    unawaited(_repository.saveChannel(channel));
  }

  @override
  void dispose() {
    _channel.dispose();
    super.dispose();
  }
}
