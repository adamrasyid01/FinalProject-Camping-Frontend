import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/core/services/token_storage.dart';
import 'package:flutter_camping_frontend/features/splash/domain/repositories/splash_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckUserLoggedin {
  final SplashRepository splashRepository;

  const CheckUserLoggedin({required this.splashRepository});
  Future<Either<Failure, void>> execute() async {
    return await splashRepository.checkUserLoggedin();
  }
}
