
import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';
import 'package:flutter_camping_frontend/features/home/domain/repositories/camping_site_repository.dart';

class GetCampingSite {
  final CampingSiteRepository campingSiteRepository;
  const GetCampingSite({required this.campingSiteRepository});

  Future<Either<Failure, List<CampingSite>>> execute(int locationId, {String? search}) async {
    return await campingSiteRepository.getCampingSite(locationId, search:search);
  }
}