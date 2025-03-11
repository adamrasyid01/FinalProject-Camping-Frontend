import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/home/data/datasources/camping_location_with_sites_remote_datasource.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location_with_sites.dart';
import 'package:flutter_camping_frontend/features/home/domain/repositories/camping_location_with_sites_repository.dart';

class CampingLocationWithSitesRepositoryImplementation
    extends CampingLocationWithSitesRepository {
  final CampingLocationWithSitesRemoteDataSource campingLocationWithSitesRemoteDataSource;

  CampingLocationWithSitesRepositoryImplementation({
    required this.campingLocationWithSitesRemoteDataSource,
  });

  @override
  Future<Either<Failure, CampingLocationWithSites>> getCampingLocationWithSites(
      int locationId) async {
    try {
      final result = await campingLocationWithSitesRemoteDataSource.getCampingLocationWithSites(locationId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
