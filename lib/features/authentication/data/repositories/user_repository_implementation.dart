import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/authentication/data/datasources/user_remote_datasource.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/entities/user.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImplementation extends UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImplementation({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      User user = await userRemoteDataSource.getCurrentUser();

      // Simpan ke shared preferences
      final prefs = await SharedPreferences.getInstance();
      String userJson = jsonEncode(user.toString()); // Gunakan `toJson()`
      await prefs.setString('user', userJson);

      return Right(user);
    } catch (e, stacktrace) {
      print("Error di getCurrentUser: $e");
      print("Stacktrace: $stacktrace");
      return Left(ServerFailure('Server Failure'));
    }
  }

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    try {
      User user = await userRemoteDataSource.login(username, password);
      return Right(user);
    } catch (e, stacktrace) {
      print("Error di login: $e");
      print("Stacktrace: $stacktrace");
      return Left(ServerFailure('Server Failure'));
    }
  }

  @override
  Future<Either<Failure, User>> logout() async {
    try {
      User user = await userRemoteDataSource.logout();
      return Right(user);
    } catch (e, stacktrace) {
      print("Error di logout: $e");
      print("Stacktrace: $stacktrace");
      return Left(ServerFailure('Server Failure'));
    }
  }

  @override
  Future<Either<Failure, User>> register(String name, String password,
      String email, String passwordConfirmation) async {
    try {
      User user = await userRemoteDataSource.register(
          name, email, password, passwordConfirmation);
      return Right(user);
    } catch (e, stacktrace) {
      print("Error di register: $e");
      print("Stacktrace: $stacktrace");
      return Left(ServerFailure('Server Failure'));
    }
  }
}
