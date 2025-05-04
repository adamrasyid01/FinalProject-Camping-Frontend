import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/datasources/ahp_result_remote_datasource.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/models/ahp_result_model.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/ahp_result.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/repositories/ahp_result_repository.dart';

class AHPResultRepositoryImpl extends AHPResultRepository {
  final AHPResultRemoteDatasource ahpResultRemoteDatasource;
  AHPResultRepositoryImpl({required this.ahpResultRemoteDatasource});
  @override
  Future<Either<Failure, List<AHPResult>>> getAHPResult(
      {int? locationId, int? rating, int page = 1, int limit = 10}) async {
    List<AHPResultModel> ahpResult =
        await ahpResultRemoteDatasource.getAHPResult(
            locationId: locationId, rating: rating, page: page, limit: limit);
    return Right(ahpResult);
  }
}
