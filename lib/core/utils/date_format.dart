const List<String> _months = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

/// Formats [date] as the app shows it, for example `1 October 2026`.
String formatDate(DateTime date) =>
    '${date.day} ${_months[date.month - 1]} ${date.year}';
