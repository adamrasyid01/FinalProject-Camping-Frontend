

import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/entities/user.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/repositories/user_repository.dart';

class GetCurrentUser {
  final UserRepository userRepository;
  const GetCurrentUser(this.userRepository);

  Future<Either<Failure, User>> execute() async {
    return await userRepository.getCurrentUser();
  }
}