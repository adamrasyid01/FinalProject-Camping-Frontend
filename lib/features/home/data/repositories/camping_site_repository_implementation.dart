import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/home/data/datasources/camping_site_remote_datasource.dart';
import 'package:flutter_camping_frontend/features/home/data/models/camping_site_model.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';
import 'package:flutter_camping_frontend/features/home/domain/repositories/camping_site_repository.dart';

class CampingSiteRepositoryImplementation extends CampingSiteRepository {
  final CampingSiteRemoteDataSource campingSiteRemoteDataSource;

  CampingSiteRepositoryImplementation({required this.campingSiteRemoteDataSource});

  @override
  Future<Either<Failure, List<CampingSite>>> getCampingSite(int locationId) async {
    List<CampingSiteModel> campingSite =
        await campingSiteRemoteDataSource.getCampingSite(locationId);
    return Right(campingSite);
  }
}
