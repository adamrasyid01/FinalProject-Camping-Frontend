
import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location_with_sites.dart';
import 'package:flutter_camping_frontend/features/home/domain/repositories/camping_location_with_sites_repository.dart';

class GetCampingLocationWithSites {
  final CampingLocationWithSitesRepository campingLocationWithSites;
  const GetCampingLocationWithSites({required this.campingLocationWithSites});

  Future<Either<Failure, CampingLocationWithSites>> execute(int locationId) async {
    return await campingLocationWithSites.getCampingLocationWithSites(locationId);
  }
}