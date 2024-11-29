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

extension HolidayListExtension on List<HolidayEntity> {
  HolidayEntity? getNextHoliday() {
    final today = DateTime.now();

    sort((a, b) {
      final dateA = DateTime.parse(a.date);
      final dateB = DateTime.parse(b.date);
      return dateA.compareTo(dateB);
    });

    for (final holiday in this) {
      final holidayDate = DateTime.parse(holiday.date);
      if (holidayDate.isAfter(today)) {
        return holiday;
      }
    }
    return null;
  }
}

extension HolidayExtension on HolidayEntity {
  int daysUntilHoliday() {
    final holidayDate = DateTime.parse(date);
    final today = DateTime.now();

    return holidayDate.difference(today).inDays;
  }

  String getWeekDayName(){
    final holidayDate = DateTime.parse(date);
    return AppPipes.weekDays[holidayDate.weekday - 1];
    
  }
}
