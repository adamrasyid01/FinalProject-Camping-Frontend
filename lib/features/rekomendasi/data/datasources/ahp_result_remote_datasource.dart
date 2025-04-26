import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/models/ahp_result_model.dart';

abstract class AHPResultRemoteDatasource {
  Future<List<AHPResultModel>> getAHPResult();
}

class AHPResultRemoteDatasourceImpl extends AHPResultRemoteDatasource {
  final DioClient dio;

  AHPResultRemoteDatasourceImpl({required this.dio});
  @override
  Future<List<AHPResultModel>> getAHPResult() async {
    try {
      final response = await dio.getRequest(ApiEndpoints.ahpResults);

      final ahpResultData = response.data['result'];
      print(ahpResultData);
      // print('$response kddndknodnodnd');
      // print(
      //     '-----------------------------sudthgc----------------------------------------');
      return AHPResultModel.fromJsonList(ahpResultData).cast<AHPResultModel>();
    } catch (e) {
      throw Exception('Failed to load AHP results: $e');
    }
  }
}
