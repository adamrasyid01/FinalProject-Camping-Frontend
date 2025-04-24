import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/datasources/ahp_result_remote_datasource.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/models/ahp_result.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/ahp_result.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/repositories/ahp_result_repository.dart';

class AhpResultRepositoryImpl extends AHPResultRepository {
  final AhpResultRemoteDatasource ahpResultRemoteDatasource;
  AhpResultRepositoryImpl({required this.ahpResultRemoteDatasource});
  @override
  Future<Either<Failure, List<AHPResult>>> getAHPResult() async {
    // TODO: Implement the method logic
    List<AHPResultModel> ahpResult = await ahpResultRemoteDatasource.getAHPResult();
    return Right(ahpResult);
  }
}
