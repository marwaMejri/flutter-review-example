import 'package:material_ui/material_ui.dart';
import 'package:material_ui_packages_migration/features/releases/domain/entities/release.dart';

/// The years that have a release, the newest first.
class ReleaseYears extends StatefulWidget {
  const ReleaseYears({required this.releases, super.key});

  final List<Release> releases;

  @override
  State<ReleaseYears> createState() => _ReleaseYearsState();
}

class _ReleaseYearsState extends State<ReleaseYears> {
  late List<int> _years;

  @override
  void initState() {
    super.initState();
    _years = _sortedYears();
  }

  @override
  void didUpdateWidget(ReleaseYears oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.releases != widget.releases) {
      _years = _sortedYears();
    }
  }

  List<int> _sortedYears() {
    final List<int> years = <int>{
      for (final Release release in widget.releases) release.date.year,
    }.toList()..sort((int a, int b) => b.compareTo(a));
    return years;
  }

  @override
  Widget build(BuildContext context) {
    return Text(_years.join(' · '));
  }
}
