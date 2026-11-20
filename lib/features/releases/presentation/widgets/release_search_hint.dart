import 'dart:async';

import 'package:material_ui/material_ui.dart';

/// A hint that shows the last search.
class ReleaseSearchHint extends StatelessWidget {
  const ReleaseSearchHint({super.key});

  @override
  Widget build(BuildContext context) {
    final StreamController<String> searches = StreamController<String>();
    return StreamBuilder<String>(
      stream: searches.stream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) =>
          Text(snapshot.data ?? 'No search yet.'),
    );
  }
}
