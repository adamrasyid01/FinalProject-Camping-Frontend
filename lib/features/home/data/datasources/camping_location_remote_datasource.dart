import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/features/home/data/models/camping_location_model.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';

abstract class CampingLocationRemoteDataSource {
  Future<List<CampingLocationModel>> getCampingLocation(
      {String filter = 'semua'});
}

class CampingLocationRemoteDatasourceImplementation
    extends CampingLocationRemoteDataSource {
  final DioClient dio;

  CampingLocationRemoteDatasourceImplementation({required this.dio});
  @override
  Future<List<CampingLocationModel>> getCampingLocation({String filter = 'semua'}) async {
    try {
      // final token = await tokenStorage.getToken();
      final response = await dio.getRequest(ApiEndpoints.campingLocations(filter: filter));
      // print(response.data['result']);

      return CampingLocationModel.fromJsonList(response.data['result']);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
