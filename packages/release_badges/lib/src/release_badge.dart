import 'package:material_ui/material_ui.dart';

/// The channel of a release, with its tags sorted by name.
class ReleaseBadge extends StatelessWidget {
  const ReleaseBadge({required this.channel, required this.tags, super.key});

  final String channel;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    final List<String> sorted = <String>[...tags]..sort();
    if (sorted.isEmpty) {
      return Chip(label: Text(channel));
    }
    return Chip(label: Text('$channel · ${sorted.join(', ')}'));
  }
}
