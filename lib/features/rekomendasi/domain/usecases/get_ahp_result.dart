

import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/ahp_result.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/repositories/ahp_result_repository.dart';

class GetAHPResult {
  final AHPResultRepository ahpResultRepository;

  GetAHPResult({required this.ahpResultRepository});

  Future<Either<Failure,List<AHPResult>>> execute() async {
   return await ahpResultRepository.getAHPResult();
    
  }
}