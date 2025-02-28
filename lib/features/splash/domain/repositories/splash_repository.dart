import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';

abstract class SplashRepository {
  Future<Either<Failure, bool>> checkUserLoggedin();
}
