import 'package:dio/dio.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_camping_frontend/core/services/token_storage.dart';

class DioClient {
  final Dio _dio;
  final TokenStorage _tokenStorage = TokenStorage();

  DioClient()
      : _dio = Dio(
          BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 30),
            headers: {
              'Content-Type': 'application/json'
            }, // ❌ Hapus Authorization di sini
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
          final token =
              await _tokenStorage.getToken(); // ✅ Ambil token dari storage
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        } catch (e) {
          print("Error retrieving token: $e");
        }
        handler.next(options); // ⏩ Lanjutkan request
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

  /// 🔹 Metode GET
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

  /// 🔹 Metode POST
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
