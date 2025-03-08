import 'package:flutter_camping_frontend/core/error/failure.dart';
import 'package:flutter_camping_frontend/core/networks/api_endpoints.dart';
import 'package:flutter_camping_frontend/core/networks/dio_client.dart';
import 'package:flutter_camping_frontend/features/rekomendasi/data/models/user_preference_criteria_model.dart';

abstract class UserPreferenceCriteriaRemoteDatasource {
  Future<List<UserPreferenceCriteriaModel>> saveUserPreferenceCriteria(
      List<UserPreferenceCriteriaModel> criteriaList);
}

class UserPreferenceCriteriaRemoteDataSourceImplementation
    extends UserPreferenceCriteriaRemoteDatasource {
  final DioClient dio;

  UserPreferenceCriteriaRemoteDataSourceImplementation({required this.dio});

  @override
  Future<List<UserPreferenceCriteriaModel>> saveUserPreferenceCriteria(
      List<UserPreferenceCriteriaModel> criteriaList) async {
    try {
      // Ubah List<UserPreferenceCriteriaModel> menjadi List<Map<String, dynamic>>
      final List<Map<String, dynamic>> jsonData =
          criteriaList.map((criteria) => criteria.toJson()).toList();

      // Kirim request ke API
      final response = await dio.postRequest(
          ApiEndpoints.userPreferenceCriteria,
          data: {"preference_criteria": jsonData});

      // Pastikan response memiliki data yang benar
      if (response.data != null && response.data['result'] is List) {
        return (response.data['result'] as List)
            .map((item) => UserPreferenceCriteriaModel.fromJson(item))
            .toList();
      } else {
        throw ServerFailure("Invalid response format");
      }
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
