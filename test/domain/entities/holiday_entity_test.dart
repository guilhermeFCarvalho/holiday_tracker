import 'package:flutter_test/flutter_test.dart';
import 'package:holiday_tracker/domain/entities/holiday_entity.dart';

void main() {
  group('HolidayEntity Tests', () {
    test('fromJson and toJson should work correctly', () {
      final json = {
        'date': '2024-12-25',
        'localName': 'Natal',
        'name': 'Christmas',
        'countryCode': 'BR',
        'fixed': true,
        'global': true,
        'types': ['public'],
      };

      final holiday = HolidayEntity.fromJson(json);

      expect(holiday.date, '2024-12-25');
      expect(holiday.localName, 'Natal');
      expect(holiday.name, 'Christmas');
      expect(holiday.countryCode, 'BR');
      expect(holiday.fixed, true);
      expect(holiday.global, true);
      expect(holiday.types, ['public']);

      final convertedJson = holiday.toJson();

      expect(convertedJson['date'], '2024-12-25');
      expect(convertedJson['localName'], 'Natal');
      expect(convertedJson['name'], 'Christmas');
      expect(convertedJson['countryCode'], 'BR');
      expect(convertedJson['fixed'], true);
      expect(convertedJson['global'], true);
      expect(convertedJson['types'], ['public']);
    });
  });

  group('HolidayListExtension Tests', () {
    test('getNextHoliday should return the next holiday', () {
      final holidays = [
        const HolidayDto(
          holiday: HolidayEntity(
            date: '2024-12-25',
            localName: 'Natal',
            name: 'Christmas',
            countryCode: 'BR',
            fixed: true,
            global: true,
            types: ['public'],
          ),
          isFavorite: false,
        ),
        const HolidayDto(
          holiday: HolidayEntity(
            date: '2024-01-01',
            localName: 'Ano Novo',
            name: 'New Year',
            countryCode: 'BR',
            fixed: true,
            global: true,
            types: ['public'],
          ),
          isFavorite: true,
        ),
      ];

      final nextHoliday = holidays.getNextHoliday();

      expect(nextHoliday?.date, '2024-12-25');
      expect(nextHoliday?.name, 'Christmas');
    });
  });

  group('HolidayCheckExtension Tests', () {
    test('isTodayHoliday should return true if today is a holiday', () {
      final holiday = HolidayEntity(
        date: DateTime.now().toIso8601String(),
        localName: 'Hoje',
        name: 'Holiday Today',
        countryCode: 'BR',
        fixed: true,
        global: true,
        types: ['public'],
      );

      expect(holiday.isTodayHoliday(), true);
    });

    test('isTodayHoliday should return false if today is not a holiday', () {
      const holiday = HolidayEntity(
        date: '2024-12-25',
        localName: 'Natal',
        name: 'Christmas',
        countryCode: 'BR',
        fixed: true,
        global: true,
        types: ['public'],
      );

      expect(holiday.isTodayHoliday(), false);
    });
  });

  group('HolidayExtension Tests', () {
    test('daysUntilHoliday should return the correct number of days', () {
      const holiday = HolidayEntity(
        date: '2024-12-25',
        localName: 'Natal',
        name: 'Christmas',
        countryCode: 'BR',
        fixed: true,
        global: true,
        types: ['public'],
      );

      final daysUntil = holiday.daysUntilHoliday();
      final today = DateTime.now();
      final holidayDate = DateTime.parse(holiday.date);

      expect(daysUntil.inDays, holidayDate.difference(today).inDays);
    });

    test('getWeekDayName should return the correct weekday name', () {
      const holiday = HolidayEntity(
        date: '2024-12-25',
        localName: 'Natal',
        name: 'Christmas',
        countryCode: 'BR',
        fixed: true,
        global: true,
        types: ['public'],
      );

      final weekDay = holiday.getWeekDayName();
      expect(weekDay, 'Quarta');
    });
  });
}
