import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/repositories/user_repository.dart';

class Logout {
  final UserRepository userRepository;
  const Logout(this.userRepository);

  Future<Either<Failure, void>> execute() async {
    return await userRepository.logout();
  }
}
