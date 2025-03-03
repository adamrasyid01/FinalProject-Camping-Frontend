import 'package:dio/dio.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  final Dio _dio;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {'Content-Type': 'application/json'},
          ),
        ) {
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          final token = await _storage.read(key: 'access_token');
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        } catch (e) {
          print("Error retrieving token: $e");
        }
        handler.next(options);
      },
      onError: (DioException e, handler) {
        if (e.response?.statusCode == 401) {
          print("Token expired, redirect to login!");
          // TODO: Handle logout or token refresh
        }
        handler.next(e);
      },
    ));
  }

  Future<Response> getRequest(String url,
      {Map<String, dynamic>? queryParams}) async {
    try {
      return await _dio.get(url, queryParameters: queryParams);
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<Response> postRequest(String url, {Map<String, dynamic>? data}) async {
    try {
      return await _dio.post(url, data: data);
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.response?.data ?? e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
