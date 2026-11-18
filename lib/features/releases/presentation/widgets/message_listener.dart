import 'package:material_ui/material_ui.dart';
import 'package:material_ui_packages_migration/core/utils/app_messages.dart';

/// Shows the messages of the app in a snack bar.
class MessageListener extends StatefulWidget {
  const MessageListener({required this.child, super.key});

  final Widget child;

  @override
  State<MessageListener> createState() => _MessageListenerState();
}

class _MessageListenerState extends State<MessageListener> {
  @override
  void initState() {
    super.initState();
    appMessages.stream.listen((String message) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
