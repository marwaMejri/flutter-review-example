import 'package:equatable/equatable.dart';

/// A version of the app, with what the screens need to show it.
class Release extends Equatable {
  const Release({
    required this.id,
    required this.version,
    required this.date,
    required this.summary,
    required this.notes,
  });

  final int id;
  final String version;
  final DateTime date;
  final String summary;

  /// The release notes, in Markdown.
  final String notes;

  @override
  List<Object> get props => <Object>[id, version, date, summary, notes];
}
