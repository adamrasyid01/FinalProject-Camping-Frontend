import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/models/ahp_result_model.dart';

abstract class AHPResultRemoteDatasource {
  Future<List<AHPResultModel>> getAHPResult(
      {int? locationId, int? rating, required int page, required int limit});
}

class AHPResultRemoteDatasourceImpl extends AHPResultRemoteDatasource {
  final DioClient dio;

  AHPResultRemoteDatasourceImpl({required this.dio});
  @override
  Future<List<AHPResultModel>> getAHPResult(
      {int? locationId, int? rating, int page = 1, int limit = 10}) async {
    try {
      final response = await dio.getRequest(ApiEndpoints.ahpResults(
          locationId: locationId, rating: rating, page: page, limit: limit));

      print(
          'INI URLNYA GIMANA ${dio.getRequest(ApiEndpoints.ahpResults(locationId: locationId, rating: rating, page: page, limit: limit))}');
      return AHPResultModel.fromJsonList(response.data['result']);
    } catch (e) {
      throw Exception('Failed to load AHP results: $e');
    }
  }
}
