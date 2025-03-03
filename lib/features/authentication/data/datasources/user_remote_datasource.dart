import 'package:flutter_camping_frontend/core/error/exception.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/core/services/token_storage.dart';
import 'package:flutter_camping_frontend/features/authentication/data/models/user_model.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(
      String name, String email, String password, String passwordConfirmation);
  Future<void> logout();
  Future<UserModel> getCurrentUser();
}

class UserRemoteDataSourceImplementation extends UserRemoteDataSource {
  final DioClient dio;
  final TokenStorage tokenStorage;

  UserRemoteDataSourceImplementation(
      {required this.dio, required this.tokenStorage});
  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await dio.postRequest(
        ApiEndpoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      final token = response.data['result']['access_token'];
      final userJson = response.data['result']['user'];

      // Simpan token ke TokenStorageService
      await tokenStorage.saveToken(token);

      return UserModel.fromJson(userJson, token);
    } catch (e) {
      throw const GeneralException(message: "gagal Login");
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password,
      String passwordConfirmation) async {
    try {
      final response = await dio.postRequest(
        ApiEndpoints.register,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
      );

      if (response.statusCode == 200) {
        // MASUKKAN KE MODEL
        final token = response.data['result']['access_token'];
        final userJson = response.data['result']['user'];

        // Simpan token ke TokenStorageService
        await tokenStorage.saveToken(token);

        return UserModel.fromJson(userJson, token);
      } else {
        throw GeneralException(
            message: "Gagal registrasi: ${response.statusMessage}");
      }
    } catch (e) {
      throw const GeneralException(message: "gagal Register");
    }
  }

  @override
  Future<void> logout() async {
    try {
      await dio.postRequest(ApiEndpoints.logout);

      // Hapus
      await tokenStorage.removeToken();
    } catch (e) {
      throw const GeneralException(message: "gagal Logout");
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final token = await tokenStorage.getToken();
      if (token == null) {
        throw GeneralException(
            message: "Token tidak ditemukan, silakan login.");
      }

      final response = await dio.getRequest(ApiEndpoints.currentUser);
      final userJson = response.data['result']['user'];

      return UserModel.fromJson(userJson, token);
    } catch (e) {
      throw GeneralException(message: "Gagal GetCurrentUser: ${e.toString()}");
    }
  }
}
