import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/authentication/domain/entities/user.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/datasources/user_preference_criteria_remote_datasource.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/models/user_preference_criteria_model.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/user_preference_criteria.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/repositories/user_preference_criteria_repository.dart';

class UserPreferenceCriteriaRepositoryImplementation
    extends UserPreferenceCriteriaRepository {
  final UserPreferenceCriteriaRemoteDatasource
      userPreferenceCriteriaRemoteDatasource;
  UserPreferenceCriteriaRepositoryImplementation(
      {required this.userPreferenceCriteriaRemoteDatasource});
  @override
  Future<Either<Failure, UserPreferenceCriteria>> saveUserPreferenceCriteria(
      UserPreferenceCriteria criteria) async {
    try {
      final criteriaModel = UserPreferenceCriteriaModel(
          id: criteria.id,
          user_preference_id: criteria.user_preference_id,
          criteria_id: criteria.criteria_id,
          weight: criteria.weight);
      final result = await userPreferenceCriteriaRemoteDatasource
          .saveUserPreferenceCriteria(criteriaModel);
      return Right(result);
    } catch (e, stacktrace) {
      print("Error Saat menyimpan Preferensi Pengguna: $e");
      print("Stacktrace: $stacktrace");
      return Left(ServerFailure('Server Failure'));
    }
  }
}
