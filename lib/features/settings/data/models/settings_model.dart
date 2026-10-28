import 'package:material_ui_packages_migration/features/settings/domain/entities/app_settings.dart';

/// The settings as the backend stores them.
///
/// It has more fields than the app shows: [toEntity] keeps only what the
/// screens need.
class SettingsModel {
  const SettingsModel({
    required this.updateChannel,
    required this.notificationsEnabled,
  });

  /// Reads the settings of the backend answer.
  ///
  /// Throws a [FormatException] when a field is missing or has another type.
  factory SettingsModel.fromJson(Map<String, Object?> json) {
    if (json case {
      'update_channel': final String updateChannel,
      'notifications_enabled': final bool notificationsEnabled,
    }) {
      return SettingsModel(
        updateChannel: updateChannel,
        notificationsEnabled: notificationsEnabled,
      );
    }
    throw FormatException('The settings have a missing or wrong field.', json);
  }

  /// `stable` or `beta`.
  final String updateChannel;
  final bool notificationsEnabled;

  Map<String, Object?> toJson() => <String, Object?>{
    'update_channel': updateChannel,
    'notifications_enabled': notificationsEnabled,
  };

  SettingsModel copyWith({String? updateChannel}) => SettingsModel(
    updateChannel: updateChannel ?? this.updateChannel,
    notificationsEnabled: notificationsEnabled,
  );

  /// The settings as the app uses them.
  ///
  /// Throws a [FormatException] when [updateChannel] is not a known channel.
  AppSettings toEntity() => AppSettings(
    channel: switch (updateChannel) {
      'stable' => UpdateChannel.stable,
      'beta' => UpdateChannel.beta,
      _ => throw FormatException('Unknown update channel.', updateChannel),
    },
  );
}
