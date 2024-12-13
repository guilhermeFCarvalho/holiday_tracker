import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:holiday_tracker/core/http/interceptors/error_interceptor.dart';
import 'package:holiday_tracker/domain/entities/holiday_entity.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'http_client.g.dart';

@RestApi(baseUrl: "https://date.nager.at/api/v3/PublicHolidays")
abstract class HttpClient {
  factory HttpClient(
    Dio dio, {
    String? baseUrl,
    ParseErrorLogger? errorLogger,
  }) = _HttpClient;

  @GET('/{currentYear}/BR')
  Future<List<HolidayEntity>> getHolidays(
      @Path("currentYear") String countryCode);
}

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio();

  dio.interceptors.add(ErrorInterceptor());

  return dio;
});

final httpClientProvider = Provider(
  (ref) => HttpClient(ref.read(dioProvider)),
);
