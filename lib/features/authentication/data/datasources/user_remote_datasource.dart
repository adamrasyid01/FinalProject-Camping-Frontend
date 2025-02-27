import 'package:flutter_camping_frontend/features/authentication/domain/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<User> login(String email, String password);
  Future<User> register(String name, String email, String password);
  Future<User> logout();
  Future<User> getCurrentUser();
}

class UserRemoteDataSourceImplementation extends UserRemoteDataSource {
  @override
  Future<User> login(String email, String password) async{
    throw UnimplementedError();
  }

  @override
  Future<User> register(String name, String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<User> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<User> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
}
