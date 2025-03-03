import 'package:dartz/dartz.dart';
import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/core/services/token_storage.dart';
import 'package:flutter_camping_frontend/features/home/data/models/camping_location_model.dart';
import 'package:flutter_camping_frontend/features/home/domain/entities/camping_location.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';

abstract class CampingLocationRemoteDataSource {
  Future<List<CampingLocationModel>> getCampingLocation();
}

class CampingLocationRemoteDatasourceImplementation
    extends CampingLocationRemoteDataSource {
  final DioClient dio;
  final TokenStorage tokenStorage;

  CampingLocationRemoteDatasourceImplementation(
      {required this.dio, required this.tokenStorage});
  @override
  Future<List<CampingLocationModel>> getCampingLocation() async {
    try {
      // final token = await tokenStorage.getToken();
      final response = await dio.getRequest(ApiEndpoints.campingLocations);
      return CampingLocationModel.fromJsonList(response.data);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
