import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:holiday_tracker/core/failures/failure.dart';
import 'package:holiday_tracker/core/http/http_client.dart';
import 'package:holiday_tracker/domain/entities/holiday_entity.dart';

abstract class HolidayRemoteDatasource {
  Future<Either<Failure, List<HolidayEntity>>> fetchHolidays();
}

class HolidayRemoteDatasourceImpl implements HolidayRemoteDatasource {
  final HttpClient client;

  HolidayRemoteDatasourceImpl(this.client);

  @override
  Future<Either<Failure, List<HolidayEntity>>> fetchHolidays() async {
    try {
      final result = await client.getHolidays();
      return right(result);
    } catch (e) {
      return left(Failure.undefined);
    }
  }
}

final holidayRemoteDatasourceProvider = Provider<HolidayRemoteDatasource>(
    (ref) => HolidayRemoteDatasourceImpl(ref.read(httpClientProvider)));
