import 'package:flutter_test/flutter_test.dart';
import 'package:holiday_tracker/domain/entities/holiday_entity.dart';

void main() {
  group('HolidayEntity', () {
    test('should create a HolidayEntity instance from JSON', () {
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
    });

    test('should convert HolidayEntity to JSON correctly', () {
      const holiday = HolidayEntity(
        date: '2024-12-25',
        localName: 'Natal',
        name: 'Christmas',
        countryCode: 'BR',
        fixed: true,
        global: true,
        types: ['public'],
      );

      final json = holiday.toJson();

      expect(json['date'], '2024-12-25');
      expect(json['localName'], 'Natal');
      expect(json['name'], 'Christmas');
      expect(json['countryCode'], 'BR');
      expect(json['fixed'], true);
      expect(json['global'], true);
      expect(json['types'], ['public']);
    });
  });

  group('HolidayListExtension', () {
    test('should return the next holiday', () {
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

  group('HolidayCheckExtension', () {
    test('should return true if today is a holiday', () {
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

    test('should return false if today is not a holiday', () {
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

  group('HolidayExtension', () {
    test('should return the correct number of days until the holiday', () {
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

    test('should return the correct weekday name', () {
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
