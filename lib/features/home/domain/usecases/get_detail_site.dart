

import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_site.dart';
import 'package:flutter_camping_frontend/features/home/domain/repositories/camping_site_repository.dart';

class GetDetailSite {
  final CampingSiteRepository campingSiteRepository;
  const GetDetailSite({required this.campingSiteRepository});

  Future<Either<Failure, CampingSite>> execute(int campingLocationId, int campingSiteId) async { 
    return await campingSiteRepository.getDetailSite(campingLocationId, campingSiteId);
  }
}