import 'dart:async';

import 'package:material_ui/material_ui.dart';

/// A "NEW" tag that fades in and out a few times, then stays visible.
class NewBadge extends StatefulWidget {
  const NewBadge({super.key});

  @override
  State<NewBadge> createState() => _NewBadgeState();
}

class _NewBadgeState extends State<NewBadge>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    // A finite count: an animation without end would never let the widget
    // tests settle (`pumpAndSettle`).
    unawaited(
      _controller.repeat(reverse: true, count: 6).whenComplete(() {
        if (mounted) {
          _controller.value = 1;
        }
      }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Opacity(
          opacity: _controller.value,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: colors.primary,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              child: Text(
                'NEW',
                style: Theme.of(context).textTheme.labelSmall
                    ?.copyWith(color: colors.onPrimary),
              ),
            ),
          ),
        );
      },
    );
  }
}
