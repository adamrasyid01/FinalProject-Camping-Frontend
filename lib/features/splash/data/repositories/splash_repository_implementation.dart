import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/core/services/token_storage.dart';
import 'package:flutter_camping_frontend/features/splash/domain/repositories/splash_repository.dart';

class SplashRepositoryImplementation extends SplashRepository {
  final TokenStorage tokenStorage;

  SplashRepositoryImplementation({required this.tokenStorage});
  @override
  Future<Either<Failure, void>> checkUserLoggedin() async {
    try {
      String? token =
          await tokenStorage.getToken(); // Gunakan TokenStorageService

      if (token != null && token.isNotEmpty) {
        return Right(null);
      } else {
        return Left(ServerFailure('Tidak Punya token'));
      }
    } catch (e) {
      return Left(ServerFailure('Gagal mendapatkan status login'));
    }
  }
}
