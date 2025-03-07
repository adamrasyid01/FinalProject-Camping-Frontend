import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/user_preference_criteria.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/repositories/user_preference_criteria_repository.dart';

class SaveUserPreferenceCriteria {
  final UserPreferenceCriteriaRepository userPreferenceCriteriaRepository;

  SaveUserPreferenceCriteria({required this.userPreferenceCriteriaRepository});

  Future<Either<Failure, UserPreferenceCriteria>> execute(UserPreferenceCriteria criteria) async {
    return await userPreferenceCriteriaRepository.saveUserPreferenceCriteria(criteria);
  }
}