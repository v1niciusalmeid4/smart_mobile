import 'package:dio/dio.dart';
import 'package:smart_mobile/src/core/dio/models/dio_response.dart';

abstract class DioInterface {
  Future<DioResponse> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });
}
