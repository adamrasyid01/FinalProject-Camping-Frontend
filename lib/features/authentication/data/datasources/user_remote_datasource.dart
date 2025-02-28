import 'package:dio/dio.dart';
import 'package:flutter_camping_frontend/core/error/exception.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/features/authentication/data/models/user_model.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<User> login(String email, String password);
  Future<User> register(String name, String email, String password);
  Future<User> logout();
  Future<User> getCurrentUser();
}

class UserRemoteDataSourceImplementation extends UserRemoteDataSource {
  final DioClient _dio;

  UserRemoteDataSourceImplementation(this._dio);
  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _dio.postRequest(
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
  Future<UserModel> register(String name, String email, String password) async{
   try {
      final response = await _dio.postRequest(
        ApiEndpoints.register,
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
  Future<UserModel> logout() async{
    try {
      await _dio.postRequest(ApiEndpoints.logout);
      return UserModel.fromJson({});
    } catch (e) {
      throw const GeneralException(message: "gagal Logout"); 
    }
  }

  @override
  Future<UserModel> getCurrentUser() async{
    try {
      await _dio.getRequest(ApiEndpoints.currentUser);
      return UserModel.fromJson({});
    } catch (e) {
      throw const GeneralException(message: "gagal GetCurrentUser");
    }
  }
}
