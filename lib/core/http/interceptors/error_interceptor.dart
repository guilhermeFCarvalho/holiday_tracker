import 'package:dio/dio.dart';
import 'package:holiday_tracker/core/failures/failure.dart';

class ErrorInterceptor extends Interceptor {
  ErrorInterceptor();

  @override
  Failure onError(DioException err, ErrorInterceptorHandler handler) {
    return Failure.undefined;
  }
}


