import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:smart_mobile/src/core/dio/interface/dio_interface.dart';
import 'package:smart_mobile/src/core/dio/models/dio_response.dart';

class DioImpl implements DioInterface {
  final _dio = Dio(
    BaseOptions(
      baseUrl: 'https://dummyjson.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  @override
  Future<DioResponse> get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    String fullPath = _dio.options.baseUrl + path;

    final request = await _dio.get(
      fullPath,
      data: data,
      queryParameters: queryParameters,
      options: options,
    );

    log(fullPath);
    log('BasePath: ${_dio.options.baseUrl}');
    log('Path: $path');

    if (request.statusCode == null) {
      return DioResponse(data: null, status: DioStatus.failure);
    }

    if (request.statusCode! >= 200 && request.statusCode! < 300) {
      return DioResponse(data: request.data, status: DioStatus.success);
    }

    return DioResponse(data: null, status: DioStatus.failure);
  }
}
