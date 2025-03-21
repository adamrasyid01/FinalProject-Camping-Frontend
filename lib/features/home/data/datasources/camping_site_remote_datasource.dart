import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/features/home/data/models/camping_location_model.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_camping_frontend/features/home/data/models/camping_site_model.dart';

abstract class CampingSiteRemoteDataSource {
  Future<List<CampingSiteModel>> getCampingSite(int locationId, {String? search});
}

class CampingSiteRemoteDataSourceImplementation
    extends CampingSiteRemoteDataSource {
  final DioClient dio;

  CampingSiteRemoteDataSourceImplementation({required this.dio});

  @override
  Future<List<CampingSiteModel>> getCampingSite(int locationId, {String? search}) async {
    try {
      final response =
          await dio.getRequest(ApiEndpoints.campingSites(locationId, search: search));
          print('INI URLNYA GIMANA ${dio.getRequest(ApiEndpoints.campingSites(locationId, search: search))}');
      // Ambil daftar camping_sites dari dalam result
      final campingSitesData = response.data['result']['camping_sites'];
      // print(campingSitesData);

      return CampingSiteModel.fromJsonList(campingSitesData).cast<CampingSiteModel>();
    } catch (e) {
      // print(stacktrace);
      throw ServerFailure(e.toString());
    }
  }
}
