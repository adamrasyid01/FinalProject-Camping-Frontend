
import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/entities/user.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/repositories/user_repository.dart';

class Login{
  final UserRepository userRepository;
  const Login(this.userRepository);

  Future<Either<Failure, User>> execute(String email, String password) async {
    return await userRepository.login(email, password);
  }
}