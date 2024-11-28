// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HolidayEntity _$HolidayEntityFromJson(Map<String, dynamic> json) =>
    HolidayEntity(
      date: json['date'] as String,
      localName: json['localName'] as String,
      name: json['name'] as String,
      countryCode: json['countryCode'] as String,
      fixed: json['fixed'] as bool,
      global: json['global'] as bool,
      types: (json['types'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$HolidayEntityToJson(HolidayEntity instance) =>
    <String, dynamic>{
      'date': instance.date,
      'localName': instance.localName,
      'name': instance.name,
      'countryCode': instance.countryCode,
      'fixed': instance.fixed,
      'global': instance.global,
      'types': instance.types,
    };
