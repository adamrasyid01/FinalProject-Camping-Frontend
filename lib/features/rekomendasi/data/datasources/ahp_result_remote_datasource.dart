import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/models/ahp_result.dart';

abstract class AhpResultRemoteDatasource {
  Future<List<AHPResultModel>> getAHPResult();
}

class AhpResultImpl extends AhpResultRemoteDatasource {
  final DioClient dio;

  AhpResultImpl({required this.dio});
  @override
  Future<List<AHPResultModel>> getAHPResult() async {
    try {
      final response = await dio.getRequest(ApiEndpoints.ahpResults);
      print('$response kddndknodnodnd');
      return AHPResultModel.fromJsonList(response.data['data']);
    } catch (e) {
      throw Exception('Failed to load AHP results: $e');
    }
  }
}
