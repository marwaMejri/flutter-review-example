import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_ui_packages_migration/core/constants/app_constants.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/view_models/releases_view_model.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/widgets/release_tile.dart';
import 'package:provider/provider.dart';

/// The list of releases, newest first.
class ReleasesView extends StatefulWidget {
  const ReleasesView({super.key});

  @override
  State<ReleasesView> createState() => _ReleasesViewState();
}

class _ReleasesViewState extends State<ReleasesView> {
  final ScrollController _scrollController = ScrollController();

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
      body: _ReleasesBody(scrollController: _scrollController),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Back to top',
        onPressed: () => _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOut,
        ),
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}

/// The part of the page that changes with the view model.
class _ReleasesBody extends StatelessWidget {
  const _ReleasesBody({required this.scrollController});

  final ScrollController scrollController;

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
      controller: scrollController,
      itemCount: releases.length,
      itemBuilder: (BuildContext context, int index) => ReleaseTile(
        release: releases[index],
        onTap: () => context.go('/releases/${releases[index].id}'),
      ),
    );
  }
}
