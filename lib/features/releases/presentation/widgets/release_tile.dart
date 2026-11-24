import 'package:material_ui/material_ui.dart';
import 'package:material_ui_packages_migration/core/utils/date_format.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';
import 'package:material_ui_packages_migration/features/releases/presentation/widgets/new_badge.dart';

/// One release in the list.
class ReleaseTile extends StatelessWidget {
  const ReleaseTile({
    required this.release,
    required this.onTap,
    required this.isNew,
    super.key,
  });

  final Release release;
  final VoidCallback onTap;
  final bool isNew;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        child: const Icon(Icons.new_releases),
      ),
      title: Row(
        children: <Widget>[
          Text('Version ${release.version}'),
          if (isNew)
            const Padding(padding: EdgeInsets.only(left: 8), child: NewBadge()),
        ],
      ),
      subtitle: Text('${formatDate(release.date)} · ${release.summary}'),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
