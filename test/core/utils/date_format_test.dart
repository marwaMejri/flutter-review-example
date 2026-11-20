import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui_packages_migration/core/utils/date_format.dart';

void main() {
  test('formats a date in full', () {
    expect(formatDate(DateTime(2026, 10)), '1 October 2026');
  });

  test('formats a date in a short form', () {
    expect(formatShortDate(DateTime(2026, 10)), '1 Oct 2026');
    expect(formatShortDate(DateTime(2026, 5, 2)), '2 May 2026');
  });
}
