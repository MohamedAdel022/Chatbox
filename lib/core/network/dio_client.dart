import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _singleton = DioClient._internal();
  late final Dio dio;

  factory DioClient() {
    return _singleton;
  }

  DioClient._internal() {
    dio = Dio();
    _configureDio();
  }

  void _configureDio() {
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.sendTimeout = const Duration(seconds: 30);
    
    // Set default headers
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
    
    // Add interceptors for logging, authentication, etc.
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }
}
