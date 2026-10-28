import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:material_ui/material_ui.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/view_models/release_detail_view_model.dart';
import 'package:provider/provider.dart';

/// The notes of one release.
class ReleaseDetailView extends StatelessWidget {
  const ReleaseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final ReleaseDetailViewModel viewModel = context
        .watch<ReleaseDetailViewModel>();
    final Release? release = viewModel.release;
    if (viewModel.isLoading) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    final Color? codeColor = Theme.of(context).cardTheme.color;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          release == null ? 'Not found' : 'Version ${release.version}',
        ),
      ),
      body: release == null
          ? const Center(child: Text('This release does not exist.'))
          : Markdown(
              data: release.notes,
              styleSheet: MarkdownStyleSheet(
                code: TextStyle(backgroundColor: codeColor),
                codeblockDecoration: BoxDecoration(
                  color: codeColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
    );
  }
}
