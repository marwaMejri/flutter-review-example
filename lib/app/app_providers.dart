import 'package:flutter/widgets.dart';
import 'package:material_ui_packages_migration/features/releases/data/data_sources/release_local_data_source.dart';
import 'package:material_ui_packages_migration/features/releases/data/data_sources/release_local_data_source_impl.dart';
import 'package:material_ui_packages_migration/features/releases/data/repositories/release_repository_impl.dart';
import 'package:material_ui_packages_migration/features/releases/domain/repositories/release_repository.dart';
import 'package:material_ui_packages_migration/features/settings/data/data_sources/settings_local_data_source.dart';
import 'package:material_ui_packages_migration/features/settings/data/data_sources/settings_local_data_source_impl.dart';
import 'package:material_ui_packages_migration/features/settings/data/repositories/settings_repository_impl.dart';
import 'package:material_ui_packages_migration/features/settings/domain/repositories/settings_repository.dart';
import 'package:provider/provider.dart';

/// The providers of the app: they give the data sources and the
/// repositories to the widgets below.
///
/// Each one is created once for the whole app. The rest of the app only
/// knows the interfaces: a test can give fakes instead.
class AppProviders extends StatelessWidget {
  const AppProviders({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ReleaseLocalDataSource>(
          create: (BuildContext context) => const ReleaseLocalDataSourceImpl(),
        ),
        Provider<ReleaseRepository>(
          create: (BuildContext context) => ReleaseRepositoryImpl(
            dataSource: context.read<ReleaseLocalDataSource>(),
          ),
        ),
        Provider<SettingsLocalDataSource>(
          create: (BuildContext context) => SettingsLocalDataSourceImpl(),
        ),
        Provider<SettingsRepository>(
          create: (BuildContext context) => SettingsRepositoryImpl(
            dataSource: context.read<SettingsLocalDataSource>(),
          ),
        ),
      ],
      child: child,
    );
  }
}
