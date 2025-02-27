import 'package:dio/dio.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  final Dio _dio = Dio();

  // Save the token to te header
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  DioClient() {
    _dio.options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    );

    // Tambahkan interceptor untuk auth token
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        String? token = await _storage.read(key: 'access_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  Future<Response> getRequest(String url) async {
    try {
      Response response = await _dio.get(url);
      return response;
    } catch (e) {
      throw e;
    }
  }

  Future<Response> postRequest(String url, {Map<String, dynamic>? data}) async {
    try {
      Response response = await _dio.post(url, data: data);
      return response;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
