import 'dart:async';

import 'package:material_ui/material_ui.dart';

/// The highlights of the app, shown above the list of releases.
class ReleaseHighlights extends StatefulWidget {
  const ReleaseHighlights({required this.loadCount, this.tags, super.key});

  /// Reads how many releases there are.
  final Future<int> Function() loadCount;

  /// Tags shown under the highlights, or null to show none.
  final List<String>? tags;

  @override
  State<ReleaseHighlights> createState() => _ReleaseHighlightsState();
}

class _ReleaseHighlightsState extends State<ReleaseHighlights>
    with SingleTickerProviderStateMixin {
  late final Future<int> _count;
  late final AnimationController _pulse;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _count = widget.loadCount();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    unawaited(_pulse.forward());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AnimatedBuilder(
          animation: _pulse,
          child: const Icon(Icons.star),
          builder: (BuildContext context, Widget? child) =>
              Opacity(opacity: _pulse.value, child: child),
        ),
        FutureBuilder<int>(
          future: _count,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) =>
              Text(snapshot.hasData ? '${snapshot.data} releases' : ''),
        ),
        SizedBox(
          height: 120,
          child: ListView(
            controller: _scrollController,
            children: const <Widget>[
              Text('Background sync'),
              Text('Faster search'),
              Text('Offline notes'),
            ],
          ),
        ),
        if (widget.tags case final List<String> tags) Text(tags.join(', ')),
      ],
    );
  }
}
