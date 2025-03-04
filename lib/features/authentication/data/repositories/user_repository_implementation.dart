import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/authentication/data/datasources/user_remote_datasource.dart';
import 'package:flutter_camping_frontend/features/authentication/data/models/user_model.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/entities/user.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/repositories/user_repository.dart';

class UserRepositoryImplementation extends UserRepository {
  final UserRemoteDataSource userRemoteDataSource;

  UserRepositoryImplementation({required this.userRemoteDataSource});

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    try {
      UserModel user = await userRemoteDataSource.login(username, password);
      return Right(user);
    } catch (e, stacktrace) {
      print("Error di login: $e");
      print("Stacktrace: $stacktrace");
      return Left(ServerFailure('Server Failure'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await userRemoteDataSource.logout();
      return Right(null);
    } catch (e, stacktrace) {
      print("Error di logout: $e");
      print("Stacktrace: $stacktrace");
      return Left(ServerFailure('Server Failure'));
    }
  }

  @override
  Future<Either<Failure, User>> register(String name, String email,
      String password, String passwordConfirmation) async {
    try {
      UserModel user = await userRemoteDataSource.register(
          name, email, password, passwordConfirmation);
      return Right(user);
    } catch (e, stacktrace) {
      print("Error di register: $e");
      print("Stacktrace: $stacktrace");
      return Left(ServerFailure('Server Failure'));
    }
  }
}
