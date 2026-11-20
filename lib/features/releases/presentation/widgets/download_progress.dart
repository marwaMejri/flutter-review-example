import 'package:material_ui/material_ui.dart';

/// The download progress of a release, with its label. The bar moves to the
/// new progress when it changes.
class DownloadProgress extends StatelessWidget {
  const DownloadProgress({
    required this.progress,
    required this.label,
    super.key,
  });

  /// From 0 to 1.
  final double progress;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: progress),
      duration: const Duration(milliseconds: 300),
      builder: (BuildContext context, double value, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(label, style: Theme.of(context).textTheme.labelLarge),
            LinearProgressIndicator(value: value),
          ],
        );
      },
    );
  }
}
