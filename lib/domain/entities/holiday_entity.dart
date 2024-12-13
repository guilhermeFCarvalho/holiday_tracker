import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:holiday_tracker/core/common/shared/app_pipes.dart';

part 'holiday_entity.g.dart';

@JsonSerializable()
class HolidayEntity extends Equatable {
  final String date;
  final String localName;
  final String name;
  final String countryCode;
  final bool fixed;
  final bool global;
  final List<String> types;

  const HolidayEntity({
    required this.date,
    required this.localName,
    required this.name,
    required this.countryCode,
    required this.fixed,
    required this.global,
    required this.types,
  });

  factory HolidayEntity.fromJson(Map<String, dynamic> json) =>
      _$HolidayEntityFromJson(json);

  Map<String, dynamic> toJson() => _$HolidayEntityToJson(this);

  @override
  List<Object?> get props => [
        date,
        localName,
        name,
        countryCode,
        fixed,
        global,
        types,
      ];
}

extension HolidayListExtension on List<HolidayDto> {
  HolidayEntity? getNextHoliday() {
    final today = DateTime.now();

    sort((a, b) {
      final dateA = DateTime.parse(a.holiday.date);
      final dateB = DateTime.parse(b.holiday.date);
      return dateA.compareTo(dateB);
    });

    for (final dto in this) {
      final holidayDate = DateTime.parse(dto.holiday.date);

      if (DateTime(
        holidayDate.year,
        holidayDate.month,
        holidayDate.day,
        23,
        59,
      ).isAfter(
        today,
      )) {
        return dto.holiday;
      }
    }
    return null;
  }
}

extension HolidayCheckExtension on HolidayEntity {
  bool isTodayHoliday() {
    final holidayDate = DateTime.parse(date);
    final today = DateTime.now();

    return holidayDate.year == today.year &&
        holidayDate.month == today.month &&
        holidayDate.day == today.day;
  }
}

extension HolidayExtension on HolidayEntity {
  Duration daysUntilHoliday() {
    final holidayDate = DateTime.parse(date);
    final today = DateTime.now();

    return holidayDate.difference(today);
  }

  String getWeekDayName() {
    final holidayDate = DateTime.parse(date);
    return AppPipes.weekDays[holidayDate.weekday - 1];
  }
}

@immutable
class HolidayDto {
  final HolidayEntity holiday;
  final bool isFavorite;

  const HolidayDto({
    required this.holiday,
    required this.isFavorite,
  });
}
