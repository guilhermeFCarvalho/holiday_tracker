import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

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
