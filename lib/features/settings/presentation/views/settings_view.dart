import 'package:dropdown_button2/dropdown_button2.dart';

// Needed by dropdown_button2 3.1.0, which still uses the SDK Material
// (see MaterialUiCompatibilityBridge in lib/app/app.dart).
// Remove when a migrated version is published.
// ignore: migrate_design_widgets
import 'package:flutter/material.dart'
    as legacy
    show InputDecoration, Material, MaterialType, OutlineInputBorder;
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_ui_packages_migration/core/constants/app_constants.dart';
import 'package:material_ui_packages_migration/features/settings/domain/entities/app_settings.dart';
import 'package:material_ui_packages_migration/features/settings/presentation/view_models/settings_view_model.dart';
import 'package:provider/provider.dart';

/// The settings that the user can change.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsViewModel viewModel = context.read<SettingsViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            legacy.Material(
              type: legacy.MaterialType.transparency,
              child: DropdownButtonFormField2<UpdateChannel>(
                valueListenable: viewModel.channel,
                decoration: const legacy.InputDecoration(
                  labelText: 'Update channel',
                  border: legacy.OutlineInputBorder(),
                ),
                items: const <DropdownItem<UpdateChannel>>[
                  DropdownItem<UpdateChannel>(
                    value: UpdateChannel.stable,
                    child: Text('Stable'),
                  ),
                  DropdownItem<UpdateChannel>(
                    value: UpdateChannel.beta,
                    child: Text('Beta'),
                  ),
                ],
                onChanged: viewModel.selectChannel,
              ),
            ),
            _buildAboutSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text('About', style: theme.textTheme.titleMedium),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(appName, style: theme.textTheme.bodyLarge),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            'Version 3.0.0',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: TextButton(
            onPressed: () => context.go('/'),
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Release notes',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
