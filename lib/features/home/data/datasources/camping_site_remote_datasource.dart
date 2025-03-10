import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/features/home/data/models/camping_location_model.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_camping_frontend/features/home/data/models/camping_site_model.dart';

abstract class CampingSiteRemoteDataSource {
  Future<List<CampingSiteModel>> getCampingSite(int locationId);
}

class CampingSiteRemoteDataSourceImplementation
    extends CampingSiteRemoteDataSource {
  final DioClient dio;

  CampingSiteRemoteDataSourceImplementation({required this.dio});

  @override
  Future<List<CampingSiteModel>> getCampingSite(int locationId) async {
    try {
     
      final response = await dio.getRequest(ApiEndpoints.campingSites);
      return CampingSiteModel.fromJsonList(response.data['result']);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
