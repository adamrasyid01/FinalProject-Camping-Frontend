import 'package:dio/dio.dart';
import 'package:flutter_camping_frontend/core/error/exception.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/features/authentication/data/models/user_model.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<User> login(String email, String password);
  Future<User> register(
      String name, String email, String password, String passwordConfirmation);
  Future<User> logout();
  Future<User> getCurrentUser();
}

class UserRemoteDataSourceImplementation extends UserRemoteDataSource {
  final DioClient dio;

  UserRemoteDataSourceImplementation({required this.dio});
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

      return UserModel.fromJson(response.data);
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

      // print("Response dari server: ${response}");

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw GeneralException(
        message: "Gagal registrasi: ${response.statusMessage}");
      }
    } catch (e) {
      throw const GeneralException(message: "gagal Register");
    }
  }

  @override
  Future<UserModel> logout() async {
    try {
      await dio.postRequest(ApiEndpoints.logout);
      return UserModel.fromJson({});
    } catch (e) {
      throw const GeneralException(message: "gagal Logout");
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      await dio.getRequest(ApiEndpoints.currentUser);
      return UserModel.fromJson({});
    } catch (e) {
      throw const GeneralException(message: "gagal GetCurrentUser");
    }
  }
}
