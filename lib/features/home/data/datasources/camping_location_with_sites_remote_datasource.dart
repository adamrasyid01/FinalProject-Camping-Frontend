import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/features/home/data/models/camping_location_with_sites_model.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';

abstract class CampingLocationWithSitesRemoteDataSource {
  Future<CampingLocationWithSitesModel> getCampingLocationWithSites(
      int locationId);
}

class CampingLocationWithSitesRemoteDataSourceImplementation
    extends CampingLocationWithSitesRemoteDataSource {
  final DioClient dio;

  CampingLocationWithSitesRemoteDataSourceImplementation({required this.dio});

  @override
  Future<CampingLocationWithSitesModel> getCampingLocationWithSites(
      int locationId) async {
    try {
      final response =
          await dio.getRequest(ApiEndpoints.campingSites(locationId));

      // Cetak hasil parsing dari JSON ke model
      final model =
          CampingLocationWithSitesModel.fromJson(response.data['result']);
      print("Parsed Model: $model");

      return model;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
