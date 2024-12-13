import 'package:flutter_test/flutter_test.dart';
import 'package:holiday_tracker/core/common/shared/app_pipes.dart';

void main() {
  group('getCurrentYear', () {
    test(
        'should return the next year if the date is after December 25th at 11:59 PM',
        () {
      final DateTime testDate = DateTime(2024, 12, 26, 0, 0);
      final String result = AppPipes.getCurrentYear(testDate);

      expect(result, '2025');
    });

    test(
        'should return the current year if the date is exactly December 25th at 11:59 PM',
        () {
      final DateTime testDate = DateTime(2024, 12, 25, 23, 59);
      final String result = AppPipes.getCurrentYear(testDate);

      expect(result, '2024');
    });

    test('should return the current year if the date is before December 25thu',
        () {
      final DateTime testDate = DateTime(2024, 12, 25, 23, 58);
      final String result = AppPipes.getCurrentYear(testDate);

      expect(result, '2024');
    });
  });
}
