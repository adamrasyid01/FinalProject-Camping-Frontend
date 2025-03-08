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
  Future<Either<Failure, List<UserPreferenceCriteria>>> saveUserPreferenceCriteria(
      List<UserPreferenceCriteria> criteria) async {
    try {
       // Konversi List<UserPreferenceCriteria> menjadi List<UserPreferenceCriteriaModel>
      final criteriaModels = criteria
          .map((criteria) => UserPreferenceCriteriaModel(
              criteria_id: criteria.criteria_id, weight: criteria.weight))
          .toList();

      // Kirim daftar preferensi ke data source
      final result = await userPreferenceCriteriaRemoteDatasource
          .saveUserPreferenceCriteria(criteriaModels);

      return Right(result);
    } catch (e, stacktrace) {
      print("Error Saat menyimpan Preferensi Pengguna: $e");
      print("Stacktrace: $stacktrace");
      return Left(ServerFailure('Server Failure'));
    }
  }
}
