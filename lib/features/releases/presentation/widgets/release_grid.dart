import 'package:material_ui/material_ui.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';

/// The channels of the app, and the releases as cards.
class ReleaseGrid extends StatelessWidget {
  const ReleaseGrid({required this.releases, super.key});

  final List<Release> releases;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 48,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const <Widget>[
              Chip(label: Text('Stable')),
              Chip(label: Text('Beta')),
            ],
          ),
        ),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            children: <Widget>[
              for (final Release release in releases)
                Card(child: Center(child: Text(release.version))),
            ],
          ),
        ),
      ],
    );
  }
}
