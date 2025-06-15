import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';

abstract class CampingSiteRepository {
  Future<Either<Failure, List<CampingSite>>> getCampingSite(int locationId, {String? search, int limit = 10, int page = 1});
  Future<Either<Failure, CampingSite>> getDetailSite(int campingLocationId, int campingSiteId);
}
