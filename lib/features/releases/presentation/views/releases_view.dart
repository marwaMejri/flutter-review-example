import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_ui_packages_migration/core/constants/app_constants.dart';
import 'package:material_ui_packages_migration/core/utils/date_format.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/view_models/releases_view_model.dart';
import 'package:provider/provider.dart';

/// The list of releases, newest first.
class ReleasesView extends StatelessWidget {
  const ReleasesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$appName releases'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Settings',
            onPressed: () => context.go('/settings'),
          ),
        ],
      ),
      body: const _ReleasesBody(),
    );
  }
}

/// The part of the page that changes with the view model.
class _ReleasesBody extends StatelessWidget {
  const _ReleasesBody();

  @override
  Widget build(BuildContext context) {
    final ReleasesViewModel viewModel = context.watch<ReleasesViewModel>();
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (viewModel.error case final String error) {
      return Center(child: Text(error));
    }
    final List<Release> releases = viewModel.releases;
    return ListView.builder(
      itemCount: releases.length,
      itemBuilder: (BuildContext context, int index) => ReleaseTile(
        release: releases[index],
        onTap: () => context.go('/releases/${releases[index].id}'),
      ),
    );
  }
}

/// One release in the list.
class ReleaseTile extends StatelessWidget {
  const ReleaseTile({required this.release, required this.onTap, super.key});

  final Release release;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        child: const Icon(Icons.new_releases),
      ),
      title: Text('Version ${release.version}'),
      subtitle: Text('${formatDate(release.date)} · ${release.summary}'),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
