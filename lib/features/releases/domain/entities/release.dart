import 'package:equatable/equatable.dart';

/// A version of the app, with what the screens need to show it.
class Release extends Equatable {
  const Release({
    required this.id,
    required this.version,
    required this.date,
    required this.summary,
    required this.notes,
    required this.knownIssues,
  });

  final int id;
  final String version;
  final DateTime date;
  final String summary;

  /// The release notes, in Markdown.
  final String notes;

  /// The problems known in this version, one sentence each. Empty when there
  /// is none.
  final List<String> knownIssues;

  @override
  List<Object> get props => <Object>[
    id,
    version,
    date,
    summary,
    notes,
    knownIssues,
  ];
}
