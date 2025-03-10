import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';

abstract class CampingSiteRepository {
  Future<Either<Failure, List<CampingSite>>> getCampingSite(int locationId);
}
