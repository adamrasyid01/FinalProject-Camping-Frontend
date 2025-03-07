import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/user_preference_criteria.dart';

abstract class UserPreferenceCriteriaRepository {
  Future<Either<Failure, UserPreferenceCriteria>> saveUserPreferenceCriteria(
      UserPreferenceCriteria criteria);
}
