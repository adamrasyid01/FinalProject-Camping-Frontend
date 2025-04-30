
import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location.dart';
import 'package:flutter_camping_frontend/features/home/domain/repositories/camping_location_repository.dart';

class GetCampingLocation {
  final CampingLocationRepository campingLocationRepository;
  const GetCampingLocation({required this.campingLocationRepository});

  Future<Either<Failure, List<CampingLocation>>> execute({String filter = 'semua'}) async {
    return await campingLocationRepository.getCampingLocation(filter: filter);
  }
}