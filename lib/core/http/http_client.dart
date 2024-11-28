import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:holiday_tracker/core/failures/failure.dart';
import 'package:holiday_tracker/domain/entities/holiday_entity.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'http_client.g.dart';

@RestApi(baseUrl: "https://date.nager.at/api/v3")
abstract class HttpClient {
  factory HttpClient(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _HttpClient;

  @GET('/PublicHolidays/2024/BR')
  Future<List<HolidayEntity>> getHolidays();
}


final httpClientProvider = Provider(
  (ref) => HttpClient(Dio()),
);
