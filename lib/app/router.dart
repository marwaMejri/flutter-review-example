import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui_packages_migration/features/releases/domain/repositories/release_repository.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/view_models/release_detail_view_model.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/view_models/releases_view_model.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/views/release_detail_view.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/views/releases_view.dart';
import 'package:material_ui_packages_migration/features/settings/domain/repositories/settings_repository.dart';
import 'package:material_ui_packages_migration/features/settings/presentation/view_models/settings_view_model.dart';
import 'package:material_ui_packages_migration/features/settings/presentation/views/settings_view.dart';
import 'package:provider/provider.dart';

/// The routes of the app. Each route creates the view model of its view:
/// `ChangeNotifierProvider` disposes it when the route is closed.
GoRouter createRouter() {
  return GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) =>
            ChangeNotifierProvider<ReleasesViewModel>(
              create: (BuildContext context) => ReleasesViewModel(
                repository: context.read<ReleaseRepository>(),
              )..load(),
              child: const ReleasesView(),
            ),
        routes: <RouteBase>[
          GoRoute(
            path: 'releases/:id',
            builder: (BuildContext context, GoRouterState state) =>
                ChangeNotifierProvider<ReleaseDetailViewModel>(
                  create: (BuildContext context) => ReleaseDetailViewModel(
                    repository: context.read<ReleaseRepository>(),
                    id: state.pathParameters['id']!,
                  )..load(),
                  child: const ReleaseDetailView(),
                ),
          ),
          GoRoute(
            path: 'settings',
            builder: (BuildContext context, GoRouterState state) =>
                ChangeNotifierProvider<SettingsViewModel>(
                  create: (BuildContext context) => SettingsViewModel(
                    repository: context.read<SettingsRepository>(),
                  )..load(),
                  child: const SettingsView(),
                ),
          ),
        ],
      ),
    ],
  );
}
