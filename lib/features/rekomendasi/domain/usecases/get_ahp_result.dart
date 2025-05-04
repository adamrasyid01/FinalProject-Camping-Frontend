import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/ahp_result.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/repositories/ahp_result_repository.dart';

class 
GetAHPResult {
  final AHPResultRepository ahpResultRepository;

  GetAHPResult({required this.ahpResultRepository});

  Future<Either<Failure, List<AHPResult>>> execute(
      {int? locationId, int? rating, int page = 1, int limit = 10}) async {
    print("get ahp result usecase --------------------------------------");
    print(
        "locationId: $locationId, rating: $rating, page: $page, limit: $limit");
    // Call the repository to get the AHP result
    return await ahpResultRepository.getAHPResult(
        locationId: locationId, rating: rating, page: page, limit: limit);
  }
}
