import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/splash/domain/repositories/splash_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckUserLoggedin {
  final SplashRepository splashRepository;

  const CheckUserLoggedin({required this.splashRepository});
  Future<Either<Failure, bool>> execute() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool('is_logged_in') ?? false;
    return Right(isLoggedIn);
  }
}
