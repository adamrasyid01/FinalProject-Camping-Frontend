import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/splash/domain/repositories/splash_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepositoryImplementation extends SplashRepository {
  @override
  Future<Either<Failure, bool>> checkUserLoggedin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? userJson = prefs.getString('user');

      if (userJson != null && userJson.isNotEmpty) {
        print("BENER dari implementation splash");
        return Right(true); // User sudah login
      } else {
        print("SALAH dari implementation splash");
        return Right(false); // User belum login
      }
    } catch (e) {
      return Left(ServerFailure('Server ERROR')); // Tangani error
    }
  }
}
