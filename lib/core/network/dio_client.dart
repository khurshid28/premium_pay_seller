import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:premium_pay_seller/core/network/auth_check_interceptor.dart';
import 'package:premium_pay_seller/core/network/dio_exception.dart';

import '../../export_files.dart';
import '../endpoints/endpoints.dart';

class DioClient {
// dio instance
  final dio.Dio _dio = dio.Dio();

  DioClient() {
    _dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout =
          Duration(milliseconds: Endpoints.connectionTimeout)
      ..options.receiveTimeout =
          Duration(milliseconds: Endpoints.receiveTimeout)
      ..options.responseType = dio.ResponseType.json;

    _dio.interceptors.add(AuthCheckInterceptor());
  }

  Future<dio.Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    dio.ProgressCallback? onReceiveProgress,
    String? baseUrl,
  }) async {
    try {
      if (baseUrl != null) {
        // ignore: avoid_single_cascade_in_expression_statements
        _dio..options.baseUrl = baseUrl;
      }
      final dio.Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on dio.DioError catch (e) {
      DioExceptions.fromDioError(e);
      if (e.error is SocketException || e.type == DioExceptionType.unknown) {
        await Future.delayed(
          const Duration(seconds: 5),
        );
        return await get(
          url,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );
      }

      return e.response!;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      rethrow;
    }
  }

  Future<dio.Response> post(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    dio.ProgressCallback? onSendProgress,
    dio.ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final dio.Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } on dio.DioException catch (e) {
      // DioExceptions.fromDioError(e);
      if (e.error is SocketException || e.type == DioExceptionType.unknown) {
        await Future.delayed(
          const Duration(seconds: 5),
        );
        return await post(
          url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );
      }
      return e.response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<dio.Response> put(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    dio.ProgressCallback? onSendProgress,
    dio.ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final dio.Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on dio.DioError catch (e) {
      DioExceptions.fromDioError(e);

      if (e.error is SocketException || e.type == DioErrorType.unknown) {
        await Future.delayed(
          const Duration(seconds: 5),
        );
        return await put(
          url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );
      }
      return e.response!;
    } catch (e) {
      rethrow;
    }
  }

  Future<dio.Response> patch(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    dio.ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final dio.Response response = await _dio.patch(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on dio.DioError catch (e) {
      DioExceptions.fromDioError(e);
      if (e.error is SocketException || e.type == DioErrorType.unknown) {
        await Future.delayed(
          const Duration(seconds: 5),
        );
        return await patch(
          url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );
      }

      return e.response!;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      rethrow;
    }
  }

  Future<dio.Response> delete(
    String url, {
    data,
    Map<String, dynamic>? queryParameters,
    dio.Options? options,
    dio.CancelToken? cancelToken,
    dio.ProgressCallback? onSendProgress,
    dio.ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final dio.Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response.data;
    } on dio.DioError catch (e) {
      DioExceptions.fromDioError(e);
      if (e.error is SocketException || e.type == DioErrorType.unknown) {
        await Future.delayed(
          const Duration(seconds: 5),
        );
        return await delete(
          url,
          data: data,
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
        );
      }
      return e.response!;
    } catch (e) {
      rethrow;
    }
  }
}
