

import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/domain/entities/ahp_result.dart';

abstract class AHPResultRepository {
 Future<Either<Failure, List<AHPResult>>> getAHPResult();
}