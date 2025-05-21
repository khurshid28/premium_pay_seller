import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/service/storage.dart';

class AuthCheckInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      print('➡️ Request: ${options.method} ${options.uri}');
    }
    String? token = StorageService().read(StorageService.token);

  
    if (token != null) {
      options.headers['Authorization'] = "Bearer $token";
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      print('✅ Response: ${response.statusCode} ${response.data}');
    }
   
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
     if (err.response?.statusCode == 401 ) {
      if (kDebugMode) {
        print("logout");
      }
      StorageService().logout();
      rootNavigatorKey.currentContext?.replace(RouteConstants.login);
    }
    if (kDebugMode) {
      print('❌ Error: ${err.message}');
    }
    return handler.next(err);
  }
}
