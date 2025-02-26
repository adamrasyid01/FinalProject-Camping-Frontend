

import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/entities/user.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/repositories/user_repository.dart';

class Register {
  final UserRepository userRepository;
  const Register(this.userRepository); 

  Future<Either<Failure, User>> execute(String name, String email, String password) async {
    return await userRepository.register(name, email, password);
  }

}