import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:clean_architeture_flutter/app/data/api/dio_client.dart';
import 'package:clean_architeture_flutter/app/data/api/http_error.dart';

class DioAdapter implements DioClient {
  final Dio client;

  DioAdapter(this.client);

  Future<T> get<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await this.client.get(
          url,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );

    return handleResponse(response);
  }

  Future<T> post<T>(
    String url, {
    required Map<String, dynamic> data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final response = await this.client.post(
          url,
          data: FormData.fromMap(data),
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
        );

    return handleResponse(response);
  }

  dynamic handleResponse(Response response) {
    switch (response.statusCode) {
      case HttpStatus.ok:
        return response.data.isEmpty ? null : response.data;
      case HttpStatus.noContent:
        return null;
      case HttpStatus.badRequest:
        throw HttpError.badRequest;
      case HttpStatus.unauthorized:
        throw HttpError.unauthorized;
      case HttpStatus.forbidden:
        throw HttpError.forbidden;
      case HttpStatus.notFound:
        throw HttpError.notFound;

      default:
        throw HttpError.serverError;
    }
  }
}
