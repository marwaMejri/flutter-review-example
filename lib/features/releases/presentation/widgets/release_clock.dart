import 'dart:async';

import 'package:material_ui/material_ui.dart';

/// The time since the page opened, in seconds.
class ReleaseClock extends StatefulWidget {
  const ReleaseClock({super.key});

  @override
  State<ReleaseClock> createState() => _ReleaseClockState();
}

class _ReleaseClockState extends State<ReleaseClock> {
  int _seconds = 0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() => _seconds++);
    });
  }

  @override
  Widget build(BuildContext context) => Text('$_seconds s');
}
