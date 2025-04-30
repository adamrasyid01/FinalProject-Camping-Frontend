import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location.dart';

abstract class CampingLocationRepository {
  Future<Either<Failure, List<CampingLocation>>> getCampingLocation({String filter});
}
