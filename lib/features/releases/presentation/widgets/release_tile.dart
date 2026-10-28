import 'package:material_ui/material_ui.dart';
import 'package:material_ui_packages_migration/core/utils/date_format.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';

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
