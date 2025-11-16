import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hr_management_system/core/config/api_config.dart';

/// خدمة الاتصال بالشبكة عبر Dio مع إدارة الرؤوس، الأخطاء، وإعادة المحاولة
class ApiService {
  final Dio _dio;
  String? _authToken;

  ApiService._internal(this._dio);

  factory ApiService() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (_instance._authToken != null) {
          options.headers['Authorization'] = 'Bearer ${_instance._authToken}';
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (error, handler) {
        if (_shouldRetry(error)) {
          _retryRequest(error).then(handler.resolve).catchError((_) => handler.next(error));
        } else {
          handler.next(error);
        }
      },
    ));

    return _instance = ApiService._internal(dio);
  }

  static late ApiService _instance;
  static ApiService get instance => _instance;

  void setAuthToken(String? token) {
    _authToken = token;
  }

  /// إضافة معترضات مخصصة (للاختبارات أو تخصيص السلوك)
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? query}) async {
    return await _dio.get<T>(path, queryParameters: query);
  }

  Future<Response<T>> post<T>(String path, {Object? data}) async {
    return await _dio.post<T>(path, data: data);
  }

  Future<Response<T>> put<T>(String path, {Object? data}) async {
    return await _dio.put<T>(path, data: data);
  }

  Future<Response<T>> delete<T>(String path, {Object? data}) async {
    return await _dio.delete<T>(path, data: data);
  }

  bool _shouldRetry(DioException error) {
    return error.type == DioExceptionType.connectionError ||
        error.type == DioExceptionType.receiveTimeout ||
        error.response?.statusCode == 502 ||
        error.response?.statusCode == 503 ||
        error.response?.statusCode == 504;
  }

  Future<Response<dynamic>> _retryRequest(DioException error) async {
    final requestOptions = error.requestOptions;
    try {
      if (kDebugMode) {
        // ignore: avoid_print
        print('Retrying request: ${requestOptions.method} ${requestOptions.uri}');
      }
      return await _dio.request(
        requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: Options(
          method: requestOptions.method,
          headers: requestOptions.headers,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }
}