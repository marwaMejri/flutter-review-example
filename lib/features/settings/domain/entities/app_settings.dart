import 'package:equatable/equatable.dart';

/// Which versions of the app the user receives.
enum UpdateChannel { stable, beta }

/// The settings that the user can change.
class AppSettings extends Equatable {
  const AppSettings({required this.channel});

  final UpdateChannel channel;

  @override
  List<Object> get props => <Object>[channel];
}
