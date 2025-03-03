import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/home/data/datasources/camping_location_remote_datasource.dart';
import 'package:flutter_camping_frontend/features/home/data/models/camping_location_model.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location.dart';
import 'package:flutter_camping_frontend/features/home/domain/repositories/camping_location_repository.dart';

class CampingLocationRepositoryImplementation
    extends CampingLocationRepository {
  final CampingLocationRemoteDataSource campingLocationDataSource;

  CampingLocationRepositoryImplementation(
      {required this.campingLocationDataSource});
  @override
  Future<Either<Failure, List<CampingLocation>>> getCampingLocation() async {
    List<CampingLocationModel> campingLocation =
        await campingLocationDataSource.getCampingLocation();
    return Right(campingLocation);
  }
}
