import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location_with_sites.dart';

abstract class CampingLocationWithSitesRepository {
  Future<Either<Failure, CampingLocationWithSites>> getCampingLocationWithSites(int locationId);
}
