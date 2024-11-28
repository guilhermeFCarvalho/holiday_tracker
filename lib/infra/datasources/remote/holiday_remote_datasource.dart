import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:holiday_tracker/core/http/http_client.dart';
import 'package:holiday_tracker/domain/entities/holiday_entity.dart';

abstract class HolidayRemoteDatasource {
  Future<List<HolidayEntity>> fetchHolidays();
}

class HolidayRemoteDatasourceImpl implements HolidayRemoteDatasource {
  final HttpClient client;

  HolidayRemoteDatasourceImpl(this.client);

  @override
  Future<List<HolidayEntity>> fetchHolidays() async {
    final result = await client.getHolidays();

    return result;
  }
}

final holidayRemoteDatasourceProvider = Provider<HolidayRemoteDatasource>(
    (ref) => HolidayRemoteDatasourceImpl(ref.read(httpClientProvider)));
