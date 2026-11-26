import 'dart:async';

/// Messages for the user, sent from anywhere in the app.
final StreamController<String> appMessages =
    StreamController<String>.broadcast();
