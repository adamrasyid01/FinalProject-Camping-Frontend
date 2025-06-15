import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_camping_frontend/features/home/data/models/camping_site_model.dart';

abstract class CampingSiteRemoteDataSource {
  Future<List<CampingSiteModel>> getCampingSite(int locationId,
      {String? search, int limit, int page});
  Future<CampingSiteModel> getDetailSite(
      int campingLocationId, int campingSiteId);
}

class CampingSiteRemoteDataSourceImplementation
    extends CampingSiteRemoteDataSource {
  final DioClient dio;

  CampingSiteRemoteDataSourceImplementation({required this.dio});

  @override
  Future<List<CampingSiteModel>> getCampingSite(int locationId,
      {String? search, int limit = 10, int page = 1}) async {
    try {
      final response = await dio.getRequest(ApiEndpoints.campingSites(
          id: locationId, search: search, limit: limit, page: page));
      print(
          'INI URLNYA GIMANA ${dio.getRequest(ApiEndpoints.campingSites(id: locationId, search: search))}');
      // Ambil daftar camping_sites dari dalam result
      final campingSitesData = response.data['result'];
      print(campingSitesData);

      return CampingSiteModel.fromJsonList(response.data['result']);
    } catch (e) {
      // print(stacktrace);
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<CampingSiteModel> getDetailSite(
      int campingLocationId, int campingSiteId) async {
    try {
      final response = await dio.getRequest(
          ApiEndpoints.campingSiteDetail(campingLocationId, campingSiteId));
      return CampingSiteModel.fromJson(response.data['result']);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
